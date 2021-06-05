clc;clear;
%讀取圖檔
[FN] = uigetfile({'*.jpg','JPEG (*.jpg;*.jpeg;*)';...
                  '*.png','PNG (*.png)';...
                  '*.bmp','BMP (*.bmp)';...
                  '*.tiff','TIFF (*.tiff)'},'開啟圖檔');
RGB = imread(FN);
I = rgb2gray(RGB);
figure(1);
subplot(2,3,2); imshow(RGB); title('Original');
subplot(2,3,3); imshow(I); title('Original to Gray');
% Roberts operators
I=double(I);
for i=1:size(I,1)-1;
    for j=1:size(I,2)-1;
        Gx1(i,j) = I(i,j) + I(i+1,j+1)*(-1);
        Gy1(i,j) = I(i+1,j)*(-1) + I(i,j+1);
    end
end
G1 = uint8(abs(Gx1+Gy1));

% Sobel operators
for i=1:size(I,1)-2;
    for j=1:size(I,2)-2;
        Gx2(i+1,j+1) = I(i,j)*(-1) + I(i+2,j) + I(i,j+1)*(-2)...
            + I(i+2,j+1)*2 + I(i,j+2)*(-1) + I(i+2,j+2);
        Gy2(i+1,j+1) = I(i,j) + I(i+1,j)*2 + I(i+2,j) + I(i,j+2)*(-1)...
            + I(i+1,j+2)*(-2) + I(i+2,j+2)*(-1);
    end
end
G2 = uint8(abs(Gx2+Gy2));

% LOG(Laplacian of Gaussian) operators
for i=1:size(I,1)-2;
   for j=1:size(I,2)-2;
      Gx3(i,j) = I(i,j) + I(i+1,j) + I(i+2,j) + I(i,j+1) + I(i+1,j+1)*(-8)...
          + I(i+2,j+1) + I(i,j+2) + I(i+1,j+2) + I(i+2,j+2);
   end
end
G3 = uint8(abs(Gx3));

subplot(2,3,4); imshow(G1); title('Roberts operators');
subplot(2,3,5); imshow(G2); title('Sobel operators');
subplot(2,3,6); imshow(G3); title('LOG operators');
saveas(figure(1),'CV_HW5_1_M1045509','jpg');
