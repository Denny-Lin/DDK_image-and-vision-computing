clc;clear;
%讀取圖檔
DV1 = imread('wall01.jpg');
DV2 = imread('hand01.jpg');
DV3 = imread('hand02.jpg');
DV4 = imread('hand03.jpg');
DV5 = imread('hand04.jpg');
DV6 = imread('hand05.jpg');

gDV1 = rgb2gray(DV1);
gDV2 = rgb2gray(DV2);
gDV3 = rgb2gray(DV3);
gDV4 = rgb2gray(DV4);
gDV5 = rgb2gray(DV5);
gDV6 = rgb2gray(DV6);
gDVarray = [gDV1 gDV2 gDV3 gDV4 gDV5 gDV6]; % 將所有影像存到同一矩陣

gDVdiff = [];
gDVdiffarray = [];
gDVtotal = [];
gDVtotal2 = zeros(size(gDV1));

% 所有連續影像間的差異值
startX = 1; startY = 1;
endX = size(gDV1,1); endY = size(gDV1,2); % size = 240*320
while startY < size(gDVarray,2) - size(gDV1,2) + 1 % 1920-320+1=1601(五張圖)
    for i = startX : endX
        for j = startY : endY
            gDVdiff(i,j) = abs(gDVarray(i,j+320) - gDVarray(i,j));
        end
    end
    gDVdiffarray = [gDVdiffarray gDVdiff];
    startY = startY + size(gDV1,2); % 1+320(右移到下一張圖起始位置)
end

% 所有連續影像間的差異值(總和)
startX = 1; startY = 1;
endX = size(gDV1,1); endY = size(gDV1,2); % size = 240*320
while startY < size(gDVdiffarray,2) - size(gDV1,2) + 1 % 1600-320+1=1601(四張圖)
    for i = startX : endX
        for j = startY : endY
            gDVtotal(i,j) = gDVdiffarray(i,j+320) + gDVdiffarray(i,j);
        end
    end
    gDVtotal2 = gDVtotal2 + gDVtotal;
    startY = startY + size(gDV1,2); % 1+320(右移到下一張圖起始位置)
end

figure(1); image(gDVtotal2); title('for loop');
saveas(figure(1),'CV_HW6_1_M1035502-01(for loop)','jpg');

% 硬淦
aa=gDV2-gDV1;
bb=gDV3-gDV2;
cc=gDV4-gDV3;
dd=gDV5-gDV4;
ee=gDV6-gDV5;
ff=aa+bb+cc+dd+ee;
figure(2); image(bb); title('Hard dry');
saveas(figure(2),'CV_HW6_1_M1035502-02(Hard dry)','jpg');

% 所有連續影像間的差異值(查看)
% aaa=gDVdiffarray(1:240,1:320);
% bbb=gDVdiffarray(1:240,321:640);
% ccc=gDVdiffarray(1:240,641:960);
% ddd=gDVdiffarray(1:240,961:1280);
% eee=gDVdiffarray(1:240,1281:1600);
% fff=aaa+bbb+ccc+ddd+eee;
% figure(3); image(bbb); title('checking');
