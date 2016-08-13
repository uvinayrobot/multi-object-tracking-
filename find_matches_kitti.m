%% Find Boundingbox overlap and find wrong and correct matches scores for MOT'15 and MOT '16 

clear all
close all
clc



%load detections_Pets.mat% detections mat file 
%load  /home/vinayb/icra_17/data/MOT_Benchmarking_Datasets/MOT16/train/MOT16-13/det/MOT16-13_detections.mat% detections file

load /home/vinayb/icra_17/data/KITTI/data_tracking_det_2_lsvm/training/det_02/0009_dpm_with_thresh.mat

%load  /home/vinayb/icra_17/data/MOT_Benchmarking_Datasets/MOT16/train/MOT16-13/gt/groundtruth.mat% groundtruth file 

load /home/vinayb/icra_17/data/KITTI/data_tracking_det_2_lsvm/training/det_02/KITTI_Tracking_09_GroundTruth.mat
/
%load groundtruth_Pets.mat% ground truth mat file 

% find overlap and construct a new file with detections and their id's 
tracklets=new_tracklets;

tracklets_detection=tracklets_detections;
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
            
            bx1=tracklets_detection{1,i}{j}(1,7);
            by1=tracklets_detection{1,i}{j}(1,8);
            bh1=tracklets_detection{1,i}{j}(1,9);
            bw1=tracklets_detection{1,i}{j}(1,10);
            
            bx1=str2num(bx1{1});
            by1=str2num(by1{1});
            bh1=(str2num(bh1{1}))-bx1;
            bw1=str2num(bw1{1})-by1;
            
            bx2=tracklets{1,i}(1,k).x1;
            by2=tracklets{1,i}(1,k).y1;
            bh2=tracklets{1,i}(1,k).x2-bx2;
            bw2=tracklets{1,i}(1,k).y2-by2;

            
%             bx2=str2num(bx2{1});
%             by2=str2num(by2{1});
%             bh2=(str2num(bh2{1}))-bx2;
%             bw2=str2num(bw2{1})-by2;
%             
            
            
            
            bbox1=[bx1,by1,bh1,bw1];
            bbox2=[bx2,by2,bh2,bw2];
            
            ratio_overlap=bboxOverlapRatio(bbox1,bbox2);
            
           % occupancy_matrix{i}(j,k)=
            if(ratio_overlap>=0.4)
           
            occupancy_matrix{i}(j,k)=1;  
            
                tracklets_new_overlap{1,i}{sj}=tracklets_detection{1,i}{j};
                tracklets_new_overlap{1,i}{sj}(1,19)={tracklets{1,i}(1,k).id};
                sj=sj+1;
                display('here');
            end 
          %  break
            
        end 
    
        end 
    end 
    
end 