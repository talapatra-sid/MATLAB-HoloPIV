% Tecplot batch Processing: Use a tecplot template, and generate XZ/XY/YZ
% plane tiff images using tecplot
% 1. YZ_planes
clear all;
Range = [300 2820]; %% Data files

frame_st = [];
macro_file = '\batch.mcr';

dir = '\\Results_8\\';
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\YZ_planes\\YZ_%04d.jpg'];
    dat_str = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\YZ_planes\\YZ_%d.dat'];
    for i = Range(1):60:Range(2)
        str = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, i), '" "', lay_file, '" "', sprintf(dat_str, i), '"'];
        system(str);
    end
end
%%% 2. XZ_planes
Range = [360 1800]; %% Data files
lay_file = '\XZ_plane_1.lay';
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\XZ_planes\\XZ_%04d.jpg'];
    dat_str = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\XZ_planes\\XZ_%d.dat'];
    for i = Range(1):60:Range(2)
        str = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, i), '" "', lay_file, '" "', sprintf(dat_str, i), '"'];
        system(str);
    end
end
%%% 2b. XZ_planes
Range = [1860 2340]; %% Data files
lay_file = '\XZ_plane_2.lay';
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\XZ_planes\\XZ_%04d.jpg'];
    dat_str = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\XZ_planes\\XZ_%d.dat'];
    for i = Range(1):60:Range(2)
        str = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, i), '" "', lay_file, '" "', sprintf(dat_str, i), '"'];
        system(str);
    end
end
%%% 3. w_x_planes
Range = [360 2340]; %% Data files
lay_file = '\wx.lay';
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\wx\\wx_%04d.jpg'];
    dat_str = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\wx\\wx_%d.dat'];
    for i = Range(1):60:Range(2)
        str = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, i), '" "', lay_file, '" "', sprintf(dat_str, i), '"'];
        system(str);
    end
end
%%% 4. w_y_planes
Range = [360 2340]; %% Data files
lay_file = '\wy.lay';
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\wy\\wy_%04d.jpg'];
    dat_str = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\wy\\wy_%d.dat'];
    for i = Range(1):60:Range(2)
        str = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, i), '" "', lay_file, '" "', sprintf(dat_str, i), '"'];
        system(str);
    end
end
%%% 5. w_z_planes
Range = [360 2340]; %% Data files
lay_file = '\wz.lay';
for k = 1:length(frame_st)
    pair = [frame_st(k) frame_st(k)+1];
    str_out = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\wz\\wz_%04d.jpg'];
    dat_str = [dir, sprintf('%03d-%03d', pair(1), pair(2)), '\\wz\\wz_%d.dat'];
    for i = Range(1):60:Range(2)
        str = ['tecplot -b -p "',  macro_file, '" -y "', sprintf(str_out, i), '" "', lay_file, '" "', sprintf(dat_str, i), '"'];
        system(str);
    end
end