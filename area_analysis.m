% data processing code for EHT contraction data. assuming you get the inner
% varaible from extracting_area.m

% matlab version 2023b

load('inner.mat') % here I am using this data as an example

inner_tmp = inner_t1;

figure,plot(inner_tmp)
title('raw data')

FPS = 60; % frame per second, hard coded in here

ttotal = (length(inner_tmp)-1)/FPS;

xs_tmp = 0:1/FPS:ttotal;

base_tmp = 424341; % hand picked baseline

figure,plot(xs_tmp,(inner_tmp-base_tmp)/base_tmp)
title('percentage of baseline')

%%

% use part of the data for quantification
crop_loc = [89 1162];

inner_tmp_crop = inner_tmp(crop_loc(1):crop_loc(2));

figure,plot(inner_tmp_crop)
title('cropped data for analysis')

inner_crop_df = (inner_tmp_crop-base_tmp)/base_tmp;


% quantify the contraction amplitude

% data are flipped for peak detection
[pks,locs,w,p] = findpeaks(-inner_crop_df,"MinPeakProminence",0.02); % may need to tune the parameter in here

disp('max contraction amplitude')
%p

% visualize the detected peaks, make sure they are correct.
figure,plot(-inner_crop_df)
hold on
plot(locs,pks,'^')
hold off
title('max contraction amplitude')

pks

disp('beat rate')

beat_rate = 1/(mean(diff(locs))/FPS)*60

% quantify the contraction relaxation speed 

% smooth data
inner_crop_df_filt = smoothdata(inner_crop_df,"sgolay",10); % may need to tune the parameter in here

figure,plot(inner_crop_df)
hold on
plot(inner_crop_df_filt)
hold off
title('filter data')

% calculate speed
speed = diff(inner_crop_df_filt);

figure,plot(speed)
title('speed')

% max contraction speed

% data are flipped for peak detection
[pks,locs,w,p] = findpeaks(-speed,"MinPeakProminence",0.008);  % may need to tune the parameter in here

disp('max contraction speed')
%p

% visualize the detected peaks, make sure they are correct.
figure,plot(-speed)
hold on
plot(locs,pks,'^')
hold off
title('max contraction speed')

pks

% max relaxation speed

[pks,locs,w,p] = findpeaks(speed,"MinPeakProminence",0.008);  % may need to tune the parameter in here


disp('max relaxation speed')
%p

% visualize the detected peaks, make sure they are correct.
figure,plot(speed)
hold on
plot(locs,pks,'^')
hold off
title('max relaxation speed')

pks






% Copyright (c) <2024>, <Rongkang Deng>
% All rights reserved.

% This source code is licensed under the BSD-style license found in the
% LICENSE file in the root directory of this source tree. 









