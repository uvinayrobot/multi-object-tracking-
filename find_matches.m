%% Find Boundingbox overlap and find wrong and correct matches scores for MOT'15 and MOT '16 

clear all
close all
clc



%load detections_Pets.mat% detections mat file 
load  /home/vinayb/icra_17/data/MOT_Benchmarking_Datasets/MOT16/train/MOT16-13/det/MOT16-13_detections.mat% detections file

load  /home/vinayb/icra_17/data/MOT_Benchmarking_Datasets/MOT16/train/MOT16-13/gt/groundtruth.mat% groundtruth file 

%load groundtruth_Pets.mat% ground truth mat file 

% find overlap and construct a new file with detections and their id's 

if(length(tracklets)==length(tracklets_detection))
    display('seems they are correct files');
end 

% define occupancy matrix here 
for i=1:length(tracklets)
    sj=1;
    
    occupancy_matrix{i}=zeros(length(tracklets_detection{1,i}),length(tracklets{1,i}));
    for j=1:length(tracklets_detection{1,i})
        
        for k=1:length(tracklets{1,i})
            
            if(sum(occupancy_matrix{1,i}(:,k))==0)
            
            bx1=tracklets_detection{1,i}{j}(1,3);
            by1=tracklets_detection{1,i}{j}(1,4);
            bh1=tracklets_detection{1,i}{j}(1,5);
            bw1=tracklets_detection{1,i}{j}(1,6);
            
            bx2=tracklets{1,i}{k}(1,3);
            by2=tracklets{1,i}{k}(1,4);
            bh2=tracklets{1,i}{k}(1,5);
            bw2=tracklets{1,i}{k}(1,6);
            
            
            bbox1=[bx1,by1,bh1,bw1];
            bbox2=[bx2,by2,bh2,bw2];
            
            ratio_overlap=bboxOverlapRatio(bbox1,bbox2);
            
           % occupancy_matrix{i}(j,k)=
            if(ratio_overlap>=0.4)
           
            occupancy_matrix{i}(j,k)=1;  
            
                tracklets_new_overlap{1,i}{sj}=tracklets_detection{1,i}{j};
                tracklets_new_overlap{1,i}{sj}(1,11)=tracklets{1,i}{k}(1,2);
                sj=sj+1;
                display('here');
            end 
          %  break
            
        end 
    
        end 
    end 
    
end 