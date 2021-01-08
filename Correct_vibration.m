%%% From the masked bw images, get the largest blob, find its center, and
%%% record it. Use this to calculate the displacement
clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Code that generates the rois: this is followed by thresholding%%%%
%for i = 1:175
%    I = im2double(imread(sprintf('D:\\2cm_down_0.1_conc\\2\\vibration_det\\rec\\rec_%03d_000.tif', i)));
%    BW = roipoly(I);
%    F = (1-I).*BW;
%    imwrite(F, sprintf('D:\\2cm_down_0.1_conc\\2\\vibration_det\\rec\\filt\\filt_%03d.tif',i), 'tif', 'compression', 'none');
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
range = [0 74];
filein = 'H:\\Oct_2010\\Oct9th\\seed1\\vib_control\\seed110090839_%06d.tif';
for i = 1:range(2)-range(1)+1
    I = imread(sprintf(filein, 2*(i-1)+1));
    [BW, xi, yi] = roipoly(I);
    if i == 1
        dx(i) = 0;
        dy(i) = 0
        X = mean(xi);
        Y = mean(yi);
    else
        dx(i) = mean(xi)-X;
        dy(i) = mean(yi)-Y;
    end
end
clear X Y I R S;

%%%% Now we apply these displacements to each of the original images and
%%%% save them.

file1 = 'H:\\Oct_2010\\Oct9th\\seed1\\seed110090839_%06d.tif';
fileout = 'H:\\Oct_2010\\Oct9th\\seed1\\vib_corrected\\seed110090839_%06d.tif';
k = 0;
for i=1:150
    I = imread(sprintf(file1, i-1));
    if rem(i,2) ~= 0
        k = k +1;
    end
    J = I(21+dy(k):3200+dy(k), 21+dx(k):4750+dx(k));
    imwrite(J, sprintf(fileout,i-1), 'tif', 'compression', 'none');
end