%%% Verify Partilce List %%%
clear all;
clc;

pair = [];
fid = fopen(['\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\partB\HPF\list_', sprintf('%03d', pair(1)), '_A.dat'], 'r' );
fgets(fid);
a=fscanf( fid, '%f' );
b=reshape( a, [10,length(a)/10] )';
tic;
fclose(fid);
for i = 0:400
    f1 = find((round(b(:,3)) == i) & (b(:,10) - b(:,9) >= 5) & b(:,3) > 20);
    if (isempty(f1) == 0)
        %points = b(f1, 1:2);
        bound = b(f1, 5:8);
        X1 = max(bound(:,1)-20, 1);
        X2 = min(bound(:,2)+20, 2390);
        Y1 = max(bound(:,3)-20, 1);
        Y2 = min(bound(:,4)+20, 3180);
        I = im2double(imread(sprintf(['\\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\\partB\\HPF\\rec_', sprintf('%03d', pair(1)), '_%03d.tif'], i)));
        %imshow(I);
        for j = 1:length(X1)
            I(Y1(j):Y2(j), X1(j)) = 1;
            I(Y1(j):Y2(j), X1(j)+1) = 1;
            I(Y1(j):Y2(j), X2(j)) = 1;
            I(Y1(j):Y2(j), X2(j)-1) = 1;
            I(Y1(j), X1(j):X2(j)) = 1;
            I(Y1(j)+1, X1(j):X2(j)) = 1;
            I(Y2(j), X1(j):X2(j)) = 1;
            I(Y2(j)-1, X1(j):X2(j)) = 1;
        end
        imwrite(I, sprintf(['\\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\\partB\\HPF\\part_test\\rec_', sprintf('%03d', pair(1)), '_%03d.tif'], i), 'tif', 'compression', 'none');
    end
end
% %%%%          %%%%%%%
fid = fopen(['\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\partB\HPF\list_', sprintf('%03d', pair(2)), '_A.dat'], 'r' );
fgets(fid);
a=fscanf( fid, '%f' );
b=reshape( a, [10,length(a)/10] )';

fclose(fid);
for i = 0:400
    f1 = find((round(b(:,3)) == i) & (b(:,10) - b(:,9) >= 5) & b(:,3) > 20);
    if (isempty(f1) == 0)
        %points = b(f1, 1:2);
        bound = b(f1, 5:8);
        X1 = max(bound(:,1)-20, 1);
        X2 = min(bound(:,2)+20, 2390);
        Y1 = max(bound(:,3)-20, 1);
        Y2 = min(bound(:,4)+20, 3180);
        I = im2double(imread(sprintf(['\\sub\\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\\partB\\HPF\\rec_', sprintf('%03d', pair(2)), '_%03d.tif'], i)));
        %imshow(I);
        for j = 1:length(X1)
            I(Y1(j):Y2(j), X1(j)) = 1;
            I(Y1(j):Y2(j), X1(j)+1) = 1;
            I(Y1(j):Y2(j), X2(j)) = 1;
            I(Y1(j):Y2(j), X2(j)-1) = 1;
            I(Y1(j), X1(j):X2(j)) = 1;
            I(Y1(j)+1, X1(j):X2(j)) = 1;
            I(Y2(j), X1(j):X2(j)) = 1;
            I(Y2(j)-1, X1(j):X2(j)) = 1;
        end
        imwrite(I, sprintf(['\\sub\\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\\partB\\HPF\\part_test\\rec_', sprintf('%03d', pair(2)), '_%03d.tif'], i), 'tif', 'compression', 'none');
    end
end
toc;