function spatial_score= spatial_match_score(bbox1,bbox2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

bb1_x=(bbox1(1)+(bbox1(3)/2));
bb1_y=(bbox1(2)+bbox1(4));

bb2_x=(bbox2(1)+(bbox2(3)/2));
bb2_y=(bbox2(2)+bbox2(4));


bb1_xc=bb1_x/2;
bb1_yc=bb1_y;

bb2_xc=bb2_x/2;
bb2_yc=bb2_y;




mean_height=(abs(bbox1(2)-(bbox1(2)+bbox1(4)))+abs(bbox2(2)-(bbox2(2)+bbox2(4))))/2;

bb1_x=bb1_xc;%/mean_height;
bb1_y=bb1_yc;%/mean_height;

bb2_x=bb2_xc;%/mean_height;
bb2_y=bb2_yc;%/mean_height;




spatial_score =norm([(bb1_x-bb2_x),(bb1_y-bb2_y)]);



end

