%% Load data
% Data for control condition without air puff
CUE = load('CAIM-Baseline.mat');
CUE = CUE.CAIM;
% Data with air puff sessions
load('CAIM-AP.mat')
% Shuffled data set
load('Shuf')
% Load Different defintion of Df/F and deconvoltion with CASCADE (Not used
% in the paper, but nice to have)
load('CS.mat')

%% Set constants for plotting
mouse_id = {'M103' 'M155' 'M158' 'M194' 'M195' 'M224' 'M226' 'M227' 'M229' 'M234'};
my_plt.ftsz = 10;
my_plt.lnwd = 1;


% Choose mice and session included
numice = [1:8 10];
numexp = 1;

% Number of minimum standard deviations as significance threshold
stdsig = 1;

% Global axis limits for reponses curves
my_plt.XLim = [-1 3];
my_plt.YLimEx = [-5 25];
my_plt.YLimIn = [-4 4];
my_plt.YLimPup = [-0.04 0.035];%[-0.05 0.025];
my_plt.YLimSp = [-.01 .15];
my_plt.YLimMPP = [.85 1.35];

% Color set used in the paper
my_plt.mycol = [119,169,180;
    72,136,163;
    237,184,30;
    209,156,44;
    211,47,38;
    175,175,175]./255; 

%% re-do shuffling and responder defintion with chosen method.
% Set the criteria of choice to "true". For the paper ROC was used.

re_define = true;
do_plot = false;
do_save = false;

% Set a fixed or dynamic threshold
thresh_crit = false;
thresh_in = 0.05;

% Criterion comparing each response to a shuffled distribution and using
% a set percentile
shuf_crit   = false;
percentile = 95;

% Cirterion using and mutual information score and comparing it to the
% distribtuion of scores from the entire population
info_crit   = false;

% Fitting a GLM model to the traces and chosing the cells that contribute
% most to the glm 
glm_crit    = false;

% Calculating receiver operator caracterisitics for every cell and
% comparing the resulting curves to shuffled data.
roc_crit    = true;

[CAIM,Shuf,~,~,IDresp,ROC]  = helpers.APshuffle(CAIM,thresh_in,percentile,re_define,do_plot,do_save,shuf_crit,info_crit,glm_crit,thresh_crit,roc_crit,mouse_id,'airpuff');
[CUE,~,~,~,~,~]             = helpers.APshuffle(CUE ,thresh_in,percentile,re_define,do_plot,do_save,shuf_crit,info_crit,glm_crit,thresh_crit,roc_crit,mouse_id,'runonset');

%% Example data for a single color animal 
figure1_singleColor
%% Example data for a dual color animal
figure1_dualColor
%% Response curves for different scenarios
figure2                                                        
%% Responses caracteristics
figure3
%% Dual color cross correlation and noise correlation analysis
figure4
%% Venn diagrams comparing different responder defintions 
ReviewFigure