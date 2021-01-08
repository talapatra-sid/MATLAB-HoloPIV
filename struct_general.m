%%% Read from 3D vector field and write XZ plane maps/ and also YZ plane
clear all;

frame_st = [];
dir = '\rec_';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k = 1:length(frame_st)
    pair = [frame_st(k), frame_st(k) + 1];
    str = [dir, sprintf('%03d-%03d',  pair(1), pair(2)), '\'];
    fname = [str, sprintf('Sm_Filt_StructField_%03d-%03d_A00.dat', pair(1), pair(2))];
    [X Y Z U V W Div Q Lamb2 w_x w_y w_z] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 15);
    a = [X Y Z U V W Div Q Lamb2 w_x w_y w_z];
    %%% Create XZ_planes directory
    mkdir([str, 'XZ_planes']);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = min(Y):60:max(Y)-100
        idx = find(Y == i);
        b = a(idx, 1:6);
        X = b(:, 1);
        Z = b(:, 3);
        U = b(:, 4);
        W = b(:, 6);
        fname =[str, 'XZ_planes\XZ', sprintf('_%d.dat', i)];
        fid = fopen(fname, 'w+');
        fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"z"\n"u"\n"v"\n"|u<sub>i</sub>|"\nZONE T="zeros"\nI=51, J=32, F=POINT\n');
        for j=1:length(idx)
            fprintf(fid, '%f\t%f\t%f\t%f\t%f\n', X(j), Z(j), U(j), W(j), sqrt(U(j)^2 + W(j)^2));
        end
        fclose(fid);
    end
end
% %%%%
for k = 1:length(frame_st)
    pair = [frame_st(k), frame_st(k) + 1];
    str = [dir, sprintf('%03d-%03d',  pair(1), pair(2)), '\'];
    fname = [str, sprintf('Sm_Filt_StructField_%03d-%03d_A00.dat', pair(1), pair(2))];
    [X Y Z U V W Div Q Lamb2 w_x w_y w_z] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 15);
    a = [X Y Z U V W Div Q Lamb2 w_x w_y w_z];
    %%% Create wx_planes directory
    mkdir([str, 'wx']);
    mkdir([str, 'wy']);
    mkdir([str, 'wz']);
    for i = min(Y):60:max(Y)
        idx = find(Y == i);
        X1 = X(idx);
        Y1 = Y(idx);
        Z1 = Z(idx);
        wx1 = w_x(idx);
        wy1 = w_y(idx);
        wz1 = w_z(idx);
        %%%%
        fname = [str, sprintf('wx\\wx_%d.dat', i)];
        fid = fopen(fname, 'w+');
        fprintf(fid, sprintf('TITLE = "INITIAL" \nVARIABLES = "x"\n"z"\n"<greek>w</greek><sub>x</sub>"\nZONE T="zeros"\nI=%d, J=%d, F=POINT\n', 51, 32));
        for j = 1:length(X1)
            fprintf(fid, '%f\t%f\t%f\t\n', X1(j), Z1(j), wx1(j));
        end
        fclose(fid);
        %%%%
        fname = [str, sprintf('wy\\wy_%d.dat', i)];
        fid = fopen(fname, 'w+');
        fprintf(fid, sprintf('TITLE = "INITIAL" \nVARIABLES = "x"\n"z"\n"<greek>w</greek><sub>y</sub>"\nZONE T="zeros"\nI=%d, J=%d, F=POINT\n', 51, 32));
        for j = 1:length(X1)
            fprintf(fid, '%f\t%f\t%f\t\n', X1(j), Z1(j), wy1(j));
        end
        fclose(fid);
        %%%%
        fname = [str, sprintf('wz\\wz_%d.dat', i)];
        fid = fopen(fname, 'w+');
        fprintf(fid, sprintf('TITLE = "INITIAL" \nVARIABLES = "x"\n"z"\n"<greek>w</greek><sub>z</sub>"\nZONE T="zeros"\nI=%d, J=%d, F=POINT\n', 51, 32));
        for j = 1:length(X1)
            fprintf(fid, '%f\t%f\t%f\t\n', X1(j), Z1(j), wz1(j));
        end
        fclose(fid);  
    end
end
% %%%%%
for k = 1:length(frame_st)
    pair = [frame_st(k), frame_st(k) + 1];
    str = [dir, sprintf('%03d-%03d',  pair(1), pair(2)), '\'];
    fname = [str, sprintf('Sm_Filt_StructField_%03d-%03d_A00.dat', pair(1), pair(2))];
    [X Y Z U V W Div Q Lamb2 w_x w_y w_z] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 15);
    a = [X Y Z U V W Div Q Lamb2 w_x w_y w_z];
    mkdir([str, 'wz1']);
    for i = min(Z)+60:60:max(Z)-60
        idx = find(Z == i);
        X1 = X(idx);
        Y1 = Y(idx);
        wz1 = w_z(idx);
            
        %%%%
        fname = [str, sprintf('wz1\\wz_%d.dat', i)];
        fid = fopen(fname, 'w+');
        fprintf(fid, sprintf('TITLE = "INITIAL" \nVARIABLES = "x"\n"y"\n"<greek>w</greek><sub>z</sub>"\nZONE T="zeros"\nI=%d, J=%d, F=POINT\n', 51, 37));
        for j = 1:length(X1)
            fprintf(fid, '%f\t%f\t%f\t\n', X1(j), Y1(j), wz1(j));
        end
        fclose(fid);
    end
end

%%%%
for k = 1:length(frame_st)
    pair = [frame_st(k), frame_st(k) + 1];
    str = [dir, sprintf('%03d-%03d',  pair(1), pair(2)), '\'];
    fname = [str, sprintf('Sm_Filt_StructField_%03d-%03d_A00.dat', pair(1), pair(2))];
    [X Y Z U V W Div Q Lamb2 w_x w_y w_z] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 15);
    a = [X Y Z U V W Div Q Lamb2 w_x w_y w_z];
    id1 = find(abs(U)+abs(V)+abs(W) ~= 0);
    % Create YZ_planes directory
    mkdir([str, 'YZ_planes']);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = min(X)+240:60:max(X)-240
        idx = find(X == i);
        b = a(idx, 1:11);
        Y = b(:, 2);
        Z = b(:, 3);
        V = b(:, 5);
        W = b(:, 6);
        Wx = b(:, 10);
        fname =[str, 'YZ_planes\YZ_', sprintf('%d.dat', i)];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fid = fopen(fname, 'w+');
        fprintf(fid, 'TITLE = "INITIAL" \nVARIABLES = "z"\n"y"\n"w"\n"v"\n"<greek>w</greek><sub>x</sub>"\nZONE T="zeros"\nI=32, J=37, F=POINT\n');
        for j = 1:length(Y)
            fprintf(fid, '%f\t%f\t%f\t%f\t%f\n', Z(j), Y(j), W(j), V(j), Wx(j));
        end
        fclose(fid);
    end
end