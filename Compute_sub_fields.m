%%% Subtract Mean

clear all;
clc;

direc = '\sub_fields\';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

frame_st = [];

%%%%%%%%%%%%%%%%%%%% READ THE MEAN %%%%%%%%%%%%%%%%

dir = '\rec_';
fname1 = '\mean.dat';
[X_M Y_M Z_M U_M V_M W_M Div_M Q_M Lamb2_M wx_M wy_M wz_M Sol4 Sol5 Sol6 Sol7 Sol8 Sol9 Sol10 Sol11 Sol12] = textread(fname1, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);
idx_M = find(abs(U_M)+abs(V_M)+abs(W_M)~= 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k = 1:length(frame_st)
    pair = [frame_st(k), frame_st(k) + 1];
    str = [dir, sprintf('%03d-%03d',  pair(1), pair(2)), '\'];
    fname = [str, sprintf('grid_StructField_%03d-%03d_A0.dat', pair(1), pair(2))];
    [X Y Z U V W Div Q Lamb2 wx wy wz Sol4 Sol5 Sol6 Sol7 Sol8 Sol9 Sol10 Sol11 Sol12] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);
    idx1 = find(abs(U)+abs(V)+abs(W) ~= 0);
    id_f = intersect(idx1, idx_M);
    %%%%%%%%%%%%%%%%%%%%%%
    U = U;
    V = V;
    W = W;
    X_S = X_M;
    Y_S = Y_M;
    Z_S = Z_M;
    U_S(1:length(U_M)) = 0;
    V_S(1:length(U_M)) = 0;
    W_S(1:length(U_M)) = 0;
    Div_S(1:length(U_M)) = 0; 
    Q_S = Q_M';
    Lamb2_S = Lamb2_M';
    wx_S = wx_M';
    wy_S = wy_M';
    wz_S = wz_M';
    %%%%%%%%%%%%%%%%%%%%%%%
    U_S(id_f) = U(id_f)-U_M(id_f);
    V_S(id_f) = (V(id_f)-V_M(id_f));
    W_S(id_f) = W(id_f)-W_M(id_f);
    Div_S(id_f) = (U(id_f)-U_M(id_f)).*(V(id_f)-V_M(id_f));
    Q_S(id_f) = Q(id_f)-Q_M(id_f);
    Lamb2_S(id_f) = Lamb2(id_f);
    wx_S(id_f) = wx(id_f);
    wy_S(id_f) = wy(id_f);
    wz_S(id_f) = wz(id_f);
    %%%%%%%%%%%%%%%%%%%%%%%%
    
    id_q1 = find(V_S > 0 & U_S > 0);
    id_q2 = find(V_S > 0 & U_S < 0);
    id_q3 = find(V_S < 0 & U_S < 0);
    id_q4 = find(V_S < 0 & U_S > 0);
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    fname2 = [direc, 'sub_', sprintf('%03d-%03d.dat', pair(1), pair(2))];
    b = [X_S Y_S Z_S U_S' V_S' W_S' Div_S' Q_S' Lamb2_S' wx_S' wy_S' wz_S' U_S'.*V_S'];
    fid = fopen(fname2, 'w+');
    fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"u"\n"v"\n"w"\n"Div"\n"Q"\n"Lamb2"\n"w_x"\n"w_y"\n"w_z"\n"uv"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
    for j=1:length(b)
        fprintf(fid, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', b(j, :));
    end
    fclose(fid);
    clear U_S V_S W_S;
end