%%% Split reconstrcuted images
clear all;
fileIn = 'F:\\HPIV_2010_Analysis_1\\Oct_11_s4_1\\sub\\rec_049-050\\HPF\\rec_%03d_%03d.tif';
fileOut_A = 'F:\\HPIV_2010_Analysis_1\\Oct_11_s4_1\\sub\\rec_049-050\\HPF\\partA\\rec_%03d_%03d.tif';
fileOut_B = 'F:\\HPIV_2010_Analysis_1\\Oct_11_s4_1\\sub\\rec_049-050\\HPF\\partB\\rec_%03d_%03d.tif';
frames = [175:380];
pair = [50];
for i = 1:length(pair)
    for j = 1:length(frames)
        temp_fname = sprintf(fileIn, pair(i), frames(j));
        I = imread(temp_fname);
        imwrite(I(1:3180, 1:4730/2), sprintf(fileOut_A, pair(i), frames(j)), 'tif', 'compression', 'none');
        imwrite(I(1:3180, 4730/2+1:4730), sprintf(fileOut_B, pair(i), frames(j)), 'tif', 'compression', 'none');
    end
end  