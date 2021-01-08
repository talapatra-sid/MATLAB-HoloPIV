clear all;
clc;
close all;
tic;
%%%%% Detect a structure with specified lambda-2 value
lamb_val = 3;
direc = '\vector_fields_2\';
frame_st = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fname1 = '\mean.dat';
[X_M Y_M Z_M U_M V_M W_M Div_M Q_M Lamb2_M wx_M wy_M wz_M Sol4 Sol5 Sol6 Sol7 Sol8 Sol9 Sol10 Sol11 Sol12] = textread(fname1, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);

id_M = find(abs(U_M)+abs(V_M)+abs(W_M)==0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lamb_tot(1:51*37*32) = 0;
% wx_tot(1:51*37*32) = 0;
% wy_tot(1:51*37*32) = 0;
% wz_tot(1:51*37*32) = 0;

cnt_low = 0;
cnt_high = 0;
cnt_low_sp1 = 0;
cnt_high_sp1 = 0;
cnt_low_sp2 = 0;
cnt_high_sp2 = 0;

Low_count = 354224;
High_count = 759786;

% Xc = 1650;
% Yc = 1380;
% Zc = 1030;
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
    
    %%% Total
    idx1 = find((abs(w_x)+abs(w_y)+abs(w_z)>0) &  Y<900 & Y>500 & Lamb2<lamb_val);
    idx2 = find((abs(w_x)+abs(w_y)+abs(w_z)>0) &  Y>900 & Lamb2<lamb_val);
    
    wx_tot_low(cnt_low+1:cnt_low+length(idx1)) = w_x(idx1);
    wy_tot_low(cnt_low+1:cnt_low+length(idx1)) = w_y(idx1);
    wz_tot_low(cnt_low+1:cnt_low+length(idx1)) = w_z(idx1);
    cnt_low = cnt_low + length(idx1);

    wx_tot_high(cnt_high+1:cnt_high+length(idx2)) = w_x(idx2);
    wy_tot_high(cnt_high+1:cnt_high+length(idx2)) = w_y(idx2);
    wz_tot_high(cnt_high+1:cnt_high+length(idx2)) = w_z(idx2);
    cnt_high = cnt_high + length(idx2);
      
    %%% sp2
    idx1 = find((abs(w_x)+abs(w_y)+abs(w_z)>0) & Y<900 & Y>500 & Z>675 & Z<1500 & Lamb2<lamb_val);
    idx2 = find((abs(w_x)+abs(w_y)+abs(w_z)>0) & Y>900 & Z>675 & Z<1500 & Lamb2<lamb_val);
    
    wx_tot_low_sp2(cnt_low_sp2+1:cnt_low_sp2+length(idx1)) = w_x(idx1);
    wy_tot_low_sp2(cnt_low_sp2+1:cnt_low_sp2+length(idx1)) = w_y(idx1);
    wz_tot_low_sp2(cnt_low_sp2+1:cnt_low_sp2+length(idx1)) = w_z(idx1);
    cnt_low_sp2 = cnt_low_sp2 + length(idx1);
% 
    wx_tot_high_sp2(cnt_high_sp2+1:cnt_high_sp2+length(idx2)) = w_x(idx2);
    wy_tot_high_sp2(cnt_high_sp2+1:cnt_high_sp2+length(idx2)) = w_y(idx2);
    wz_tot_high_sp2(cnt_high_sp2+1:cnt_high_sp2+length(idx2)) = w_z(idx2);
    cnt_high_sp2 = cnt_high_sp2 + length(idx2);
%     
%     %%%% sp1 ridge
    idx1 = find((abs(w_x)+abs(w_y)+abs(w_z)>0) & Y<900 & Y>500 & (Z<675 | Z>1500) & Lamb2<lamb_val);
    idx2 = find((abs(w_x)+abs(w_y)+abs(w_z)>0) & Y>900 & (Z<675 | Z>1500)& Lamb2<lamb_val);
            
    wx_tot_low_sp1(cnt_low_sp1+1:cnt_low_sp1+length(idx1)) = w_x(idx1);
    wy_tot_low_sp1(cnt_low_sp1+1:cnt_low_sp1+length(idx1)) = w_y(idx1);
    wz_tot_low_sp1(cnt_low_sp1+1:cnt_low_sp1+length(idx1)) = w_z(idx1);
    cnt_low_sp1 = cnt_low_sp1 + length(idx1);

    wx_tot_high_sp1(cnt_high_sp1+1:cnt_high_sp1+length(idx2)) = w_x(idx2);
    wy_tot_high_sp1(cnt_high_sp1+1:cnt_high_sp1+length(idx2)) = w_y(idx2);
    wz_tot_high_sp1(cnt_high_sp1+1:cnt_high_sp1+length(idx2)) = w_z(idx2);
    cnt_high_sp1 = cnt_high_sp1 + length(idx2);
%     
 end
    

%%%%%%%%%%%%%%%%%
k0 = 0.46*10^(-3);
ut = 0.156;
%%%%%%%%%%%%%%%%%

id_F = find(abs(wy_tot_low)>0 & abs(wx_tot_low)>0);

wi_low.wx = -wx_tot_low(id_F)*k0/ut;
wi_low.wy = -wy_tot_low(id_F)*k0/ut;
wi_low.wz = wz_tot_low(id_F)*k0/ut;
% file_out1 = [direc, 'wi_low_struct_span2.mat'];
% save(file_out1, 'wi_low');

id_F = find(abs(wx_tot_high)>0 & abs(wy_tot_high)>0);

wi_high.wx = -wx_tot_high(id_F)*k0/ut;
wi_high.wy = -wy_tot_high(id_F)*k0/ut;
wi_high.wz = wz_tot_high(id_F)*k0/ut;
% file_out2 = [direc, 'wi_high_struct_span2.mat'];
% save(file_out2, 'wi_high');

figure(1);
N = hist3([wi_low.wy', wi_low.wx'], 'Edges', {-0.01:0.0004:0.01, -0.01:0.0004:0.01});
[c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [40, 90, 200, 500, 800, 1400, 3000]*cnt_low/Low_count, 'Color', [0, 0, 0]);
% [c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [40, 90, 200, 500, 750, 950]*cnt_low/Low_count, 'Color', [0, 0, 0]);
set(gcf, 'colormap', gray)
xlim([-0.01, 0.01]);
ylim([-0.01, 0.01]);
colorbar;

figure(3);
N = hist3([wi_high.wy', (wi_high.wx)'], 'Edges', {-0.01:0.0004:0.01, -0.01:0.0004:0.01});
% [c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [50, 100, 250, 500, 1000, 1600], 'Color', [0, 0, 0]);
[c, h] = contourf(-0.01:0.0004:0.01, -0.01:0.0004:0.01, N, [50, 100, 250, 500, 1000, 1650, 3000]*cnt_high/High_count, 'Color', [0, 0, 0]);
set(gcf, 'colormap', gray)
xlim([-0.01, 0.01]);
ylim([-0.01, 0.01]);
colorbar;

% WZ = wi_high.wz(wi_high.wx<0);
% WX = wi_high.wx(wi_high.wx<0);
% RHO_HN = corr([tiedrank(WZ)', tiedrank(WX)'])
% 
% WZ = wi_high.wz(wi_high.wx>0);
% WX = wi_high.wx(wi_high.wx>0);
% RHO_HP = corr([tiedrank(WZ)', tiedrank(WX)'])
% 
% WZ = wi_low.wz(wi_low.wx<0);
% WX = wi_low.wx(wi_low.wx<0);
% RHO_LN = corr([tiedrank(WZ)', tiedrank(WX)'])
% 
% WZ = wi_low.wz(wi_low.wx>0);
% WX = wi_low.wx(wi_low.wx>0);
% RHO_LP = corr([tiedrank(WZ)', tiedrank(WX)'])

% Lamb_tot = Lamb_tot/counter;
% wx_tot = wx_tot/counter;
% wy_tot = wy_tot/counter;
% wz_tot = wz_tot/counter;
% % 
% fid = fopen([direc, 'n_v_0.1_structures.dat'], 'w+');
% fprintf(fid, 'TITLE     = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"u"\n"v"\n"w"\n"Div"\n"Q"\n"Lamb2"\n"w_x"\n"w_y"\n"w_z"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
% for j=1:length(X)
%     fprintf(fid, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', X(j), Y(j), Z(j), U(j), V(j), W(j), Div(j), Q(j), Lamb_tot(j), wx_tot(j), wy_tot(j), wz_tot(j));
% end
% fclose(fid);
toc;