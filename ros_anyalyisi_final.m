% ROC based on Flow score 


clear all
close all
clc

% 
% image_dir='/home/vinayb/icra_17/data/MOT_Benchmarking_Datasets/MOT16/train/MOT16-02/img1/%06d.jpg';
% 
% image_dir='/home/vinayb/icra_17/data/mot_15/PETS09-S2L1/img1/%06d.jpg';

image_dir='/home/vinayb/icra_17/data/mot_15/mot15/train/Venice-2/img1/%06d.jpg';
%image_dir='/home/vinayb/icra_17/data/MOT_Benchmarking_Datasets/MOT16/train/MOT16-13/img1/%06d.jpg';

image_write_dir='/home/vinayb/icra_17/data/mot_15/mot15/train/Venice-2/img1_check/%06d.jpg';
sj=1;
sk=1;

load /home/vinayb/icra_17/data/mot_15/mot15/train/Venice-2/detections_with_overlap_Venice-2.mat % Detections 

tracklets=tracklets_new_overlap;
delt=1;

for i=1:length(tracklets)
    
 %   read images 
    image_1=imread(sprintf(image_dir,i));
    image_2=imread(sprintf(image_dir,i+delt));
    
    
    i
    
points = detectMinEigenFeatures(rgb2gray(image_1));
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
points = points.Location;
initialize(pointTracker, points, image_1);
[points1, isFound] = step(pointTracker, image_2);

% Get found tracks 

visiblePoints_frame1_forward = points(isFound, :);
visiblePoints_frame2_forward = points1(isFound, :);
visiblePoints_frame1_forward=round(visiblePoints_frame1_forward);
visiblePoints_frame2_forward=round(visiblePoints_frame2_forward);



points_backward=detectMinEigenFeatures(rgb2gray(image_2));
pointTracker= vision.PointTracker('MaxBidirectionalError', 2);
points_backward=points_backward.Location;
initialize(pointTracker,points_backward,image_2);
[points1_backward,isFound1]=step(pointTracker, image_1);

visiblePoints_frame1_backward=points1_backward(isFound1,:);
visiblePoints_frame2_backward=points_backward(isFound1,:);
visiblePoints_frame1_backward=round(visiblePoints_frame1_backward);
visiblePoints_frame2_backward=round(visiblePoints_frame2_backward);


%figure(1),showMatchedFeatures(image_1,image_2,visiblePoints_frame1_forward,visiblePoints_frame2_forward);

%    pause(1)
    
    for j=1:length(tracklets{1,i})
    
        
       for k=1:length(tracklets{1,i+delt})
            
            
           if(tracklets{1,i}{1,j}(1,11)==tracklets{1,i+delt}{1,k}(1,11))   % Correct Matches 
               
          %     if(tracklets{1,i}{1,j}(1,3)< 1900&& tracklets{1,i}{1,j}(1,4)<1060 && tracklets{1,i+delt}{1,k}(1,3)<1900 && tracklets{1,i+delt}{1,k}(1,4)<1060 && tracklets{1,i+delt}{1,k}(1,3)>20 && tracklets{1,i}{1,j}(1,3)>20 && tracklets{1,i}{1,j}(1,5)>20 && tracklets{1,i+delt}{1,k}(1,5)>20 && tracklets{1,i}{1,j}(1,4)>20 && tracklets{1,i+delt}{1,k}(1,4)>20)
               
               bbox1=[tracklets{1,i}{1,j}(1,3),tracklets{1,i}{1,j}(1,3)+tracklets{1,i}{1,j}(1,5),tracklets{1,i}{1,j}(1,4),tracklets{1,i}{1,j}(1,4)+tracklets{1,i}{1,j}(1,6)];
               
               bbox2=[tracklets{1,i+delt}{1,k}(1,3),tracklets{1,i+delt}{1,k}(1,3)+tracklets{1,i+delt}{1,k}(1,5),tracklets{1,i+delt}{1,k}(1,4),tracklets{1,i+delt}{1,k}(1,4)+tracklets{1,i+delt}{1,k}(1,6)];
               
               bbox1_spatial=[tracklets{1,i}{1,j}(1,3),tracklets{1,i}{1,j}(1,4),tracklets{1,i}{1,j}(1,5),tracklets{1,i}{1,j}(1,6)];
               bbox2_spatial=[tracklets{1,i+delt}{1,k}(1,3),tracklets{1,i+delt}{1,k}(1,4),tracklets{1,i+delt}{1,k}(1,5),tracklets{1,i+delt}{1,k}(1,6)];
               display('this is working fine');
           %    flow_score=flow_match_score_test(image_1,image_2,bbox1,bbox2,visiblePoints_frame1_forward,visiblePoints_frame2_forward);    %  flow score 
               flow_score_main=flow_match_score(image_1,image_2,bbox1,bbox2,visiblePoints_frame1_forward,visiblePoints_frame2_forward); 
               spatial_score=spatial_match_score(bbox1_spatial,bbox2_spatial);  %  spatial score 
               
               flow_score_forward_backward_consistency=flow_match_score_forward_backward_consistency(image_1,image_2,bbox1,bbox2,visiblePoints_frame1_forward,visiblePoints_frame2_forward,visiblePoints_frame1_backward,visiblePoints_frame2_backward);
               
               
%               intersection_kernal_score=color_intersection_score(image_1,image_2,bbox1_spatial,bbox2_spatial); 
%              pause(4);
               correct_matches(sj,1)=tracklets{1,i}{1,j}(1,11); % id at bbox1 of j 
               correct_matches(sj,2)=tracklets{1,i+delt}{1,k}(1,11);% id at bbox2 of k 
               correct_matches(sj,3)=flow_score_forward_backward_consistency;
               correct_matches(sj,4)=i;
               correct_matches(sj,5)=1;
               correct_matches(sj,6)=1/spatial_score;
%                correct_matches(sj,7)=intersection_kernal_score;
               %correct_matches(sj,8)=flow_score_main;
               %correct_matches(sj,9)=flow_score_forward_backward_consistency;
               sj=sj+1;
         %      filename_save=sprintf(image_write_dir,sj);
               
%               figure(1)
%               subplot(2,2,1),imshow(image_1(tracklets{1,i}{1,j}(1,4):tracklets{1,i}{1,j}(1,4)+tracklets{1,i}{1,j}(1,6),tracklets{1,i}{1,j}(1,3):tracklets{1,i}{1,j}(1,3)+tracklets{1,i}{1,j}(1,5),:));
%               subplot(2,2,2),imshow(image_2(tracklets{1,i+delt}{1,k}(1,4):tracklets{1,i+delt}{1,k}(1,4)+tracklets{1,i+delt}{1,k}(1,6),tracklets{1,i+delt}{1,k}(1,3):tracklets{1,i+delt}{1,k}(1,3)+tracklets{1,i+delt}{1,k}(1,5),:));
        %       end 
%             saveas(gcf,filename_save)
               
           else    % Wrong Matches 
            
          %  if(tracklets{1,i}{1,j}(1,3)<1900 && tracklets{1,i}{1,j}(1,4)<1060 && tracklets{1,i+delt}{1,k}(1,3)<1920 && tracklets{1,i+delt}{1,k}(1,4)<1060 && tracklets{1,i+delt}{1,k}(1,3)>20 && tracklets{1,i}{1,j}(1,3)>20 && tracklets{1,i+delt}{1,k}(1,3)>20 && tracklets{1,i+delt}{1,k}(1,5)>20 && tracklets{1,i+delt}{1,k}(1,5)>20 && tracklets{1,i}{1,j}(1,4)>20 && tracklets{1,i+delt}{1,k}(1,4)>20)
                bbox1=[tracklets{1,i}{1,j}(1,3),tracklets{1,i}{1,j}(1,3)+tracklets{1,i}{1,j}(1,5),tracklets{1,i}{1,j}(1,4),tracklets{1,i}{1,j}(1,4)+tracklets{1,i}{1,j}(1,6)];
               
                bbox2=[tracklets{1,i+delt}{1,k}(1,3),tracklets{1,i+delt}{1,k}(1,3)+tracklets{1,i+delt}{1,k}(1,5),tracklets{1,i+delt}{1,k}(1,4),tracklets{1,i+delt}{1,k}(1,4)+tracklets{1,i+delt}{1,k}(1,6)];
               
                bbox1_spatial=[tracklets{1,i}{1,j}(1,3),tracklets{1,i}{1,j}(1,4),tracklets{1,i}{1,j}(1,5),tracklets{1,i}{1,j}(1,6)];
                bbox2_spatial=[tracklets{1,i+delt}{1,k}(1,3),tracklets{1,i+delt}{1,k}(1,4),tracklets{1,i+delt}{1,k}(1,5),tracklets{1,i+delt}{1,k}(1,6)];
                
               % flow_score=flow_match_score_test(image_1,image_2,bbox1,bbox2,visiblePoints_frame1_forward,visiblePoints_frame2_forward);
                flow_score_main=flow_match_score(image_1,image_2,bbox1,bbox2,visiblePoints_frame1_forward,visiblePoints_frame2_forward);
                spatial_score=spatial_match_score(bbox1_spatial,bbox2_spatial); 
                flow_score_forward_backward_consistency=flow_match_score_forward_backward_consistency(image_1,image_2,bbox1,bbox2,visiblePoints_frame1_forward,visiblePoints_frame2_forward,visiblePoints_frame1_backward,visiblePoints_frame2_backward);
                
                display('i am struck at here');
%                intersection_kernal_score=color_intersection_score(image_1,image_2,bbox1_spatial,bbox2_spatial);
%               pause(4);
               wrong_matches(sk,1)=tracklets{1,i}{1,j}(1,2); % id at bbox1 of j 
               wrong_matches(sk,2)=tracklets{1,i+delt}{1,k}(1,2);% id at bbox2 of k 
               wrong_matches(sk,3)=flow_score_forward_backward_consistency;
               wrong_matches(sk,4)=i;
               wrong_matches(sk,5)=0;
%                wrong_matches(sk,7)=intersection_kernal_score;
               wrong_matches(sk,6)=1/spatial_score;
%                wrong_matches(sk,7)=10*spatial_score+flow_score_forward_backward_consistency;
%                wrong_matches(sk,8)=flow_score_main;
               
               sk=sk+1;
        
 %           end 
           end 
        
        
       end 
        
    
    end 
    
    clear points
    clear visiblePoints_frame1_forward
    clear visiblePoints_frame2_forward
    clear visiblePoints_frame1_backward
    clear visiblePoints_frame2_backward
    clear points1_backward
    clear points_backward
    clear isFound1
    clear points1
    clear isFound
    
    
end 

% Run ROC+AUC analysis 



labels_flow=[correct_matches(:,5)' wrong_matches(:,5)'];%[ground_truth_labels_1 ground_truth_labels_2];
scores_flow=[correct_matches(:,3)' wrong_matches(:,3)'];%[feature_Scores feature_scores];
posclass_flow=1;%[possitive_class_labels1 possitive_class_labels2];

% 
% 
% 
% labels_flow1=[correct_matches(:,5)' wrong_matches(:,5)'];%[ground_truth_labels_1 ground_truth_labels_2];
% scores_flow1=[correct_matches(:,8)' wrong_matches(:,8)'];%[feature_Scores feature_scores];
% posclass_flow1=1;%[possitive_class_labels1 possitive_class_labels2];



% labels_color=[correct_matches(:,5)' wrong_matches(:,5)'];
% scores_color=[correct_matches(:,7)' wrong_matches(:,7)'];
% posclass_color=1;


labels_spatial=[correct_matches(:,5)' wrong_matches(:,5)'];
scores_spatial=[correct_matches(:,6)' wrong_matches(:,6)'];
posclass_spatial=1;


% labels_check=[correct_matches(1:100,5)' wrong_matches(1:100,5)'];
% scores_check=[correct_matches(1:100,8)' correct_matches(101:200,8)'];
% posclass_check=1;


% ROC Curve
[X,Y,T_flow,AUC_flow,OOPT_flow]= perfcurve(labels_flow,scores_flow,posclass_flow);
% [X1,Y1,T_color,AUC_color,OOPT_color]=perfcurve(labels_color,scores_color,posclass_color);
[X2,Y2,T_spatial,AUC_spatial,OOPT_spatial]=perfcurve(labels_spatial,scores_spatial,posclass_spatial);
% [X3,Y3,T_flow1,AUC_flow1,OOPT_flow1]= perfcurve(labels_flow1,scores_flow1,posclass_flow1);

figure(1),plot(X,Y,'r',X2,Y2);%,'g',X2,Y2,'b');

AUC_flow 
% 
% AUC_flow1

% AUC_color

AUC_spatial

% [X_check,Y_check,T_check,AUC_check,OOPT_check]= perfcurve(labels_check,scores_check,posclass_check);
