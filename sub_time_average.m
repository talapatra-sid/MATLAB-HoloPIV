clear all;
Sum1 = 0;
Sum2 = 0;
for i =1:538
   I = im2double(imread(sprintf('F:\\HPIV_Nov2009_Processing\\Nov_10\\300rpm\\5ml_60s\\vib_corrected\\norm\\seed211102100_%06d.tif', i)));
   if rem(i,2) ~= 0
       Sum1 = Sum1 + I/269;
   else
       Sum2 = Sum2 + I/269;
   end
end 
avename1 = 'F:\HPIV_Nov2009_Processing\Nov_10\300rpm\5ml_60s\vib_corrected\norm\avg1.tif';
avename2 = 'F:\HPIV_Nov2009_Processing\Nov_10\300rpm\5ml_60s\vib_corrected\norm\avg2.tif';
imwrite(Sum1, avename1, 'tif', 'Compression', 'none');
imwrite(Sum2, avename2, 'tif', 'Compression', 'none');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file_name = 'F:\\HPIV_Nov2009_Processing\\Nov_10\\300rpm\\5ml_60s\\vib_corrected\\norm\\seed211102100_%06d.tif';
out_name = 'F:\\HPIV_Nov2009_Processing\\Nov_10\\300rpm\\5ml_60s\\vib_corrected\\norm\\sub\\seed211102100_%06d.tif';
frames = 269;      %%% number of images
st_in = 1;
I_ave = im2double(imread(avename1));
boundingStd = 2.5;
for i = 1:frames
    ind = st_in + (i-1)*2;  %%% change as per file name
    I = im2double(imread(sprintf(file_name, ind)));
    c1 = I - I_ave;
    imgstd(i,1) = mean(c1(:));
    imgstd(i,2) = std(c1(:));
end
upperBound = mean(imgstd(:,1))+ boundingStd*mean(imgstd(:,2));
lowerBound = mean(imgstd(:,1))- boundingStd*mean(imgstd(:,2));
for i = 1:frames
    ind = st_in + (i-1)*2;  %%% change as per file name
    I = im2double(imread(sprintf(file_name, ind)));
    c1 = I - I_ave;
    c1 = (c1-lowerBound)/(upperBound-lowerBound);
    j = find( c1(:) > 1 );
    c1(j) = 1;
    j = find( c1 < 0 );
    c1(j) = 0;
    imwrite(c1, sprintf(out_name, ind), 'tif', 'Compression', 'none');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
frames = 269;      %%% number of images
st_in = 2;
I_ave = im2double(imread(avename2));
boundingStd = 2.5;
for i = 1:frames
    ind = st_in + (i-1)*2;  %%% change as per file name
    I = im2double(imread(sprintf(file_name, ind)));
    c1 = I - I_ave;
    imgstd(i,1) = mean(c1(:));
    imgstd(i,2) = std(c1(:));
end
upperBound = mean(imgstd(:,1))+ boundingStd*mean(imgstd(:,2));
lowerBound = mean(imgstd(:,1))- boundingStd*mean(imgstd(:,2));
for i = 1:frames
    ind = st_in + (i-1)*2;  %%% change as per file name
    I = im2double(imread(sprintf(file_name, ind)));
    c1 = I - I_ave;
    c1 = (c1-lowerBound)/(upperBound-lowerBound);
    j = find( c1(:) > 1 );
    c1(j) = 1;
    j = find( c1 < 0 );
    c1(j) = 0;
    imwrite(c1, sprintf(out_name, ind), 'tif', 'Compression', 'none');
end