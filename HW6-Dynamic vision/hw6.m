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

DV21=gDV2-gDV1;
DV32=gDV3-gDV2;
DV43=gDV4-gDV3;
DV54=gDV5-gDV4;
DV65=gDV6-gDV5;
ff=DV21+DV32+DV43+DV54+DV65;
figure(2); image(DV32); title('Hard dry');
saveas(figure(2),'HW6_1_M1045509-02(Hard dry)','jpg');