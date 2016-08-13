
clear all
close all
clc


% image_dir='/home/vinay/icvgip_16/MHT_Tracking/MHT_V1.0/2DMOT2015/KITTI/train/image_02/0000/%06d.png';
% 
% 
detections_dir='/home/vinayb/icra_17/data/KITTI/data_tracking_det_2_lsvm/training/det_02/%04d.txt';

j=19; % seq number

detections_file=sprintf(detections_dir,j);

fileid=fopen(detections_file,'r');

formatSpec='%s';
A=textscan(fileid,formatSpec);


fclose(fileid);
k=1;

for i=1:(length(A{1,1})/18)

    for j=1:18
    tracklets{i}{1,j}=A{1,1}{k,1};
    k=k+1
    end 

end 

% load 0000_dpm_detections.mat
numofimages=1059;
for i=1:numofimages
    i
    k=0;
    for j=1:length(tracklets)
        temp=i-1;
    if(str2num(tracklets{1,j}{1,1})==temp && str2num(tracklets{1,j}{1,18})>0.49)
        k=k+1;
        tracklets_detections{i}{k}=tracklets{j};
        
    end
    
    
   end 


end 

