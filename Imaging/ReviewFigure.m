%%
% Get venn diagram code from here
% Benjamin Kraus (2025). Venn Euler Diagram, MATLAB Central File Exchange.
% https://se.mathworks.com/matlabcentral/fileexchange/98974-venn-euler-diagram
% Add then the respective path down here
addpath('venn')
figure('color',[1 1 1],...
    'renderer','painters',...   
    'Units','centimeters',...
    'position',[3 4 10 12],...
    'PaperUnits','centimeters',...
    'PaperSize',[10 12],...
    'visible','on')

A = find(IDresp(:,3)==1 & IDresp(:,1)==1);
B = find(IDresp(:,2)==1 & IDresp(:,1)==1);
C = find(IDresp(:,4)==1 & IDresp(:,1)==1);
D = find(IDresp(:,5)==1 & IDresp(:,1)==1);
setListData = {A B C D};
setLabels = ["Shuffle";"Info Score";  "glm"; "ROC"];
h = vennEulerDiagram(setListData, setLabels, 'drawProportional', true);
h.TitleText = 'Responder defintions with threshold';
print(gcf, '-dpdf', 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\eNeuro-review\ReviewFigures\RespDefWithThres')


figure('color',[1 1 1],...
    'renderer','painters',...   
    'Units','centimeters',...
    'position',[3 4 10 12],...
    'PaperUnits','centimeters',...
    'PaperSize',[10 12],...
    'visible','on')

A = find(IDresp(:,3)==1 );
B = find(IDresp(:,2)==1 );
C = find(IDresp(:,4)==1 );
D = find(IDresp(:,5)==1 );
setListData = {A B C D};
setLabels = ["Shuffle";"Info Score";  "glm"; "ROC"];
h = vennEulerDiagram(setListData, setLabels, 'drawProportional', true);
h.TitleText = 'Responder defintions without threshold';
print(gcf, '-dpdf', 'C:\Users\martipof\IEECR Dropbox\Martin Pofahl\MPP - DG project\eNeuro-review\ReviewFigures\RespDef')

%%
figure('color',[1 1 1],...
    'renderer','painters',...   
    'Units','centimeters',...
    'position',[3 4 10 12],...
    'PaperUnits','centimeters',...
    'PaperSize',[10 12],...
    'visible','on')

ploto = [ axes('Units','centimeter');
        axes('Units','centimeter');
        axes('Units','centimeter');
        axes('Units','centimeter');
        axes('Units','centimeter');
        axes('Units','centimeter'); 
        axes('Units','centimeter')];



axes(ploto(1))
set(gca,'Position',[1 9 5 2]);

 