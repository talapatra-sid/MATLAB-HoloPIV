clear all;
clc;

ZC = []; %% LSE point
YC = [];

x0 = 1820.6;
z0 = 1498.8;
y0 = 460;
k = 460;

for m = 1:length(ZC)
    for n = 1:length(YC)
        tic;
        Z_center = ZC(m);
        Y_center = YC(n);
        fname = ['\', sprintf('LSE_L2_Z_%04d_Y_%04d_A.dat', Z_center, Y_center)];
        fout = ['\scaled\', sprintf('LSE_L2_Z_%04d_Y_%04d.dat', Z_center, Y_center)];
        [X Y Z U V W Lamb2 L2 w_x w_y w_z] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 14);
        X1 = (X-x0)/k;
        Z1 = (Z-z0)/k;
        Y1 = (Y-y0)/k;
        b = [X1 Y1 Z1 U V W Lamb2 L2 w_x w_y w_z];
        fid = fopen(fout, 'w+');
        fprintf(fid, 'TITLE  = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"u"\n"v"\n"w"\n"Lamb2"\n"L2"\n"w_x"\n"w_y"\n"w_z"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
        for j=1:length(b)
            fprintf(fid, '%f %f %f %f %f %f %f %f %f %f %f\n', b(j, :));
        end
        fclose(fid);
        toc;
    end
end

