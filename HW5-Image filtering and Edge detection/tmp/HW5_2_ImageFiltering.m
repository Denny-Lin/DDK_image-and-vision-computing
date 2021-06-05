clc;clear;
%讀取圖檔
[FN] = uigetfile({'*.jpg','JPEG (*.jpg;*.jpeg;*)';...
                  '*.png','PNG (*.png)';...
                  '*.bmp','BMP (*.bmp)';...
                  '*.tiff','TIFF (*.tiff)'},'開啟圖檔');
RGB = imread(FN);
I = rgb2gray(RGB);
figure(1);
subplot(3,4,2); imshow(RGB); title('Original');
subplot(3,4,3); imshow(I); title('Original to Gray');
%%
I=double(I);
% Mean filter
n = 3; %遮罩大小
for i=1:size(I,1)-n+1;
    for j=1:size(I,2)-n+1;
        k1 = sum(sum(I(i:i+(n-1),j:j+(n-1)))); %遮罩範圍總和
        k2(i+(n-1)/2,j+(n-1)/2) = k1 / (n*n); %中心點更新
    end
end
D1 = uint8(k2);  
subplot(3,4,5); imshow(D1); title('Mean filter');

% Median filter
for i=1:size(I,1)-n+1;
    for j=1:size(I,2)-n+1;
        k3 = median(median(I(i:i+(n-1),j:j+(n-1)))); %遮罩範圍中值
        k4(i+1,j+1) = k3; %中心點更新
    end
end
D2 = uint8(k4); 
subplot(3,4,9); imshow(D2); title('Median filter');
%%
I1 = double(D1);  % Mean filter
I2 = double(D2);  % Median filter
% Roberts operators
for i=1:size(I1,1)-1;
    for j=1:size(I1,2)-1;
        Gx1(i,j) = I1(i,j) + I1(i+1,j+1)*(-1);
        Gy1(i,j) = I1(i+1,j)*(-1) + I1(i,j+1);
        Gx4(i,j) = I2(i,j) + I2(i+1,j+1)*(-1);
        Gy4(i,j) = I2(i+1,j)*(-1) + I2(i,j+1);
    end
end
G1 = uint8(abs(Gx1+Gy1));
G4 = uint8(abs(Gx4+Gy4));

% Sobel operators
for i=1:size(I1,1)-2;
    for j=1:size(I1,2)-2;
        Gx2(i,j) = I1(i,j)*(-1) + I1(i+2,j) + I1(i,j+1)*(-2)...
            + I1(i+2,j+1)*2 + I1(i,j+2)*(-1) + I1(i+2,j+2);
        Gy2(i,j) = I1(i,j) + I1(i+1,j)*2 + I1(i+2,j) + I1(i,j+2)*(-1)...
            + I1(i+1,j+2)*(-2) + I1(i+2,j+2)*(-1);
        Gx5(i,j) = I2(i,j)*(-1) + I2(i+2,j) + I2(i,j+1)*(-2)...
            + I2(i+2,j+1)*2 + I2(i,j+2)*(-1) + I2(i+2,j+2);
        Gy5(i,j) = I2(i,j) + I2(i+1,j)*2 + I2(i+2,j) + I2(i,j+2)*(-1)...
            + I2(i+1,j+2)*(-2) + I2(i+2,j+2)*(-1);
    end
end
G2 = uint8(abs(Gx2+Gy2));
G5 = uint8(abs(Gx5+Gy5));

% LOG(Laplacian of Gaussian) operators
for i=1:size(I1,1)-2;
   for j=1:size(I1,2)-2;
      Gx3(i,j) = I1(i,j) + I1(i+1,j) + I1(i+2,j) + I1(i,j+1) + I1(i+1,j+1)*(-8)...
          + I1(i+2,j+1) + I1(i,j+2) + I1(i+1,j+2) + I1(i+2,j+2);
      Gx6(i,j) = I2(i,j) + I2(i+1,j) + I2(i+2,j) + I2(i,j+1) + I2(i+1,j+1)*(-8)...
          + I2(i+2,j+1) + I2(i,j+2) + I2(i+1,j+2) + I2(i+2,j+2);
   end
end
G3 = uint8(abs(Gx3));
G6 = uint8(abs(Gx6));
%%
subplot(3,4,6); imshow(G1); title({['Mean filter']; ['+ Roberts operators']});
subplot(3,4,7); imshow(G2); title({['Mean filter']; ['+ Sobel operators']});
subplot(3,4,8); imshow(G3); title({['Mean filter']; ['+ LOG operators']});

subplot(3,4,10); imshow(G4); title({['Median filter']; ['+ Roberts operators']});
subplot(3,4,11); imshow(G5); title({['Median filter']; ['+ Sobel operators']});
subplot(3,4,12); imshow(G6); title({['Median filter']; ['+ LOG operators']});
saveas(figure(1),'CV_HW5_2_M1035502','jpg');
