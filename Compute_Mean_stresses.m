%%% Compute contour over the 3D volume for uu, uv and vv for different q events
clear all;
close all;

fout = '\ReS_plot.dat';
fname1 = '\mean.dat';
[X_M Y_M Z_M U_M V_M W_M Div_M Q_M Lamb2_M wx_M wy_M wz_M Sol4 Sol5 Sol6 Sol7 Sol8 Sol9 Sol10 Sol11 Sol12] = textread(fname1, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

frame_st = 1:2:1700;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dir = '';
min_Y = 420;
max_Y = 2280;
% max_Y = 660;
min_X = 250;
max_X = 2760;
min_Z = 220;
max_Z = 1840;
% X_range = min_X:60:max_X;
% Y_range = min_Y:60:max_Y;
% Z_range = min_Z:60:max_Z;
%%%%%%%%%%%%%%%%%%%%%%%%

st_in = 1;
UU_total(1:length(X_M)) = 0;
UV_total(1:length(X_M)) = 0;
VV_total(1:length(X_M)) = 0;
UW_total(1:length(X_M)) = 0;
WW_total(1:length(X_M)) = 0;
UU_q1_total(1:length(X_M)) = 0;
UU_q2_total(1:length(X_M)) = 0;
UU_q3_total(1:length(X_M)) = 0;
UU_q4_total(1:length(X_M)) = 0;
UV_q1_total(1:length(X_M)) = 0;
UV_q2_total(1:length(X_M)) = 0;
UV_q3_total(1:length(X_M)) = 0;
UV_q4_total(1:length(X_M)) = 0;
VV_q1_total(1:length(X_M)) = 0;
VV_q2_total(1:length(X_M)) = 0;
VV_q3_total(1:length(X_M)) = 0;
VV_q4_total(1:length(X_M)) = 0;
tot_count(1:length(X_M)) = 0;
q1_count(1:length(X_M)) = 0;
q2_count(1:length(X_M)) = 0;
q3_count(1:length(X_M)) = 0;
q4_count(1:length(X_M)) = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k = 1:length(frame_st)
    pair = [frame_st(k), frame_st(k) + 1];
    fname = [dir, sprintf('sub_%03d-%03d.dat', pair(1), pair(2))];
    [X Y Z U V W Div Q Lamb2 w_x w_y w_z uv] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 16);
%     [X Y Z U V W Div Q Lamb2 wx wy wz Sol4 Sol5 Sol6 Sol7 Sol8 Sol9 Sol10 Sol11 Sol12] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);
    idx1 = find((X<min_X | X>max_X | Y<min_Y | Y>max_Y | Z<min_Z | Z>max_Z));% & abs((Z-1499)/450) > 0.4);
    U(idx1) = 0;
    V(idx1) = 0;
    W(idx1) = 0;
    for i = 1:length(X)
            
        %%%%%%%%%%
        
        if (abs(U(i)) + abs(V(i)) > 0)
            tot_count(i) = tot_count(i) + 1;
        end
        if U(i)>0 && V(i)>0
            UU_q1_total(i) = UU_q1_total(i) + U(i)*U(i);
            UV_q1_total(i) = UV_q1_total(i) + U(i)*V(i);
            VV_q1_total(i) = VV_q1_total(i) + V(i)*V(i);
            q1_count(i) = q1_count(i) + 1;
        elseif U(i)<0 && V(i)>0
            UU_q2_total(i) = UU_q2_total(i) + U(i)*U(i);
            UV_q2_total(i) = UV_q2_total(i) + U(i)*V(i);
            VV_q2_total(i) = VV_q2_total(i) + V(i)*V(i);
            q2_count(i) = q2_count(i) + 1;
        elseif U(i)<0 && V(i)<0
            UU_q3_total(i) = UU_q3_total(i) + U(i)*U(i);
            UV_q3_total(i) = UV_q3_total(i) + U(i)*V(i);
            VV_q3_total(i) = VV_q3_total(i) + V(i)*V(i);
            q3_count(i) = q3_count(i) + 1;
        elseif U(i)>0 && V(i)<0
            UU_q4_total(i) = UU_q4_total(i) + U(i)*U(i);
            UV_q4_total(i) = UV_q4_total(i) + U(i)*V(i);
            VV_q4_total(i) = VV_q4_total(i) + V(i)*V(i);
            q4_count(i) = q4_count(i) + 1;
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

idx = find(tot_count > 10);
idx_a = find(tot_count <= 10);
UU_total(idx) = UU_total(idx)./tot_count(idx);
UV_total(idx) = UV_total(idx)./tot_count(idx);
VV_total(idx) = VV_total(idx)./tot_count(idx);
UW_total(idx) = UW_total(idx)./tot_count(idx);
WW_total(idx) = WW_total(idx)./tot_count(idx);
UU_total(idx_a) = 0;
UV_total(idx_a) = 0;
VV_total(idx_a) = 0;
UW_total(idx_a) = 0;
WW_total(idx_a) = 0;


idx1 = find(tot_count > 10 & q1_count > 0);
idx1_a = find(tot_count <= 10 | q1_count == 0);
UU_q1_total(idx1) = UU_q1_total(idx1)./q1_count(idx1);
UV_q1_total(idx1) = UV_q1_total(idx1)./q1_count(idx1);
VV_q1_total(idx1) = VV_q1_total(idx1)./q1_count(idx1);
UU_q1_total(idx1_a) = 0;
UV_q1_total(idx1_a) = 0;
VV_q1_total(idx1_a) = 0;

idx2 = find(tot_count > 10 & q2_count > 0);
idx2_a = find(tot_count <= 10 | q2_count == 0);
UU_q2_total(idx2) = UU_q2_total(idx2)./q2_count(idx2);
UV_q2_total(idx2) = UV_q2_total(idx2)./q2_count(idx2);
VV_q2_total(idx2) = VV_q2_total(idx2)./q2_count(idx2);
UU_q2_total(idx2_a) = 0;
UV_q2_total(idx2_a) = 0;
VV_q2_total(idx2_a) = 0;
    
idx3 = find(tot_count > 10 & q3_count > 0);
idx3_a = find(tot_count <= 10 | q3_count == 0);
UU_q3_total(idx3) = UU_q3_total(idx3)./q3_count(idx3);
UV_q3_total(idx3) = UV_q3_total(idx3)./q3_count(idx3);
VV_q3_total(idx3) = VV_q3_total(idx3)./q3_count(idx3);
UU_q3_total(idx3_a) = 0;
UV_q3_total(idx3_a) = 0;
VV_q3_total(idx3_a) = 0;
    
idx4 = find(tot_count > 10 & q4_count > 0);
idx4_a = find(tot_count <= 10 | q4_count == 0);
UU_q4_total(idx4) = UU_q4_total(idx4)./q4_count(idx4);
UV_q4_total(idx4) = UV_q4_total(idx4)./q4_count(idx4);
VV_q4_total(idx4) = VV_q4_total(idx4)./q4_count(idx4);
UU_q4_total(idx4_a) = 0;
UV_q4_total(idx4_a) = 0;
VV_q4_total(idx4_a) = 0;

for i = 1:length(X)
    id = find(abs(X-X(i))<=60 & abs(Y-Y(i))<=60 & abs(Z-Z(i))<=60 & UU_total'>0);
    if length(id)>6
        UU_total(i) = mean(UU_total(id));
        UV_total(i) = mean(UV_total(id));
        VV_total(i) = mean(VV_total(id));
        UW_total(i) = mean(UW_total(id));
        WW_total(i) = mean(WW_total(id));
    end
end      

% fid = fopen(fout1, 'w+');
% fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"up"\n"vp"\n"wp"\n"Lamb2"\n"w_x"\n"w_y"\n"w_z"\n"UU"\n"UU_q1"\n"UU_q2"\n"UU_q3"\n"UU_q4"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
% for j=1:length(X)
%     fprintf(fid, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', X(j),Y(j),Z(j),tot_count(j),V(j),W(j),Lamb2(j),w_x(j),w_y(j),w_z(j),UU_total(j),UU_q1_total(j),UU_q2_total(j),...
%         UU_q3_total(j),UU_q4_total(j));
% end
% fclose(fid);
% 
% fid = fopen(fout2, 'w+');
% fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"up"\n"vp"\n"wp"\n"Lamb2"\n"w_x"\n"w_y"\n"w_z"\n"UV"\n"UV_q1"\n"UV_q2"\n"UV_q3"\n"UV_q4"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
% for j=1:length(X)
%     fprintf(fid, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', X(j),Y(j),Z(j),U(j),V(j),W(j),Lamb2(j),w_x(j),w_y(j),w_z(j),UV_total(j),UV_q1_total(j),UV_q2_total(j),...
%         UV_q3_total(j),UV_q4_total(j));
% end
% fclose(fid);
% 
% fid = fopen(fout3, 'w+');
% fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"up"\n"vp"\n"wp"\n"Lamb2"\n"w_x"\n"w_y"\n"w_z"\n"VV"\n"VV_q1"\n"VV_q2"\n"VV_q3"\n"VV_q4"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
% for j=1:length(X)
%     fprintf(fid, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', X(j),Y(j),Z(j),U(j),V(j),W(j),Lamb2(j),w_x(j),w_y(j),w_z(j),VV_total(j),VV_q1_total(j),VV_q2_total(j),...
%         VV_q3_total(j),VV_q4_total(j));
% end
% fclose(fid);

fid = fopen(fout, 'w+');
fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"up"\n"vp"\n"wp"\n"Lamb2"\n"w_x"\n"w_y"\n"w_z"\n"UU"\n"UV"\n"VV"\n"UW"\n"WW"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
for j=1:length(X)
    fprintf(fid, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', X(j),Y(j),Z(j),U(j),V(j),W(j),Lamb2(j),w_x(j),w_y(j),w_z(j),UU_total(j),UV_total(j),VV_total(j),UW_total(j),WW_total(j));
end
fclose(fid);

%%%% Calculate Stress Profile

Y_range = min_Y:60:max_Y-180;

figure(4);
for i = 1:length(Y_range)
    y(i) = Y_range(i);
    idx = find((abs(UU_total) + abs(VV_total) > 0)' & Y == y(i));
    UU_tot(i) = mean(UU_total(idx));
    UU_q1(i) = mean(UU_q1_total(idx));
    UU_q2(i) = mean(UU_q2_total(idx));
    UU_q3(i) = mean(UU_q3_total(idx));
    UU_q4(i) = mean(UU_q4_total(idx));
end
plot((y-450)/450, UU_q1, '.-');
hold;
plot((y-450)/450, UU_q4, 'r.-');
plot((y-450)/450, UU_q3, 'k.-');
plot((y-450)/450, UU_q2, 'g.-');
UU_tot = UU_q1+UU_q2+UU_q3+UU_q4;
legend('q1', 'q2', 'q3', 'q4');
xlabel('y/k');
ylabel('<uu>');

figure(5);
for i = 1:length(Y_range)
    y(i) = Y_range(i);
    idx = find((abs(UU_total) + abs(VV_total) > 0)' & Y == y(i));
%     UV_tot(i) = mean(UV_total(idx));
    UV_q1(i) = mean(UV_q1_total(idx));
    UV_q2(i) = mean(UV_q2_total(idx));
    UV_q3(i) = mean(UV_q3_total(idx));
    UV_q4(i) = mean(UV_q4_total(idx));
end
UV_tot = UV_q1+UV_q2+UV_q3+UV_q4;
plot((y-450)/450, UV_q1, '.-');
hold;
plot((y-450)/450, -UV_q4, 'r.-');
plot((y-450)/450, UV_q3, 'k.-');
plot((y-450)/450, -UV_q2, 'g.-');
UV_tot = UV_q1+UV_q2+UV_q3+UV_q4;
legend('q1', 'q2', 'q3', 'q4');
xlabel('y/k');
ylabel('-<uv>');

figure(6);
for i = 1:length(Y_range)
    y(i) = Y_range(i);
    idx = find((abs(UU_total) + abs(VV_total) > 0)' & Y == y(i));
%     VV_tot(i) = mean(VV_total(idx)).*(y(i)/max(Y_range)).^0.5;
    VV_q1(i) = mean(VV_q1_total(idx));
    VV_q2(i) = mean(VV_q2_total(idx));
    VV_q3(i) = mean(VV_q3_total(idx));
    VV_q4(i) = mean(VV_q4_total(idx));
end
plot((y-450)/450, VV_q1, '.-');
hold;
plot((y-450)/450, VV_q2, 'r.-');
plot((y-450)/450, VV_q3, 'k.-');
plot((y-450)/450, VV_q4, 'g.-');
VV_tot = VV_q1+VV_q2+VV_q3+VV_q4;
legend('q1', 'q2', 'q3', 'q4');
xlabel('y/k');
ylabel('<vv>');

figure(7);
plot((y-450)/450, UU_tot, 'k.-');
xlabel('y/k');
ylabel('<uu>');

figure(8);
plot((y-450)/450, -UV_tot, 'k.-');
xlabel('y/k');
ylabel('-<uv>');

figure(9);
plot((y-450)/450, VV_tot, 'k.-');
xlabel('y/k');
ylabel('<vv>');