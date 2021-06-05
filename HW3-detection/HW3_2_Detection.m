


% Load an image
I = imread('C:\Users\user_2\Desktop\9\HW3-detection\blockword.png');

% Perform OCR
results = ocr(I);

% Display one of the recognized words
word = results.Words{2}

% Location of the word in I
wordBBox = results.WordBoundingBoxes(2,:)





clc;clear;
%Ū������

original= imread('C:\Users\user_2\Desktop\9\HW3-detection\HW3_2_brownCow.png');




o = imread('C:\Users\user_2\Desktop\9\HW3-detection\HW3_2_o.png');

subplot(1,2,1); imshow(original); title('original');

size1 = size(original);
size2 = size(o);
%���o���Ѧr�������I
if mod(size2(1),2) == 0
    h =(size2(1)/2);
    w =(size2(2)/2);
else
    h =(size2(1)+1)/2;
    w =(size2(2)+1)/2;    
end

t1=sum(sum(o));
total1 = sum(sum(o(1,1:size2(2))));
total2 = sum(sum(o(1:size2(1),1)));
Recognition_results = original;


%���Ѧr��

'a'
for i=1:size1(1)-size2(1)+1
    for j=1:size1(2)-size2(2)+1
        
       t2=sum(sum(original(i:i+size2(2)-1,j:j+size2(1)-1)));
       total3 = sum(sum(original(i,j:j+size2(1)-1)));
       total4 = sum(sum(original(i:i+size2(2)-1,j)));
      
       if total1==total3
		if t1==t2 
			if total2==total4
           			Recognition_results(i+h-1,j+w-1)=0;  
			end
		end        
       end
    end    
end

subplot(1,2,2); imshow(Recognition_results); title('Recognition results');
saveas(figure(1),'CV_HW3_2_M1035502','png');
