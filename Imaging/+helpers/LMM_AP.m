function [lmm] = LMM_AP(Resp_cells,RespG_cells,RespG_cells_mouse,condition1,condition2,paired)
    if paired == 1
        ind1 = strcmp(RespG_cells,condition1);
        ind2 = strcmp(RespG_cells,condition2);
        ind = false(size(RespG_cells,1),1);
        ind(ind1) = ~isnan(Resp_cells(ind1)) & ~isnan(Resp_cells(ind2));
        ind(ind2) = ~isnan(Resp_cells(ind1)) & ~isnan(Resp_cells(ind2));
    
        N = numel(Resp_cells(ind))/2;
        NeuronID = repmat((1:N)',2,1);
    else
        ind = strcmp(RespG_cells,condition1) | strcmp(RespG_cells,condition2);
        
        N = numel(Resp_cells(ind));
        NeuronID = (1:N)';
    end
    
    % Build a table    
    tbl = table(Resp_cells(ind),...
        RespG_cells(ind),...
        RespG_cells_mouse(ind), ...
        NeuronID, ...
        'VariableNames', {'Response','Condition','Animal','Neuron'});
    
    % Convert relevant columns to categorical
    tbl.Condition = categorical(tbl.Condition);
    tbl.Animal = categorical(tbl.Animal);
    tbl.Neuron = categorical(tbl.Neuron);
    
    lmeFormula = 'Response ~ Condition + (1|Animal) + (1|Animal:Neuron)';
    
    % lmm = [];
    % lmm.lme_obs = fitlme(tbl, lmeFormula);
    % lmm.p_perm = coefTest(lmm.lme_obs);
    lmm = rank_mixed_permutation(tbl, lmeFormula);

end

