function [h,expr] = expression(pathname,filename)
%% Check different Channels

fnm = [pathname filename];

frames = length(imfinfo(fnm));
sz = get(0,'screensize');
h = figure('Name',['Expression using file ' filename],'Position',[0.1*sz(3) 0.3*sz(4) .8*sz(3) 0.5*sz(4)]);

if mod(frames,3) == 0
    a = imread(fnm,frames/3);
    b = imread(fnm,frames/3+1);
    c = imread(fnm,frames/3+2);

    subplot(1,3,1)
    imagesc(a)
    subplot(1,3,2)
    imagesc(b)
    subplot(1,3,3)
    imagesc(c)

    x = str2double(cell2mat(inputdlg('DAPI Channel')));
    y = str2double(cell2mat(inputdlg('mCherry Channel')));

    a = imread(fnm,frames/3+x-1); % dapi channel
    b = imread(fnm,frames/3+y-1); % mcherry channel
else
    a = imread(fnm,1);
    b = imread(fnm,2);
    subplot(1,2,1)
    imagesc(a)
    subplot(1,2,2)
    imagesc(b)
    x = str2double(cell2mat(inputdlg('DAPI Channel')));
    y = str2double(cell2mat(inputdlg('mCherry Channel')));
    a = imread(fnm,x); % dapi channel
    b = imread(fnm,y); % mcherry channel
end

delete(h)

%% reference picture in dapi channel

sz = get(0,'screensize');
h = figure('Name',['Expression using file ' filename],'Position',[0.3*sz(3) 0.14*sz(4) .35*sz(3) 0.7*sz(4)]);
subplot(2,3,[1 2])
imagesc(a)
hold on

%% Get line through stratum moleculare

[x,y] = getline(gcf);
x = round(x);
y = round(y);
plot(x,y,'g')

x1 = [x(1) x(1)];
y1 = [y(1) y(2)];

%% measure angle of line 

l1 = sqrt(((x(2)-x(1))^2+(y(2)-y(1))^2));
l11 = sqrt(((x1(2)-x1(1))^2+(y1(2)-y1(1))^2));
phi = acos(l11/l1);
if (x(2) < x(1) && y(2)>y(1)) || (x(2) > x(1) && y(2) < y(1))
    phi = abs(phi - pi);
end
phi1 = phi*180/pi;

%% calculate rectangle ROI
w = round(l1/8);
x1 = [x(1)+round(w*cos(phi)) x(1)-round(w*cos(phi)) x(2)-round(w*cos(phi)) x(2)+round(w*cos(phi)) x(1)+round(w*cos(phi))];
y1 = [y(1)-round(w*sin(phi)) y(1)+round(w*sin(phi)) y(2)+round(w*sin(phi)) y(2)-round(w*sin(phi)) y(1)-round(w*sin(phi))];
plot(x1,y1,'r')
rect = [x1; y1];

%% Cut out ROI in both channels

c = b(min(y1):max(y1),min(x1):max(x1));
d = imrotate(c,-phi1);
xm = round(length(d(1,:))/2);
ym = round(length(d(:,1))/2);
a1 = d(ym-round(l1/2):ym+round(l1/2),xm-w:xm+w);
c = a(min(y1):max(y1),min(x1):max(x1));
d = imrotate(c,-phi1);
a2 = d(ym-round(l1/2):ym+round(l1/2),xm-w:xm+w);

h1 = subplot(2,3,6);
imagesc(a1)

h2 = subplot(2,3,3);
imagesc(a2)



%% plot each step
% 
% figure
% c = a(min(y1):max(y1),min(x1):max(x1));
% imagesc(c)
% hold on
% x1 = x1-min(x1)+1;
% y1 = y1-min(y1)+1;
% plot(x1,y1,'r')
% 
% figure
% d = imrotate(c,-phi1);
% xm = round(length(d(1,:))/2);
% ym = round(length(d(:,1))/2);
% x1 = [xm-w xm+w xm+w xm-w xm-w];
% y1 = [ym-l1/2 ym-l1/2 ym+l1/2 ym+l1/2 ym-l1/2 ];
% imagesc(d)
% hold on
% plot(x1,y1,'r')
% 
% figure
% e = d(ym-round(l1/2):ym+round(l1/2),xm-w:xm+w);
% imagesc(e)


%% get top and bottom line of stratum moleculare in dapi ROI

[x,y] = getline(h2);
x = round(x);
y = round(y);
top1 = zeros(length(x)+2,2);
top1(1,:) = [1 y(1)];
top1(2:end-1,1) = x;
top1(2:end-1,2) = y;
top1(end,:) = [length(a1(1,:)),y(end)];

top = zeros(length(a1(1,:)),1);
for i = 1:length(x)+1
    xx = top1(i,1):top1(i+1);
    m = (top1(i+1,2)-top1(i,2))/(top1(i+1,1)-top1(i,1));
    b = top1(i,2)-(top1(i,1)*m);
    top(xx,1) = round(xx*m + b);   
end

subplot(h2)
hold on
plot(top,'g');

subplot(h1)
hold on
plot(top,'g');


[x,y] = getline(h2);
x = round(x);
y = round(y);
bottom1 = zeros(length(x)+2,2);
bottom1(1,:) = [1 y(1)];
bottom1(2:end-1,1) = x;
bottom1(2:end-1,2) = y;
bottom1(end,:) = [length(a1(1,:)),y(end)];

bottom = zeros(length(a1(1,:)),1);
for i = 1:length(x)+1
    xx = bottom1(i,1):bottom1(i+1);
    m = (bottom1(i+1,2)-bottom1(i,2))/(bottom1(i+1,1)-bottom1(i,1));
    b = bottom1(i,2)-(bottom1(i,1)*m);
    bottom(xx,1) = round(xx*m + b);   
end

if isnan(bottom(end))
    bottom(end) = bottom(end-1);
    top(end) = top(end-1);
end

subplot(h2)
hold on
plot(bottom,'g');

subplot(h1)
hold on
plot(bottom,'g');

%% calculate expression in mCherry channel
x = max(bottom-top);
if x(1)<0
    top1 = top;
    top = bottom;
    bottom = top1;
end

ex1 = zeros(max(bottom-top),length(top));
for i = 1:length(top)
    df = (length(ex1)-bottom(i)+top(i))/2;
    ex1(floor(df)+1:end-ceil(df)+1,i) = a1(top(i):bottom(i),i);
end

ex1 = mean(ex1,2);
ex = zeros(length(ex1),3);
ex(:,1) = 1/length(ex1):1/length(ex1):1;
ex(:,2) = ex1/max(ex1);
ex(ex(:,2)>0.37,3) = 1;

%%
subplot(2,3,[4 5])
plot(ex(:,1),ex(:,2),ex(:,1),ex(:,3))
axis tight
grid on
hold off

% y = ex(ex(:,3)==1,1);
% ex1 = [y(1) y(end)];

%%

expr = struct('path',pathname,'file',filename,'a',a,'mCherry',a1,'dapi',a2,'rect',rect,'bottom',bottom,'top',top,'ex',ex);

end
