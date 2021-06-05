clc;clear;
%Ū������
[FN] = uigetfile({'*.jpg','JPEG (*.jpg;*.jpeg;*)';...
                  '*.png','PNG (*.png)';...
                  '*.bmp','BMP (*.bmp)';...
                  '*.tiff','TIFF (*.tiff)'},'�}�ҹ���');
RGB = imread(FN);
%��m�ϰ�аO�H�ΤG�Ȥ�
d_R = zeros(size(RGB));
d_G = zeros(size(RGB));
d_B = zeros(size(RGB));
for i=1:size(RGB,1);
    for j=1:size(RGB,2);
        d_R(i,j) = RGB(i,j,1);
        d_G(i,j) = RGB(i,j,2);
        d_B(i,j) = RGB(i,j,3);
        if d_R(i,j) > 150 && d_G(i,j) < 100 && d_B(i,j) <100  %��m�P�_����
            Mark(i,j) = 1;
        else
            Mark(i,j) = 0;
        end
    end
end
%�κA�B��L�o���T
se = strel('disk',1);
se_Mark = imopen(Mark,se);

figure(1);
subplot(2,2,2); imshow(RGB); title('Original');
subplot(2,2,3); imshow(Mark); title('Mark Regions');
subplot(2,2,4); imshow(se_Mark); title('Mark Regions(opening)');
saveas(figure(1),'CV_HW4_M1035502','jpg');

% figure(1); imshow(RGB); title('Original');
% figure(2); imshow(Mark); title('Mark Regions');
% figure(3); imshow(se_Mark); title('Mark Regions(opening)');
% saveas(figure(1),'CV_HW4_M1035502-01','jpg');
% saveas(figure(2),'CV_HW4_M1035502-02','jpg');
% saveas(figure(3),'CV_HW4_M1035502-03','jpg');
