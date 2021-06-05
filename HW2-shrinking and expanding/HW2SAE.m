clc;clear;

%% part.1

[FN] = uigetfile({'*.jpg','JPEG (*.jpg;*.jpeg;*)';...
                  '*.png','PNG (*.png)';...
                  '*.bmp','BMP (*.bmp)'},'�}�ҹ���');

% Binarization
% rgb = imread('apple.jpg');
rgb = imread(FN);
threshold = input('�п�J�H��:');        %��J�H��(0~255)
threshold = threshold / 255;            %�]�w�H��
Binary = im2bw(rgb,threshold);          %�G�Ȥ��ഫ
% figure(1); imshow(rgb);                 
% figure(2); imshow(Binary);

%% part.2

% ���ȩM�I�k�]imerode�Mimdilate�^

exp_imgA = zeros(size(Binary));     %�����B�zLR
exp_imgB = zeros(size(Binary));     %�����B�zUD
exp_imgC = zeros(size(Binary));    %�����B�zRL
exp_imgD = zeros(size(Binary));    %�����B�zDU
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
        
        if exp_imgA(i,j)==0 & exp_imgB(i,j)==0  %���W��V�B�z���X
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
        
        if exp_imgC(i,j)==0 & exp_imgD(i,j)==0  %�k�U��V�B�z���X
            exp_imgD(i,j) = 0;
        else
            exp_imgD(i,j) = 1;
        end
        
    end
end

exp_imgD = exp_imgB + exp_imgD;  %�|��V�B�z���X

%%

shr_imgA = zeros(size(Binary));     %�����B�zLR
shr_imgB = zeros(size(Binary));     %�����B�zUD
shr_imgC = zeros(size(Binary));     %�����B�zRL
shr_imgD = zeros(size(Binary));     %�����B�zDU
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
        
        if shr_imgA(i,j)==1 & shr_imgB(i,j)==1  %���W�V�B�z���X
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
        
        if shr_imgC(i,j)==1 & shr_imgD(i,j)==1  %�k�U�V�B�z���X
            shr_imgD(i,j) = 1;
        else
            shr_imgD(i,j) = 0;
        end
        
    end
end

shr_imgD = shr_imgB & shr_imgD;  %�|��V�B�z���X

%%

% output
subplot(2,2,1); imshow(rgb); title('Original');
subplot(2,2,2); imshow(Binary); title('Binarization');
subplot(2,2,3); imshow(exp_imgD); title('expanding');
subplot(2,2,4); imshow(shr_imgD); title('shrinking');
saveas(figure(1),'CV_HW2_M1035502','jpg');
