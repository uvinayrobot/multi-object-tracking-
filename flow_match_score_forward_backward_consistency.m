function feature_score = flow_match_score_forward_backward_consistency(image_1,image_2,bbox1,bbox2,visiblePoints_frame1_forward,visiblePoints_frame2_forward,visiblePoints_frame1_backward,visiblePoints_frame2_backward)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 bbox1=round(bbox1);
 bbox2=round(bbox2);
 
 visiblePoints_frame1_forward=round(visiblePoints_frame1_forward);
 visiblePoints_frame2_forward=round(visiblePoints_frame2_forward);
 visiblePoints_frame1_backward=round(visiblePoints_frame1_backward);
 visiblePoints_frame2_backward=round(visiblePoints_frame2_backward);
 
image_1_mask=zeros(size(image_1,1),size(image_1,2));
image_2_mask=zeros(size(image_1,1),size(image_1,2));
image_1_mask(bbox1(3):bbox1(4),bbox1(1):bbox1(2))=1;
image_2_mask(bbox2(3):bbox2(4),bbox2(1):bbox2(2))=1;


% figure(1),imshow(image_1_mask);
% pause(4);

count_forward=0;
count_backward=0;
count_view1_forward=1;
count_view2_backward=1;
for k=1:length(visiblePoints_frame1_forward)
    
    if(image_1_mask(visiblePoints_frame1_forward(k,2),visiblePoints_frame1_forward(k,1))==1)
        count_view1_forward=count_view1_forward+1;
        
    end 
    
end

for k=1:length(visiblePoints_frame2_backward)
    
    if(image_2_mask(visiblePoints_frame2_backward(k,2),visiblePoints_frame2_backward(k,1))==1)
        count_view2_backward=count_view2_backward+1;
        
    end 
    
end


% figure(1),imshow(image_1_mask);
% figure(2),imshow(image_2_mask);
for k=1:length(visiblePoints_frame1_forward)
    
    if(image_1_mask(visiblePoints_frame1_forward(k,2),visiblePoints_frame1_forward(k,1))==1 && image_2_mask(visiblePoints_frame2_forward(k,2),visiblePoints_frame2_forward(k,1))==1)
        
count_forward=count_forward+1;        
        
    end 
end 


for k=1:length(visiblePoints_frame2_backward)
    
    if(image_1_mask(visiblePoints_frame1_backward(k,2),visiblePoints_frame1_backward(k,1))==1 && image_2_mask(visiblePoints_frame2_backward(k,2),visiblePoints_frame2_backward(k,1))==1)
        
count_backward=count_backward+1;        
        
    end 
end 



flow_count_forward=count_forward/count_view1_forward;
flow_count_backward=count_backward/count_view2_backward;
feature_score=(flow_count_forward+flow_count_backward)/2;
%feature_score=1;
end

