function out = rank_mixed_permutation(tbl, lmeFormula, varargin)
% RANK_MIXED_PERMUTATION Fit rank-transformed LMM + permutation inference
%
% out = rank_mixed_permutation(tbl, lmeFormula)
% out = rank_mixed_permutation(..., 'RankType','pooled'|'within', 'nperm',1000, 'stat','tstat'|'coef')
%
% Inputs:
%   tbl         - MATLAB table with at least variables: Response, Condition, Animal, Neuron
%   lmeFormula  - string formula for fitlme applied to the rank response

% Options:
%   'RankType'  - 'pooled' (default) or 'within' (rank within each Animal)
%   'nperm'     - number of permutations (default 1000)
%   'stat'      - statistic to use for permutation: 'tstat' (default) or 'coef' (uses fixed-effect estimate)
%
% Output struct out:
%   out.lme_obs       - fitted LinearMixedModel on observed ranks
%   out.rankType      - chosen rank type
%   out.Tobs          - observed statistic (t-stat or coefficient)
%   out.Tperm         - permutation distribution (nperm x 1)
%   out.p_perm        - permutation p-value (two-sided, (k+1)/(nperm+1) correction)
%   out.nperm         - number of permutations
%   out.stat_choice   - 'tstat' or 'coef'
%   out.tbl_ranked    - input table with RankResponse column
%   out.errorLog      - cell array of errors encountered during permutation fits
%
% Example:
%   out = rank_mixed_permutation(tbl, 'RankResponse ~ Condition + (1|Animal) + (1|Animal:Neuron)', 'RankType','within','nperm',1000);

% parse inputs
p = inputParser;
addParameter(p,'RankType','pooled', @(x) ismember(x,{'pooled','within'}));
addParameter(p,'nperm',1000, @(x) isnumeric(x) && x>=0);
addParameter(p,'stat','tstat', @(x) ismember(x,{'tstat','coef'}));
parse(p, varargin{:});
rankType = p.Results.RankType;
nperm = round(p.Results.nperm);
statChoice = p.Results.stat;

% basic checks
requiredVars = {'Response','Condition','Animal','Neuron'};
for v = requiredVars
    if ~ismember(v{1}, tbl.Properties.VariableNames)
        error('tbl must contain variable: %s', v{1});
    end
end
% ensure categorical
tbl.Condition = categorical(tbl.Condition);
tbl.Animal = categorical(tbl.Animal);
tbl.Neuron = categorical(tbl.Neuron);

% Compute ranks
switch rankType
    case 'pooled'
        tbl.RankResponse = tiedrank(tbl.Response); % pooled tied ranks
    case 'within'
        tbl.RankResponse = nan(height(tbl),1);
        animals = categories(tbl.Animal);
        for i = 1:numel(animals)
            mask = tbl.Animal == animals{i};
            tbl.RankResponse(mask) = tiedrank(tbl.Response(mask));
        end
    otherwise
        error('Unknown RankType.');
end

% Fit observed model on ranks
try
    lme_obs = fitlme(tbl, lmeFormula);
catch ME
    error('fitlme on observed ranked data failed: %s', ME.message);
end

% choose observed statistic
switch statChoice
    case 'tstat'
        % get t-stat for the fixed effect(s) except intercept (user may have multiple fixed terms)
        % here we take the t-stat of the first non-intercept fixed effect by default.
        % fe = dataset2struct(table(fixedEffects(lme_obs)));
        % better: use lme_obs.Coefficients to find tStat for the fixed effect of interest
        coeffs = lme_obs.Coefficients;
        % choose the first row that is not '(Intercept)' as the tested effect
        idx = find(~strcmp(coeffs.Name,'(Intercept)'), 1, 'first');
        if isempty(idx)
            error('No non-intercept fixed effect found in model coefficients.');
        end
        Tobs = coeffs.tStat(idx);
        targetCoefName = coeffs.Name{idx};
    case 'coef'
        coeffs = lme_obs.Coefficients;
        idx = find(~strcmp(coeffs.Name,'(Intercept)'), 1, 'first');
        if isempty(idx)
            error('No non-intercept fixed effect found in model coefficients.');
        end
        Tobs = coeffs.Estimate(idx);
        targetCoefName = coeffs.Name{idx};
    otherwise
        error('Unknown statChoice.');
end

% Permutation: permute Condition labels within each animal.
Tperm = nan(nperm,1);
% errlog = {};
rng('shuffle');
parfor t = 1:nperm
    % new table copy
    tblp = tbl;
    animals = categories(tblp.Animal);
    for i = 1:numel(animals)
        mask = tblp.Animal == animals{i};
        % Permute the Condition labels among the rows that belong to this animal
        % This preserves the within-animal clustering and any between-animal structure.
        origConds = tblp.Condition(mask);
        permIdx = randperm(sum(mask));
        tblp.Condition(mask) = origConds(permIdx);
    end
    % Recompute ranks for this permutation depending on ranking strategy:
    switch rankType
        case 'pooled'
            tblp.RankResponse = tiedrank(tblp.Response);
        case 'within'
            tblp.RankResponse = nan(height(tblp),1);
            for i = 1:numel(animals)
                mask = tblp.Animal == animals{i};
                tblp.RankResponse(mask) = tiedrank(tblp.Response(mask));
            end
    end

    % fit model; catch possible errors (singular fits)
    try
        lme_p = fitlme(tblp, lmeFormula);
        coeffs_p = lme_p.Coefficients;
        idx_p = find(~strcmp(coeffs_p.Name,'(Intercept)'), 1, 'first');
        if isempty(idx_p)
            error('No non-intercept fixed effect in permuted fit (unexpected).');
        end
        switch statChoice
            case 'tstat'
                Tperm(t) = coeffs_p.tStat(idx_p);
            case 'coef'
                Tperm(t) = coeffs_p.Estimate(idx_p);
        end
    catch ME
        % store NaN and the error text
        Tperm(t) = NaN;
        % errlog{end+1} = sprintf('Perm %d failed: %s', t, ME.message);
    end
end

% remove NaNs from Tperm when computing p-value (but count them in report)
valid = ~isnan(Tperm);
nvalid = sum(valid);
if nvalid == 0
    warning('All permutations failed to fit the model.');
    p_perm = NaN;
else
    % two-sided p: proportion of permuted stats as or more extreme than observed
    p_perm = (sum(abs(Tperm(valid)) >= abs(Tobs)) + 1) / (nvalid + 1);
end

% pack output
out = struct();
out.lme_obs = lme_obs;
out.rankType = rankType;
out.Tobs = Tobs;
out.Tperm = Tperm;
out.p_perm = p_perm;
out.nperm = nperm;
out.stat_choice = statChoice;
out.tbl_ranked = tbl;
% out.errorLog = errlog;
out.targetCoefName = targetCoefName;

end
