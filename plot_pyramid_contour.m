clear all;
X(1).range = [-1262:8:1200]*0.67;
Y(1).range = [-662:8:1800]*0.67;
X(2).range = [1200:8:3662]*0.67;
Y(2).range = [-662:8:1800]*0.67;
X(3).range = [-1262:8:1200]*0.67;
Y(3).range = [1800:8:4262]*0.67;
X(4).range = [1200:8:3662]*0.67;
Y(4).range = [1800:8:4262]*0.67;
X(5).range = [1250:8:3712]*0.67;
Y(5).range = [1850:8:4312]*0.67;
X(6).range = [1250:8:3712]*0.67;
Y(6).range = [-712:8:1750]*0.67;
X(7).range = [3712:8:6174]*0.67;
Y(7).range = [1850:8:4312]*0.67;
X(8).range = [3712:8:6174]*0.67;
Y(8).range = [-712:8:1750]*0.67;

slope1(1) = 0.2728;
slope2(1) =  0.2728;
C(1) = -98.3347;
slope1(2) =  -0.2728;
slope2(2) = 0.2728;
C(2) = 340.3331;
slope1(3) = 0.2728;
slope2(3) = -0.2728;
C(3) = 559.6669;
slope1(4) = -0.2728;
slope2(4) = -0.2728;
C(4) = 998.3347;
slope1(5) = 0.2728;
slope2(5) = 0.2728;
C(5) =  -1.0166e+003;
slope1(6) = 0.2728;
slope2(6) = -0.2728;
C(6) = -358.6109;
slope1(7) = -0.2728;
slope2(7) = 0.2728;
C(7) = 340.3331;
slope1(8) = -0.2728;
slope2(8) = -0.2728;
C(8) = 998.3347;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:8
    slopeA = slope1(i);
    slopeB = slope2(i);
    CC = C(i);
    cnt = 0;
    for j = 1:length(Y(i).range)
            for k = 1:length(X(i).range)
                cnt = cnt + 1;
                point = [X(i).range(k), Y(i).range(j)];
                X_coor(cnt) = point(1);
                Y_coor(cnt) = point(2);
                Z_coor(cnt) = slopeA*X_coor(cnt) + slopeB*Y_coor(cnt) + CC;
                if Z_coor(cnt) >= 0
                     T(cnt) = 1;
                else
                     T(cnt) = 0;
                end
        end
    end
    fid = fopen(sprintf('\\face%1d.dat', i), 'w+' );
    fprintf( fid, 'x \t y \t z\t T\n' );
    for i=1:length(X_coor)
        fprintf(fid, '%.3f \t %.3f \t %.3f \t %.3f \n',X_coor(i),Y_coor(i),Z_coor(i),T(i));
    end
    fclose(fid);
end