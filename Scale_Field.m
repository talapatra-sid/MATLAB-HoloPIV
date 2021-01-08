%%% Scale SmfiltVelo
clear all;
x0 = 1820.6;
z0 = 1498.8;
y0 = 450;
k0 = 450;

frame_st = [];

file_In = '\\grid_StructField_%03d-%03d_A0.dat';
file_Out = '\\grid_StructField_%03d-%03d_Final.dat';
str = '';
str2 = '';
macro_file = '\batch.mcr';

%%% Scale entire 3D field

for i = 1:length(frame_st)
    pair = [frame_st(i), frame_st(i)+1];
    [X Y Z U V W Div Q Lamb2 w_x w_y w_z] = textread(sprintf(file_In, pair(1), pair(2), pair(1), pair(2)), '%f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 15);
    X1 = (X-x0)/k0;
    Z1 = (Z-z0)/k0;
    Y1 = (Y-y0)/k0;
    b = [X1 Y1 Z1 U V W Div Q Lamb2 w_x w_y w_z];
    fid = fopen(sprintf(file_Out, pair(1), pair(2)), 'w+');
    fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"u"\n"v"\n"w"\n"Div"\n"Q"\n"Lamb2"\n"w_x"\n"w_y"\n"w_z"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
    for j=1:length(b)
        fprintf(fid, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', b(j, :));
    end
    fclose(fid);
end
% 
% A. Scale YZ planes
Range1 = 360:60:2640;
for i = 1:length(frame_st)
    pair = [frame_st(i), frame_st(i)+1];
    str_tmp1 = [str, sprintf('rec_%03d-%03d\\', pair(1), pair(2)), 'YZ_planes\'];
    str_tmp2 = [str, 'Scaled\', sprintf('%03d-%03d\\', pair(1), pair(2))];
    str_tmp3 = [str_tmp2, 'YZ_planes\'];
    mkdir(str_tmp2);
    mkdir(str_tmp3);
    for j = 1:length(Range1)
        file_in = [str_tmp1, sprintf('YZ_%d.dat', Range1(j))];
        [Z Y W V wx] = textread(file_in, '%f %f %f %f %f', 'headerlines', 8);
        Z1 = (Z-z0)/k0;
        Y1 = (Y-y0)/k0; 
        file_out = [str_tmp3, sprintf('YZ_%d.dat', Range1(j))];
        fid = fopen(file_out, 'w+');
        fprintf(fid, 'TITLE = "INITIAL" \nVARIABLES = "z"\n"y"\n"w"\n"v"\n"<greek>w</greek><sub>x</sub>"\nZONE T="zeros"\nI=32, J=37, F=POINT\n');
        for k = 1:length(Y)
            fprintf(fid, '%f\t%f\t%f\t%f\t%f\n', Z1(k), Y1(k), W(k), V(k), wx(k));
        end
        fclose(fid);
    end
end
% 
% % 
% % %%% B. Scale XZ planes
Range1 = 360:60:2280;
for i = 1:length(frame_st)
    pair = [frame_st(i), frame_st(i)+1];
    str_tmp1 = [str, sprintf('rec_%03d-%03d\\', pair(1), pair(2)), 'XZ_planes\'];
    str_tmp2 = [str, 'Scaled\', sprintf('%03d-%03d\\', pair(1), pair(2))];
    str_tmp3 = [str_tmp2, 'XZ_planes\'];
    mkdir(str_tmp3);
    for j = 1:length(Range1)
        file_in = [str_tmp1, sprintf('XZ_%d.dat', Range1(j))];
        [X Z U W vel] = textread(file_in, '%f %f %f %f %f', 'headerlines', 8);
        X1 = (X-x0)/k0;
        Z1 = (Z-z0)/k0;
        file_out = [str_tmp3, sprintf('XZ_%d.dat', Range1(j))];
        fid = fopen(file_out, 'w+');
        fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"z"\n"u"\n"v"\n"|u<sub>i</sub>|"\nZONE T="zeros"\nI=51, J=32, F=POINT\n');
        for k=1:length(X)
            fprintf(fid, '%f\t%f\t%f\t%f\t%f\n', X1(k), Z1(k), U(k), W(k), vel(k));
        end
        fclose(fid);
    end
end
% % % 
% % %%% C. Scale wx planes
Range1 = 360:60:2280;
for i = 1:length(frame_st)
    pair = [frame_st(i), frame_st(i)+1];
    str_tmp1 = [str, sprintf('rec_%03d-%03d\\', pair(1), pair(2)), 'wx\'];
    str_tmp2 = [str, 'Scaled\', sprintf('%03d-%03d\\', pair(1), pair(2))];
    str_tmp3 = [str_tmp2, 'wx\'];
    mkdir(str_tmp3);
    for j = 1:length(Range1)
        file_in = [str_tmp1, sprintf('wx_%d.dat', Range1(j))];
        [X Z wx] = textread(file_in, '%f %f %f', 'headerlines', 6);
        X1 = (X-x0)/k0;
        Z1 = (Z-z0)/k0;
        file_out = [str_tmp3, sprintf('wx_%d.dat', Range1(j))];
        fid = fopen(file_out, 'w+');
        fprintf(fid, sprintf('TITLE = "INITIAL" \nVARIABLES = "x"\n"z"\n"<greek>w</greek><sub>x</sub>"\nZONE T="zeros"\nI=%d, J=%d, F=POINT\n', 51, 32));
        for k = 1:length(X1)
            fprintf(fid, '%f\t%f\t%f\t\n', X1(k), Z1(k), wx(k));
        end
        fclose(fid);  
    end
end
% % % 
% %%% D. Scale wy planes
Range1 = 360:60:2280;
for i = 1:length(frame_st)
    pair = [frame_st(i), frame_st(i)+1];
    str_tmp1 = [str, sprintf('rec_%03d-%03d\\', pair(1), pair(2)), 'wy\'];
    str_tmp2 = [str, 'Scaled\', sprintf('%03d-%03d\\', pair(1), pair(2))];
    str_tmp3 = [str_tmp2, 'wy\'];
    mkdir(str_tmp3);
    for j = 1:length(Range1)
        file_in = [str_tmp1, sprintf('wy_%d.dat', Range1(j))];
        [X Z wy] = textread(file_in, '%f %f %f', 'headerlines', 6);
        X1 = (X-x0)/k0;
        Z1 = (Z-z0)/k0;
        file_out = [str_tmp3, sprintf('wy_%d.dat', Range1(j))];
        fid = fopen(file_out, 'w+');
        fprintf(fid, sprintf('TITLE = "INITIAL" \nVARIABLES = "x"\n"z"\n"<greek>w</greek><sub>y</sub>"\nZONE T="zeros"\nI=%d, J=%d, F=POINT\n', 51, 32));
        for k = 1:length(X1)
            fprintf(fid, '%f\t%f\t%f\t\n', X1(k), Z1(k), wy(k));
        end
        fclose(fid);  
    end
end
% % 

%%% E. Scale wz planes (XZ plane)
Range1 = 360:60:2280;
for i = 1:length(frame_st)
    pair = [frame_st(i), frame_st(i)+1];
    str_tmp1 = [str, sprintf('rec_%03d-%03d\\', pair(1), pair(2)), 'wz\'];
    str_tmp2 = [str, 'Scaled\', sprintf('%03d-%03d\\', pair(1), pair(2))];
    str_tmp3 = [str_tmp2, 'wz\'];
    mkdir(str_tmp3);
    for j = 1:length(Range1)
        file_in = [str_tmp1, sprintf('wz_%d.dat', Range1(j))];
        [X Z wz] = textread(file_in, '%f %f %f', 'headerlines', 6);
        X1 = (X-x0)/k0;
        Z1 = (Z-z0)/k0;
        file_out = [str_tmp3, sprintf('wz_%d.dat', Range1(j))];
        fid = fopen(file_out, 'w+');
        fprintf(fid, sprintf('TITLE = "INITIAL" \nVARIABLES = "x"\n"z"\n"<greek>w</greek><sub>z</sub>"\nZONE T="zeros"\nI=%d, J=%d, F=POINT\n', 51, 32));
        for k = 1:length(X1)
            fprintf(fid, '%f\t%f\t%f\t\n', X1(k), Z1(k), wz(k));
        end
        fclose(fid);  
    end
end

% %%% F. Scale wz planes (XY plane)
Range1 = 160:60:1900;
for i = 1:length(frame_st)
    pair = [frame_st(i), frame_st(i)+1];
    str_tmp1 = [str, sprintf('rec_%03d-%03d\\', pair(1), pair(2)), 'wz1\'];
    str_tmp2 = [str, 'Scaled\', sprintf('%03d-%03d\\', pair(1), pair(2))];
    str_tmp3 = [str_tmp2, 'wz1\'];
    mkdir(str_tmp3);
    for j = 1:length(Range1)
        file_in = [str_tmp1, sprintf('wz_%d.dat', Range1(j))];
        [X Y wz] = textread(file_in, '%f %f %f', 'headerlines', 6);
        X1 = (X-x0)/k0;
        Y1 = (Y-k0)/k0;
        file_out = [str_tmp3, sprintf('wz_%d.dat', Range1(j))];
        fid = fopen(file_out, 'w+');
        fprintf(fid, sprintf('TITLE = "INITIAL" \nVARIABLES = "x"\n"y"\n"<greek>w</greek><sub>z</sub>"\nZONE T="zeros"\nI=%d, J=%d, F=POINT\n', 51, 37));
        for k = 1:length(X1)
            fprintf(fid, '%f\t%f\t%f\t\n', X1(k), Y1(k), wz(k));
        end
        fclose(fid);  
    end
end
% 
% %%%% A1. Plot YZ planes
% 
str = '\Results\';

lay_file = [ str, 'Scaled\YZ_plane.lay'];
Range1 = [360:60:2640];
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\YZ_planes', pair(1), pair(2)), '\\YZ_%04d.jpg'];
    dat_str = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\YZ_planes', pair(1), pair(2)), '\\YZ_%d.dat'];
    for i = 1:length(Range1)
        str11 = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, Range1(i)), '" "', lay_file, '" "', sprintf(dat_str, Range1(i)), '"'];
        system(str11);
    end
end
% 
% %%%% B1. Plot XZ planes
% 
lay_file = [ str, 'Scaled\XZ_plane_1.lay'];
Range1 = 360:60:900;
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\XZ_planes', pair(1), pair(2)), '\\XZ_%04d.jpg'];
    dat_str = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\XZ_planes', pair(1), pair(2)), '\\XZ_%d.dat'];
    for i = 1:length(Range1)
        str11 = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, Range1(i)), '" "', lay_file, '" "', sprintf(dat_str, Range1(i)), '"'];
        system(str11);
    end
end
lay_file = [ str, 'Scaled\XZ_plane_2.lay'];
Range1 = 960:60:2280;
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\XZ_planes', pair(1), pair(2)), '\\XZ_%04d.jpg'];
    dat_str = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\XZ_planes', pair(1), pair(2)), '\\XZ_%d.dat'];
    for i = 1:length(Range1)
        str11 = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, Range1(i)), '" "', lay_file, '" "', sprintf(dat_str, Range1(i)), '"'];
        system(str11);
    end
end
% 
% %%%%% C1. Plot wx planes
% 
lay_file = [str, 'Scaled\wx.lay'];
Range1 = 360:60:2280;
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\wx', pair(1), pair(2)), '\\wx_%04d.jpg'];
    dat_str = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\wx', pair(1), pair(2)), '\\wx_%d.dat'];
    for i = 1:length(Range1)
        str11 = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, Range1(i)), '" "', lay_file, '" "', sprintf(dat_str, Range1(i)), '"'];
        system(str11);
    end
end
% % % 
% % %%%% D1. Plot wy planes
% % 
lay_file = [str, 'Scaled\wy.lay'];
Range1 = 360:60:2280;
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\wy', pair(1), pair(2)), '\\wy_%04d.jpg'];
    dat_str = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\wy', pair(1), pair(2)), '\\wy_%d.dat'];
    for i = 1:length(Range1)
        str11 = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, Range1(i)), '" "', lay_file, '" "', sprintf(dat_str, Range1(i)), '"'];
        system(str11);
    end
end

% 
%%%%% E1. Plot wz planes
% 

% str = 'D:\2010_HPIV\Results_9\';

lay_file = [str, 'Scaled\wz.lay'];
Range1 = 360:60:2280;
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\wz', pair(1), pair(2)), '\\wz_%04d.jpg'];
    dat_str = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\wz', pair(1), pair(2)), '\\wz_%d.dat'];
    for i = 1:length(Range1)
        str11 = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, Range1(i)), '" "', lay_file, '" "', sprintf(dat_str, Range1(i)), '"'];
        system(str11);
    end
end

% 
%%%%% F1. Plot wz planes
% 

str = 'D:\2010_HPIV\Results_9\';

lay_file = [str, 'Scaled\wz1.lay'];
Range1 = 160:60:1900;
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\wz1', pair(1), pair(2)), '\\wz_%04d.jpg'];
    dat_str = [str2, 'Scaled\\', sprintf('%03d-%03d\\\\wz1', pair(1), pair(2)), '\\wz_%d.dat'];
    for i = 1:length(Range1)
        str11 = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, Range1(i)), '" "', lay_file, '" "', sprintf(dat_str, Range1(i)), '"'];
        system(str11);
    end
end