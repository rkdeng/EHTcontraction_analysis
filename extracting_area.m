% This is a quick and dirty way of extracting features and analyzing
% contraction of EHT videos.

% Right now it is loading example.tif to show how it works. When analyzing
% videos of contracting EHT, uncomment line 10 to 19, line 32, line 35, line 107,
% comment out lines 24, 29, 59, 82 to 87, so the code can properly analyze the videos.

% matlab version 2023b

%%
% load video
% filename = '\VID_20240614_154857.mp4';
% 
% vidObj = VideoReader(filename);
% 
% 
% export_folder = 'C:\desktop-everything\dataAnalysis\rnd_script\img_export';
% 
% m1 = vidObj.Height;
% m2 = vidObj.Width;
% m4 = vidObj.NumFrames

%%
% load images
frame_tmp = imread('example.tif');


%%
m4 = 3000;
inner = zeros(1,m4); % this variable stores the extracted area from each frame

frame_count = 1;

%while hasFrame(vidObj)   % use while loop for video

     % read each frame of the video
   % frame_tmp = readFrame(vidObj);

    if frame_count < 280000

        % turn the frame into gray image
        frame_tmp_gray = im2gray(frame_tmp);

        % binarize the image through simple thresholding
        BW1 = frame_tmp_gray > 100;

        % filter out small dots in the center.
        minSize1 = 1;
        J1 = bwareaopen(BW1,minSize1);

        % close the gaps
        SE = strel('disk',35);
        J2 = imclose(J1,SE);

        % filter out unwanted dots
        minSize2 = 500;
        J3 = bwareaopen(J2,minSize2);

        % display the results
        figure,montage({frame_tmp_gray,BW1,J1,J2,J3},'BackgroundColor','blue','BorderSize',3)

        % if frame_count == 10
        %   figure,montage({frame_tmp_gray,BW1,J1,J2,J3},'BackgroundColor','blue','BorderSize',3)
        % end

        %%
        % detect the inner sphere and calculate the area

        pre_fill = J3;
        filled = imfill(pre_fill,[923 502],4); % the coordinates are hard-coded in here. Any points inside of the inner sphere should work.

        inner_tmp = pre_fill ~= filled;

        inner(frame_count) = sum(inner_tmp(:));

        %figure,montage({pre_fill,filled,inner_tmp},'BackgroundColor','blue','BorderSize',3)


        [B,L,n,A] = bwboundaries(inner_tmp);
        line1 = B{1,1};

        % visualize the detected area
        fhdl = figure(3323); clf
        imshow(frame_tmp)
        hold on
        plot(line1(:,2),line1(:,1),'r','LineWidth',2)
        hold off
        title(num2str(frame_count))

        % if frame_count > 10 & frame_count < 13  % selectively plot some of them
        %     fhdl = figure(3323); clf
        %     imshow(frame_tmp)
        %     hold on
        %     plot(line1(:,2),line1(:,1),'r','LineWidth',2)
        %     hold off
        %     title(num2str(frame_count))
        % 
        %     sname = sprintf('f%06d.jpeg',frame_count);
        %     saveas(fhdl,fullfile(export_folder,sname))
        % end

    end

    frame_count = frame_count + 1;

    if rem(frame_count, 200) == 0
        disp(['frame ' num2str(frame_count) ' done'])
    end
%end







