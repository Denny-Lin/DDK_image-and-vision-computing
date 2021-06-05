clc;clear;

%% part.1

[FN] = uigetfile({'*.jpg','JPEG (*.jpg;*.jpeg;*)';...
                  '*.png','PNG (*.png)';...
                  '*.bmp','BMP (*.bmp)'},'開啟圖檔');

% Binarization
% rgb = imread('apple.jpg');
rgb = imread(FN);
threshold = input('請輸入閾值:');        %輸入閾值(0~255)
threshold = threshold / 255;            %設定閾值
Binary = im2bw(rgb,threshold);          %二值化轉換
% figure(1); imshow(rgb);                 
% figure(2); imshow(Binary);

%% part.2

% 膨脹和侵蝕（imerode和imdilate）

exp_imgA = zeros(size(Binary));     %水平處理LR
exp_imgB = zeros(size(Binary));     %垂直處理UD
exp_imgC = zeros(size(Binary));    %水平處理RL
exp_imgD = zeros(size(Binary));    %垂直處理DU
% expanding
for i=1:size(Binary,1);
    for j=1:size(Binary,2);
        
        if j < size(Binary,2)-2
            if Binary(i,j)==0 & Binary(i,j+1)==0 & Binary(i,j+2)==0 & Binary(i,j+3)==0
                exp_imgA(i,j) = 0;
            else
                exp_imgA(i,j) = 1;
            end
        end
        
        if i < size(Binary,1)-2
            if Binary(i,j)==0 & Binary(i+1,j)==0 & Binary(i+2,j)==0 & Binary(i+3,j)==0
                exp_imgB(i,j) = 0;
            else
                exp_imgB(i,j) = 1;
            end
        end
        
        if exp_imgA(i,j)==0 & exp_imgB(i,j)==0  %左上方向處理結合
            exp_imgB(i,j) = 0;
        else
            exp_imgB(i,j) = 1;
        end
        
    end
end

for i=size(Binary,1):-1:1;
    for j=size(Binary,2):-1:1;
        
        if j > 3
            if Binary(i,j)==0 & Binary(i,j-1)==0 & Binary(i,j-2)==0 & Binary(i,j-3)==0
                exp_imgC(i,j) = 0;
            else
                exp_imgC(i,j) = 1;
            end
        end
        
        if i > 3
            if Binary(i,j)==0 & Binary(i-1,j)==0 & Binary(i-2,j)==0 & Binary(i-3,j)==0
                exp_imgD(i,j) = 0;
            else
                exp_imgD(i,j) = 1;
            end
        end
        
        if exp_imgC(i,j)==0 & exp_imgD(i,j)==0  %右下方向處理結合
            exp_imgD(i,j) = 0;
        else
            exp_imgD(i,j) = 1;
        end
        
    end
end

exp_imgD = exp_imgB + exp_imgD;  %四方向處理結合

%%

shr_imgA = zeros(size(Binary));     %水平處理LR
shr_imgB = zeros(size(Binary));     %垂直處理UD
shr_imgC = zeros(size(Binary));     %水平處理RL
shr_imgD = zeros(size(Binary));     %垂直處理DU
% shrinking
for i=1:size(Binary,1);
    for j=1:size(Binary,2);
        
        if j < size(Binary,2)-2
            if Binary(i,j)==1 & Binary(i,j+1)==1 & Binary(i,j+2)==1 & Binary(i,j+3)==1
                shr_imgA(i,j) = 1;
            else
                shr_imgA(i,j) = 0;
            end
        end
        
        if i < size(Binary,1)-2
            if Binary(i,j)==1 & Binary(i+1,j)==1 & Binary(i+2,j)==1 & Binary(i+3,j)==1
                shr_imgB(i,j) = 1;
            else
                shr_imgB(i,j) = 0;
            end
        end
        
        if shr_imgA(i,j)==1 & shr_imgB(i,j)==1  %左上向處理結合
            shr_imgB(i,j) = 1;
        else
            shr_imgB(i,j) = 0;
        end
        
    end
end

for i=size(Binary,1):-1:1;
    for j=size(Binary,2):-1:1;
        
        if j > 3
            if Binary(i,j)==1 & Binary(i,j-1)==1 & Binary(i,j-2)==1 & Binary(i,j-3)==1
                shr_imgC(i,j) = 1;
            else
                shr_imgC(i,j) = 0;
            end
        end
        
        if i > 3
            if Binary(i,j)==1 & Binary(i-1,j)==1 & Binary(i-2,j)==1 & Binary(i-3,j)==1
                shr_imgD(i,j) = 1;
            else
                shr_imgD(i,j) = 0;
            end
        end
        
        if shr_imgC(i,j)==1 & shr_imgD(i,j)==1  %右下向處理結合
            shr_imgD(i,j) = 1;
        else
            shr_imgD(i,j) = 0;
        end
        
    end
end

shr_imgD = shr_imgB & shr_imgD;  %四方向處理結合

%%

% output
subplot(2,2,1); imshow(rgb); title('Original');
subplot(2,2,2); imshow(Binary); title('Binarization');
subplot(2,2,3); imshow(exp_imgD); title('expanding');
subplot(2,2,4); imshow(shr_imgD); title('shrinking');
saveas(figure(1),'CV_HW2_M1035502','jpg');
