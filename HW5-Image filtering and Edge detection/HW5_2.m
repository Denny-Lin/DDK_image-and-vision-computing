clc;clear;%f清畫布
[FN]=uigetfile({'*.jpg','JPEG (*.jpg;*.jpeg;*)';...
                  '*.png','PNG (*.png)';...
                  '*.bmp','BMP (*.bmp)';...
                  '*.tiff','TIFF (*.tiff)'},'開啟圖檔');
RGB = imread(FN);
gray = rgb2gray(RGB);
figure(1);
subplot(3,4,2); imshow(RGB); title('Original');
subplot(3,4,3); imshow(gray); title('Gray');

gray=double(gray);
% Mean filter
mask_n = 3; %遮罩大小
for i=1:size(gray,1)-mask_n+1;
    for j=1:size(gray,2)-mask_n+1;
        k1 = sum(sum(gray(i:i+(mask_n-1),j:j+(mask_n-1)))); %遮罩範圍總和
        k2(i+(mask_n-1)/2,j+(mask_n-1)/2) = k1 / (mask_n*mask_n); %中心點更新
    end
end
Mean = uint8(k2);  
subplot(3,4,5); imshow(Mean); title('Mean filter');

% Median filter
for i=1:size(gray,1)-mask_n+1;
    for j=1:size(gray,2)-mask_n+1;
        k3 = median(median(gray(i:i+(mask_n-1),j:j+(mask_n-1)))); %遮罩範圍中值
        k4(i+1,j+1) = k3; %中心點更新
    end
end
Median = uint8(k4); 
subplot(3,4,9); imshow(Median); title('Median filter');

I1 = double(Mean);  % Mean filter
I2 = double(Median);  % Median filter

%Roberts   
Mean_Roberts = edge(I1, 'Roberts');
Median_Roberts = edge(I2, 'Roberts');
%Sobel
Mean_Sobel = edge(I1, 'sobel');
Median_Sobel = edge(I2, 'sobel');
%LoG operators
Mean_LoG = edge(I1, 'log');
Median_LoG = edge(I2, 'log');

subplot(3,4,6); imshow(Mean_Roberts); title({['Mean']; ['+ Roberts']});
subplot(3,4,7); imshow(Mean_Sobel); title({['Mean']; ['+ Sobel']});
subplot(3,4,8); imshow(Mean_LoG); title({['Mean']; ['+ LOG']});

subplot(3,4,10); imshow(Median_Roberts); title({['Median']; ['+ Roberts']});
subplot(3,4,11); imshow(Median_Sobel); title({['Median']; ['+ Sobel']});
subplot(3,4,12); imshow(Median_LoG); title({['Median']; ['+ LOG']});

saveas(figure(1),'HW5_2_M1045509','jpg');