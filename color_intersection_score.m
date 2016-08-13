function final_intersection_kernal_score = color_intersection_score(image1,image2,bbox1,bbox2)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


% Resize image 



bbox1=round(bbox1);

bbox2=round(bbox2);









if((abs(bbox1(1)-(bbox1(1)+bbox1(3)))+abs(bbox1(2)-(bbox1(2)+bbox1(4))))>(abs(bbox2(1)-(bbox2(1)+bbox2(3)))+abs(bbox2(2)-(bbox2(2)+bbox2(4)))))

    
    
    hist1_ch1=imhist(image1(bbox1(2):bbox1(2)+bbox1(4),bbox1(1):bbox1(1)+bbox1(3),1));
    hist1_ch2=imhist(image1(bbox1(2):bbox1(2)+bbox1(4),bbox1(1):bbox1(1)+bbox1(3),2));
    hist1_ch3=imhist(image1(bbox1(2):bbox1(2)+bbox1(4),bbox1(1):bbox1(1)+bbox1(3),3));
    
    
    image_view=image1(bbox1(2):bbox1(2)+bbox1(4),bbox1(1):bbox1(1)+bbox1(3),:);
    
    image_temp=image2(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),:);
    
    image_final=imresize(image_temp,[bbox1(4) bbox1(3)]);
    
    hist2_ch1=imhist(image_final(:,:,1));
    hist2_ch2=imhist(image_final(:,:,2));
    hist2_ch3=imhist(image_final(:,:,3));
    
    
else
    hist2_ch1=imhist(image2(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),1));
    
    hist2_ch2=imhist(image2(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),2));

    hist2_ch3=imhist(image2(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),3));
    
    image_temp=image1(bbox1(2):bbox1(2)+bbox1(4),bbox1(1):bbox1(1)+bbox1(3),:);
    
    image_final=imresize(image_temp,[bbox2(4) bbox2(3)]);
    
    
    size(image1)
    size(image_final)
     hist1_ch1=imhist(image_final(:,:,1));
     hist1_ch2=imhist(image_final(:,:,2));
     hist1_ch3=imhist(image_final(:,:,3));
    
    
    image_view=image2(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),:);
    
end 


% figure(1),imshow(image_final);
% 
% figure(2),imshow(image_view);

n=256;% size of bin
count=0;
for i=1:n
    
    temp1=min(hist1_ch1(i,1),hist2_ch1(i,1));
    temp2=min(hist1_ch2(i,1),hist2_ch2(i,1));
    temp3=min(hist1_ch3(i,1),hist2_ch3(i,1));
    
    count=count+temp1+temp2+temp3;
    
    
end 



% %%
%         for vj=1:length(histogram1_im_ch1)
%         
%             temp_value_ch1=min(histogram1_im_ch1(vj,1),histogram2_im_ch1(vj,1));
%             temp_value_ch2=min(histogram1_im_ch2(vj,1),histogram2_im_ch2(vj,1));
%             temp_value_ch3=min(histogram1_im_ch3(vj,1),histogram2_im_ch3(vj,1));
%             
%         sum_temp=sum_temp+temp_value_ch1+temp_value_ch2+temp_value_ch3;
%         
%         
%         end 
%%
final_intersection_kernal_score=count;

% Compute Histograms 



% Run Intersection Kernels 






end

