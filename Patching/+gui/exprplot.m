function h = exprplot(expr)

a = expr.a;
a1 = expr.mCherry;
a2 = expr.dapi;
ex = expr.ex;
rect = expr.rect;
top = expr.top;
bottom = expr.bottom;
filename = expr.file;

% h = figure('Position',[680   162   652   816]);
sz = get(0,'screensize');
h = figure('Name',['Expression using file ' filename],'Position',[0.3*sz(3) 0.14*sz(4) .35*sz(3) 0.7*sz(4)]);


brightness = .55;
contrast = .45;

contrast = contrast^0.25;
if contrast < 0.5
    m = 2*contrast/255;
else
    m = 1/(510-510*contrast+eps);
end
if brightness < 0.5
    b = -255*m*(1-(2*brightness)^0.25);
else
    b = 2*brightness-1;
end

cc = (1:255)*m+b;
cc(cc<0)=0;
cc(cc>1)=1;

rmap = zeros(255,3);
rmap(:,1) = cc';
bmap = zeros(255,3);
bmap(:,3) = cc';




subplot(2,3,[1 2])
imagesc(a)
colormap(bmap)
freezeColors
hold on
axis off
plot(rect(1,:),rect(2,:),'r')
hold off

subplot(2,3,6);
imagesc(a1)
colormap(rmap)
freezeColors
hold on
axis off
plot(top,'g');
plot(bottom,'g');
hold off

subplot(2,3,3);
imagesc(a2);
colormap(bmap)
freezeColors
hold on
axis off
plot(top,'g');
plot(bottom,'g');
hold off

subplot(2,3,[4 5])
plot(ex(:,1),ex(:,2),ex(:,1),ex(:,3))
axis tight
grid on
hold off
ylabel('mCherry Expression')
xlabel('Stratum Moleculare')

end