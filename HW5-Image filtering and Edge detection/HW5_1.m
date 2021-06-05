%Implement the Roberts, Sobel, and LoG operators
%Implement a program for the user to select different  operators and images
%im=imread('C:\Users\user_2.User-PC\Desktop\smile.jpg'); 
[FN]=uigetfile({'*.jpg','JPEG (*.jpg;*.jpeg;*)';...
                  '*.png','PNG (*.png)';...
                  '*.bmp','BMP (*.bmp)';...
                  '*.tiff','TIFF (*.tiff)'},'∂}±“πœ¿…');
RGB = imread(FN);
gray = rgb2gray(RGB);
figure(1);
subplot(2,3,1); imshow(RGB); title('Original');
subplot(2,3,2); imshow(gray); title('Gray');
%user=input('Roberts, Sobel, and LoG operators:','s');
%Roberts   
Roberts = edge(gray, 'Roberts');
%Sobel
  %BW = edge(I,'Sobel',threshold)
  %BW = edge(I,'Sobel',threshold,direction)
  %BW = edge(I,'Sobel',threshold,direction,'nothinning')
  %[BW,threshOut] = edge(I,'Sobel',___)
Sobel = edge(gray, 'sobel');
%LoG operators
LoG = edge(gray, 'log');
subplot(2,3,3); imshow(Roberts); title('Roberts');
subplot(2,3,4); imshow(Sobel); title('Sobel');
subplot(2,3,5); imshow(LoG); title('LOG');
saveas(figure(1),'HW5_1_M1045509','jpg');