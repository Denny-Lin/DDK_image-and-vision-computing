clc; clear;

%讀取圖檔
a = imread('orange.jpg');
b = imread('apple.jpg');

%影像混和
c = imadd(a/2,b/2);

%顯示影像
figure(1); imshow(a);
figure(2); imshow(b);
figure(3); imshow(c);
% saveas(figure(3),'CV_HW1_M1035502','jpg');
saveas(figure(3),'CV_HW1_M1035502.jpg');

% Ctrl + R , Ctrl +T
% subplot(1,3,1); imshow(a);
% subplot(1,3,2); imshow(b);
% subplot(1,3,3); imshow(c);
% % subplot(1,3,3); imshow(a*0.5+b*0.5);
