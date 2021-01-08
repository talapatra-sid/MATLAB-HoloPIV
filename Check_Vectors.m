%%%% Check vectors against particles %%%%
clear all;
tic;
pair = [];
fid = fopen(['\sub\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\partB\HPF\trial1\outTrack_', sprintf('%03d-%03d', pair(1), pair(2)),'.dat'], 'r' );
fgets(fid);
a=fscanf( fid, '%f' );
b=reshape( a, [6,length(a)/6] )';
fclose(fid);

for i = 0:400
    f1 = find(round(b(:,3)) == i);
    if (isempty(f1) == 0)
        X1 = b(f1,1);
        Y1 = b(f1,2);
        Z1 = b(f1,3);
        X2 = b(f1,4);
        Y2 = b(f1,5);
        Z2 = b(f1,6);
        % Draw on both images %%
        I1 = im2double(imread(sprintf(['\\sub\\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\\partB\\HPF\\part_test\\rec_', sprintf('%03d', pair(1)), '_%03d.tif'], i)));
        for j = 1:length(X1)
            I2 = im2double(imread(sprintf(['\\sub\\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\\partB\\HPF\\part_test\\rec_', sprintf('%03d', pair(2)), '_%03d.tif'], round(Z2(j)))));
            dl = min([(1/(abs(X2(j)-X1(j))+1)), (1/(abs(Y2(j)-Y1(j))+1))]);
            x = max(1, round(X1(j) + (X2(j)-X1(j))*[0:dl:1]));
            y = max(1, round(Y1(j) + (Y2(j)-Y1(j))*[0:dl:1]));
            for k = 1:length(x)
                I1(y(k), x(k)) = 0;
                I1(y(k)+1, x(k)) = 0;
                I2(y(k), x(k)) = 0;
                I2(y(k)+1, x(k)) = 0;
            end
            imwrite(I2, sprintf(['\\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\\partB\\HPF\\part_test\\rec_', sprintf('%03d', pair(2)), '_%03d.tif'], round(Z2(j))), 'tif', 'compression', 'none');
        end
        imwrite(I1, sprintf(['\\sub\\rec_', sprintf('%03d-%03d', pair(1), pair(2)), '\\partB\\HPF\\part_test\\rec_', sprintf('%03d', pair(1)), '_%03d.tif'], i), 'tif', 'compression', 'none');
     end
end
toc;