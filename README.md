# multi-object-tracking-

color_intersection_score.m: This function computes the intersection kernel score between two histograms. 

find_matches.m : This function will label association between detections and ground truth annotations. (for mot dataset)

find_matches_kitti.m : This function will label association between detections and ground truth annotations. (for kitti dataset)

flow_match_score_forward_backward_consistency.m : This function will returns the forward-backward flow consistency value given two images with their detections.  

for_dpm_detections.m : This function takes dpm detections text file and uses threshold to remove the outliers. 

spatial_match_score.m : This function takes two bounding boxes and computes L2 distance between bottom center of the detections that is normalized by the mean height of the two.

ros_anyalyisi_final.m : Computes ROC+ AUC Analysis  (mot dataset)

ros_anyalyisi_final_kitti.m : Computes ROC+ AUC Analysis (kitti dataset)
 
 

