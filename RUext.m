close all
clear all
clc

tic;
f = imread('5537.jpg');

[nor, noc] = size(f);
row = zeros(1,noc);
I = cat(1,f,row);
G1 = fspecial('gaussian',3,5);
C1 = imfilter(double(I),G1,'replicate');
level = graythresh(f);
Th = round(level*max(f(:)));
bin = mmthreshad(C1,Th);

Nume = 2;
E = mmero(bin,mmsecross(Nume));
Clo = mmclohole(E,mmsecross(1));
Off = mmedgeoff(Clo);
Open = mmareaopen(Off,17000);

new = Open(1:(nor-(Nume+1)),1:noc);
[newr, newc] = size(new);

Meanr = mean(new,2);
Meanc = mean(new,1);
[Maxc,Ic] = max(Meanc);

M1 = new(round(newr/2):newr,1:Ic);
[M1r,M1c] = size(M1);
MeanM1r = mean(M1,2);
[MinM1r,lm1] = min(MeanM1r);
k1 = find(M1(lm1,1:M1c),1);
v1 = k1-50;

M2 = new(round(newr/2):newr,Ic:newc);
[M2r,M2c] = size(M2);
MeanM2r = mean(M2,2);
[MinM2r,lm2] = min(MeanM2r);
k2 = find(~M2(lm2,1:M2c),1);
v2 = k2+Ic+50;

M3 = new(round(newr/2):newr,1:newc);
MeanM3c = mean(M3,1);
MeanM3r = mean(M3,2);
k3 = find(MeanM3r<=0.5);
v3 = round(newr/2)+k3(1)+250;

hold on; 
figure, imshow(f);
line([Ic,Ic],[1,nor]);
line([v1,v1],[1,nor]);
line([v2,v2],[1,nor]);
line([1,noc],[v3,v3]);
hold off;
RU = f(v3:nor,v1:v2);
figure, mmshow(RU);
toc;
