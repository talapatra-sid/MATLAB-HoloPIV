%%% Calculate Mean Field
clear all;
clc;
% frame_st = [1, 7, 25, 31, 35, 39, 51, 67, 83, 101, 109, 75, 111, 137, 153, 159, 161, 165, 169, 179, 190];
% dir = 'E:\Oct_10_s1_1\sub\rec_';
% fname1 = 'E:\Oct_10_s1_1\sub\mean.dat';

direc = '';
frame_st = 1:2:1700;

fname1 = '\mean.dat';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k = 1:length(frame_st)
    pair = [frame_st(k), frame_st(k) + 1];
    fname = [direc, sprintf('grid_StructField_%03d-%03d_A0.dat', pair(1), pair(2))];
    [X Y Z U V W Div Q Lamb2 w_x w_y w_z Sol4 Sol5 Sol6 Sol7 Sol8 Sol9 Sol10 Sol11 Sol12] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);

    U1(k, :) = U;
    V1(k, :) = V;
    W1(k, :) = W;
    Wx1(k, :) = w_x;
    Wy1(k, :) = w_y;
    Wz1(k, :) = w_z;
    S4(k, :) = Sol4;
    S5(k, :) = Sol5;
    S6(k, :) = Sol6;
    S7(k, :) = Sol7;
    S8(k, :) = Sol8;
    S9(k, :) = Sol9;
    S10(k, :) = Sol10;
    S11(k, :) = Sol11;
    S12(k, :) = Sol12;
end
for i = 1:length(U)
    idx = find(U1(:, i).^2 + V1(:, i).^2 + W1(:, i).^2 ~= 0);
    if length(idx) > 150
        U_mean(i) = mean(U1(idx, i));
        V_mean(i) = mean(V1(idx, i));
        W_mean(i) = mean(W1(idx, i));
        Wx_mean(i) = mean(Wx1(idx, i));
        Wy_mean(i) = mean(Wy1(idx, i));
        Wz_mean(i) = mean(Wz1(idx, i));
        S4_mean(i) = mean(S4(idx, i));
        S5_mean(i) = mean(S5(idx, i));
        S6_mean(i) = mean(S6(idx, i));
        S7_mean(i) = mean(S7(idx, i));
        S8_mean(i) = mean(S8(idx, i));
        S9_mean(i) = mean(S9(idx, i));
        S10_mean(i) = mean(S10(idx, i));
        S11_mean(i) = mean(S11(idx, i));
        S12_mean(i) = mean(S12(idx, i));
        V_tensor = [S4_mean(i) S5_mean(i) S6_mean(i); S7_mean(i) S8_mean(i) S9_mean(i); S10_mean(i) S11_mean(i) S12_mean(i)];
        S_tensor = V_tensor + V_tensor';
        R_tensor = V_tensor - V_tensor';
        L2_mean(i) = median(eig(S_tensor*S_tensor + R_tensor*R_tensor));
    else
        U_mean(i) = 0;
        V_mean(i) = 0;
        W_mean(i) = 0;
        Wx_mean(i) = 0;
        Wy_mean(i) = 0;
        Wz_mean(i) = 0;
        S4_mean(i) = 0;
        S5_mean(i) = 0;
        S6_mean(i) = 0;
        S7_mean(i) = 0;
        S8_mean(i) = 0;
        S9_mean(i) = 0;
        S10_mean(i) = 0;
        S11_mean(i) = 0;
        S12_mean(i) = 0;
        L2_mean(i) = 0;
    end
end

b = [X Y Z U_mean' V_mean' W_mean' Div Q L2_mean' Wx_mean' Wy_mean' Wz_mean' S4_mean' S5_mean' S6_mean' S7_mean' S8_mean' S9_mean' S10_mean' S11_mean' S12_mean'];
fid = fopen(fname1, 'w+');
fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"u"\n"v"\n"w"\n"Div"\n"Q"\n"Lamb2"\n"w_x"\n"w_y"\n"w_z"\n"Sol4"\n"Sol5"\n"Sol6"\n"Sol7"\n"Sol8"\n"Sol9"\n"Sol10"\n"Sol11"\n"Sol12"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
for j=1:length(b)
    fprintf(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n', b(j, :));
end