clear all;
clc;
close all;
tic;
%%%%% Detect a structure with specified lambda-2 value
lamb_val = -1.5;
direc = '\vector_fields_2\';

frame_st = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fname1 = '\mean.dat';
[X_M Y_M Z_M U_M V_M W_M Div_M Q_M Lamb2_M wx_M wy_M wz_M Sol4 Sol5 Sol6 Sol7 Sol8 Sol9 Sol10 Sol11 Sol12] = textread(fname1, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);
id_M = find(abs(U_M)+abs(V_M)+abs(W_M)==0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cnt_low = 0;
cnt_mid = 0;
cnt_mid1 = 0;
cnt_high = 0;
cnt_low_sp1 = 0;
cnt_mid_sp1 = 0;
cnt_mid1_sp1 = 0;
cnt_high_sp1 = 0;
cnt_low_sp2 = 0;
cnt_mid_sp2 = 0;
cnt_mid1_sp2 = 0;
cnt_high_sp2 = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k = 1:length(frame_st)
    clc;
    pair = [frame_st(k), frame_st(k) + 1];
    str = [direc, sprintf('rec_%03d-%03d', pair(1), pair(2)), '\'];
    fname = [str, sprintf('grid_StructField_%03d-%03d_A0.dat', pair(1), pair(2))];
    fname1 = [str, sprintf('grid_StructField_%03d-%03d_A0_1.dat', pair(1), pair(2))];
    [X Y Z U V W Div Q Lamb2 w_x w_y w_z Sol4 Sol5 Sol6 Sol7 Sol8 Sol9 Sol10 Sol11 Sol12] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);
    U_S = U-U_M;
    V_S = V-V_M;
    W_S = W-W_M;
    w_x(id_M) = 0;
    w_y(id_M) = 0;
    w_z(id_M) = 0;
    
    w_x = w_x - wx_M;
    w_y = w_y - wy_M;
    w_z = w_z - wz_M;
    
    Lamb_org = Lamb2;
    idx = find(Lamb2 < lamb_val);
    Lamb2(1:length(Lamb2)) = 0;
    Lamb2(idx) = 1;
    count = 1;
    for a = 1:37
        for b = 1:32
            Lamb3d(1:51, b, a) = Lamb2(count:count+50);
            count = count + 51;
        end
    end
    L = bwlabeln(Lamb3d);
    
    count = 1;
    for a = 1:37
        for b = 1:32
            L_1d(count:count+50) = L(1:51, b, a);
            count = count + 51;
        end
    end
    
    Lamb_temp = Lamb_org;
    for i = 1:max(L(:))
%         Lamb_new(1:51*37*32) = 0;
%         wx_new(1:51*37*32) = 0;
%         wy_new(1:51*37*32) = 0;
%         wz_new(1:51*37*32) = 0;
        cnt = 0;
        idx = find(L_1d==i);
        L_temp = Lamb_org(idx);
        X_temp = X(idx);
        Y_temp = Y(idx);
        Z_temp = Z(idx);
%         idx1 = round(median(find(L_temp == max(L_temp))));
%         X_cent = X_temp(idx1);
%         Y_cent = Y_temp(idx1);
%         Z_cent = Z_temp(idx1);
        X_cent = mean(X(idx));
        Y_cent = mean(Y(idx));
        Z_cent = mean(Z(idx));
        dx = max(X_temp)-min(X_temp);
        dy = max(Y_temp)-min(Y_temp);
        dz = max(Z_temp)-min(Z_temp);

        %%% Now based on center of the structure, and structure size, we place it in a
        %%% different array for each region
        
        %%% Total
        if Y_cent<900  && max([dx, dy, dz]) > 200 && length(idx) > 20 
            wx_tot_low(cnt_low+1:cnt_low+length(idx)) = w_x(idx);
            wy_tot_low(cnt_low+1:cnt_low+length(idx)) = w_y(idx);
            wz_tot_low(cnt_low+1:cnt_low+length(idx)) = w_z(idx);
            cnt_low = cnt_low + length(idx);
        end
        if Y_cent>900 && Y_cent<1800 && max([dx, dy, dz]) > 200 && length(idx) > 20 
            wx_tot_mid(cnt_mid+1:cnt_mid+length(idx)) = w_x(idx);
            wy_tot_mid(cnt_mid+1:cnt_mid+length(idx)) = w_y(idx);
            wz_tot_mid(cnt_mid+1:cnt_mid+length(idx)) = w_z(idx);
            cnt_mid = cnt_mid + length(idx);
        end
        if Y_cent>1300 && Y_cent<1800 && max([dx, dy, dz]) > 200 && length(idx) > 20 
            wx_tot_mid1(cnt_mid1+1:cnt_mid1+length(idx)) = w_x(idx);
            wy_tot_mid1(cnt_mid1+1:cnt_mid1+length(idx)) = w_y(idx);
            wz_tot_mid1(cnt_mid1+1:cnt_mid1+length(idx)) = w_z(idx);
            cnt_mid1 = cnt_mid1 + length(idx);            
        end
        if Y_cent>1750 && max([dx, dy, dz]) > 200 && length(idx) > 20
            wx_tot_high(cnt_high+1:cnt_high+length(idx)) = w_x(idx);
            wy_tot_high(cnt_high+1:cnt_high+length(idx)) = w_y(idx);
            wz_tot_high(cnt_high+1:cnt_high+length(idx)) = w_z(idx);
            cnt_high = cnt_high + length(idx);
        end
        %%% sp1
        if Y_cent<900 && Y_cent>400 && max([dx, dy, dz]) > 200 && length(idx) > 20 && (Z_cent>685 && Z_cent<1500)
            wx_tot_low_sp2(cnt_low_sp2+1:cnt_low_sp2+length(idx)) = w_x(idx);
            wy_tot_low_sp2(cnt_low_sp2+1:cnt_low_sp2+length(idx)) = w_y(idx);
            wz_tot_low_sp2(cnt_low_sp2+1:cnt_low_sp2+length(idx)) = w_z(idx);
            cnt_low_sp2 = cnt_low_sp2 + length(idx);
        end
        if Y_cent>1300 && Y_cent<1700 && max([dx, dy, dz]) > 200 && length(idx) > 20 && (Z_cent>685 && Z_cent<1500)
            wx_tot_mid_sp2(cnt_mid_sp2+1:cnt_mid_sp2+length(idx)) = w_x(idx);
            wy_tot_mid_sp2(cnt_mid_sp2+1:cnt_mid_sp2+length(idx)) = w_y(idx);
            wz_tot_mid_sp2(cnt_mid_sp2+1:cnt_mid_sp2+length(idx)) = w_z(idx);
            cnt_mid_sp2 = cnt_mid_sp2 + length(idx);
        end
        if Y_cent>1300 && Y_cent<1750 && max([dx, dy, dz]) > 200 && length(idx) > 20 && (Z_cent>685 && Z_cent<1500)
            wx_tot_mid1_sp2(cnt_mid1_sp2+1:cnt_mid1_sp2+length(idx)) = w_x(idx);
            wy_tot_mid1_sp2(cnt_mid1_sp2+1:cnt_mid1_sp2+length(idx)) = w_y(idx);
            wz_tot_mid1_sp2(cnt_mid1_sp2+1:cnt_mid1_sp2+length(idx)) = w_z(idx);
            cnt_mid1_sp2 = cnt_mid1_sp2 + length(idx);            
        end
        if Y_cent>1750 && max([dx, dy, dz]) > 200 && length(idx) > 20 && (Z_cent>685 && Z_cent<1500)
            wx_tot_high_sp2(cnt_high_sp2+1:cnt_high_sp2+length(idx)) = w_x(idx);
            wy_tot_high_sp2(cnt_high_sp2+1:cnt_high_sp2+length(idx)) = w_y(idx);
            wz_tot_high_sp2(cnt_high_sp2+1:cnt_high_sp2+length(idx)) = w_z(idx);
            cnt_high_sp2 = cnt_high_sp2 + length(idx);
        end
%         %%%% sp2
        if Y_cent<900 && Y_cent>400 && max([dx, dy, dz]) > 200 && length(idx) > 20 && (Z_cent<685 || Z_cent>1500)
            wx_tot_low_sp1(cnt_low_sp1+1:cnt_low_sp1+length(idx)) = w_x(idx);
            wy_tot_low_sp1(cnt_low_sp1+1:cnt_low_sp1+length(idx)) = w_y(idx);
            wz_tot_low_sp1(cnt_low_sp1+1:cnt_low_sp1+length(idx)) = w_z(idx);
            cnt_low_sp1 = cnt_low_sp1 + length(idx);
        end
        if Y_cent>1300 && Y_cent<1700 && max([dx, dy, dz]) > 200 && length(idx) > 20 && (Z_cent<685 || Z_cent>1500)
            wx_tot_mid_sp1(cnt_mid_sp1+1:cnt_mid_sp1+length(idx)) = w_x(idx);
            wy_tot_mid_sp1(cnt_mid_sp1+1:cnt_mid_sp1+length(idx)) = w_y(idx);
            wz_tot_mid_sp1(cnt_mid_sp1+1:cnt_mid_sp1+length(idx)) = w_z(idx);
            cnt_mid_sp1 = cnt_mid_sp1 + length(idx);
        end
        if Y_cent>1300 && Y_cent<1800 && max([dx, dy, dz]) > 200 && length(idx) > 20 && (Z_cent<685 || Z_cent>1500)
            wx_tot_mid1_sp1(cnt_mid1_sp1+1:cnt_mid1_sp1+length(idx)) = w_x(idx);
            wy_tot_mid1_sp1(cnt_mid1_sp1+1:cnt_mid1_sp1+length(idx)) = w_y(idx);
            wz_tot_mid1_sp1(cnt_mid1_sp1+1:cnt_mid1_sp1+length(idx)) = w_z(idx);
            cnt_mid1_sp1 = cnt_mid1_sp1 + length(idx);            
        end
        if Y_cent>1750 && max([dx, dy, dz]) > 200 && length(idx) > 20 && (Z_cent<685 || Z_cent>1500)
            wx_tot_high_sp1(cnt_high_sp1+1:cnt_high_sp1+length(idx)) = w_x(idx);
            wy_tot_high_sp1(cnt_high_sp1+1:cnt_high_sp1+length(idx)) = w_y(idx);
            wz_tot_high_sp1(cnt_high_sp1+1:cnt_high_sp1+length(idx)) = w_z(idx);
            cnt_high_sp1 = cnt_high_sp1 + length(idx);
        end          
    end
    
%     idx = find(L_1d==17);
%     L_1d(1:length(L_1d)) = 0;
%     L_1d(idx) = lamb_val;
      
%     fid = fopen(fname1, 'w+');
%     fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"u"\n"v"\n"w"\n"Div"\n"Q"\n"Lamb2"\n"w_x"\n"w_y"\n"w_z"\n"L_struct"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
%     for j=1:length(X)
%         fprintf(fid, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', X(j), Y(j), Z(j), U(j), V(j), W(j), Div(j), Q(j), Lamb_new(j), w_x(j), w_y(j), w_z(j), L_1d(j));
%     end
%     fclose(fid);
    
    clear Lamb3d L_1d;
    
end
%%%%%%%%%%%%%%%%%
k0 = 0.46*10^(-3);
ut = 0.156;
%%%%%%%%%%%%%%%%%
id_F = find(abs(wy_tot_low_sp1)>0.0 & abs(wx_tot_low_sp1)>0.0);
wi_low.wx = wx_tot_low_sp1(id_F)*k0/ut;
wi_low.wy = wy_tot_low_sp1(id_F)*k0/ut;
wi_low.wz = wz_tot_low_sp1(id_F)*k0/ut;

id_F = find(abs(wy_tot_mid_sp1)>0.0 & abs(wz_tot_mid_sp1)>0.0);
wi_mid.wx = wx_tot_mid_sp1(id_F)*k0/ut;
wi_mid.wy = wy_tot_mid_sp1(id_F)*k0/ut;
wi_mid.wz = wz_tot_mid_sp1(id_F)*k0/ut;

id_F = find(abs(wx_tot_mid1_sp1)>0.0 & abs(wz_tot_mid1_sp1)>0.0);
wi_mid1.wx = wx_tot_mid1_sp1(id_F)*k0/ut;
wi_mid1.wy = wy_tot_mid1_sp1(id_F)*k0/ut;
wi_mid1.wz = wz_tot_mid1_sp1(id_F)*k0/ut;


id_F = find(abs(wy_tot_high_sp2)>0.0 & abs(wz_tot_high_sp2)>0.0);
wi_high.wx = wx_tot_high_sp2(id_F)*k0/ut;
wi_high.wy = wy_tot_high_sp2(id_F)*k0/ut;
wi_high.wz = wz_tot_high_sp2(id_F)*k0/ut;


figure(1);
N = hist3([wi_low.wy', wi_low.wx'], 'Edges', {-0.01:0.0004:0.01, -0.01:0.0004:0.01});
[c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [40, 90, 200, 500, 750, 1100]*cnt_low_sp1/cnt_low, 'Color', [0, 0, 0]);
% [c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [40, 90, 200, 500, 750, 1250]*cnt_low_sp1/cnt_low, 'Color', [0, 0, 0]);
set(gcf, 'colormap', gray);
xlim([-0.01, 0.01]);
ylim([-0.01, 0.01]);
colorbar;

figure(2);
N = hist3([wi_mid.wz', (wi_mid.wy)'], 'Edges', {-0.01:0.0004:0.01, -0.01:0.0004:0.01});
% [c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [50, 100, 250, 500, 1000, 1600], 'Color', [0, 0, 0]);
[c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [40, 90, 200, 500, 750, 1300]*cnt_mid_sp1/cnt_low, 'Color', [0, 0, 0]);
set(gcf, 'colormap', gray)
xlim([-0.01, 0.01]);
ylim([-0.01, 0.01]);
colorbar;

figure(3);
N = hist3([wi_mid1.wy', (wi_mid1.wx)'], 'Edges', {-0.01:0.0004:0.01, -0.01:0.0004:0.01});
% [c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [50, 100, 250, 500, 1000, 1600], 'Color', [0, 0, 0]);
[c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [20, 45, 90, 200, 400, 650, 900]*cnt_mid1_sp1/cnt_high, 'Color', [0, 0, 0]);
set(gcf, 'colormap', gray)
xlim([-0.01, 0.01]);
ylim([-0.01, 0.01]);
colorbar;

figure(4);
N = hist3([-wi_high.wy', (-wi_high.wx)'], 'Edges', {-0.01:0.0004:0.01, -0.01:0.0004:0.01});
% [c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [50, 100, 250, 500, 1000, 1600], 'Color', [0, 0, 0]);
[c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [20, 45, 90, 200, 400, 600, 1000]*cnt_high_sp2/cnt_high, 'Color', [0, 0, 0]);
set(gcf, 'colormap', gray)
xlim([-0.01, 0.01]);
ylim([-0.01, 0.01]);
colorbar;

toc;