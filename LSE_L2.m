%%% LSE wy swirl
clear all;
clc;
lamb_val = -2;
direc = '\vector_fields_2\';

frame_st = [];
%% Specify LSE point
X_center = 2160; 
ZC = [];
YC = [];
%%%%
N = 60384;

fname1 = '\mean.dat';
[X_M Y_M Z_M U_M V_M W_M Div_M Q_M Lamb2_M wx_M wy_M wz_M Sol4_M Sol5_M Sol6_M Sol7_M Sol8_M Sol9_M Sol10_M Sol11_M Sol12_M] = textread(fname1, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);

for i = 1:length(ZC)
    for j = 1:length(YC)
        tic;
        U_LSE(1:N) = 0;
        V_LSE(1:N) = 0;
        W_LSE(1:N) = 0;
        wx_LSE(1:N) = 0;
        wy_LSE(1:N) = 0;
        wz_LSE(1:N) = 0;
        Lamb2_LSE(1:N) = 0;
        L2_LSE(1:N) = 0;
        Sol4_LSE(1:N) = 0;
        Sol5_LSE(1:N) = 0;
        Sol6_LSE(1:N) = 0;
        Sol7_LSE(1:N) = 0;
        Sol8_LSE(1:N) = 0;
        Sol9_LSE(1:N) = 0;
        Sol10_LSE(1:N) = 0;
        Sol11_LSE(1:N) = 0;
        Sol12_LSE(1:N) = 0;
        
        U_LSE = U_LSE';
        V_LSE = V_LSE';
        W_LSE = W_LSE';
        wx_LSE = wx_LSE';
        wy_LSE = wy_LSE';
        wz_LSE = wz_LSE';
        Lamb2_LSE = Lamb2_LSE';
        L2_LSE = L2_LSE';
        Sol4_LSE = Sol4_LSE';
        Sol5_LSE = Sol5_LSE';
        Sol6_LSE = Sol6_LSE';
        Sol7_LSE = Sol7_LSE';
        Sol8_LSE = Sol8_LSE';
        Sol9_LSE = Sol9_LSE';
        Sol10_LSE = Sol10_LSE';
        Sol11_LSE = Sol11_LSE';
        Sol12_LSE = Sol12_LSE';
        
        Z_center = ZC(i);
        Y_center = YC(j);
        fout = ['\', sprintf('LSE_L2_Z_%04d_Y_%04d.dat', Z_center, Y_center)];
        Count = 0;
        for k = 1:length(frame_st)
            pair = [frame_st(k), frame_st(k) + 1];
            str = [direc, sprintf('rec_%03d-%03d',  pair(1), pair(2)), '\'];
            fname = [str, sprintf('grid_StructField_%03d-%03d_A0.dat', pair(1), pair(2))];
            [X Y Z U V W Div Q Lamb2 w_x w_y w_z Sol4 Sol5 Sol6 Sol7 Sol8 Sol9 Sol10 Sol11 Sol12] = textread(fname, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);
            y_range = 300:60:max(Y)-60;
         
%             id1 = find(X==X_center+60 & Z==Z_center & Y==Y_center);
%             id2 = find(X==X_center-60 & Z==Z_center & Y==Y_center);
%             id3 = find(X==X_center & Z==Z_center+60 & Y==Y_center);
%             id4 = find(X==X_center & Z==Z_center-60 & Y==Y_center);
%             id5 = find(X==X_center & Z==Z_center & Y==Y_center+60);
%             id6 = find(X==X_center & Z==Z_center & Y==Y_center-60);
%             du_dx = 10^3*(U(id1)-U(id2))/120;
%             du_dz = 10^3*(U(id3)-U(id4))/120;
%             du_dy = 10^3*(U(id5)-U(id6))/120;
%             dv_dx = 10^3*(V(id1)-V(id2))/120;
%             dv_dz = 10^3*(V(id3)-V(id4))/120;
%             dv_dy = 10^3*(V(id5)-V(id6))/120;
%             dw_dx = 10^3*(W(id1)-W(id2))/120;
%             dw_dz = 10^3*(W(id3)-W(id4))/120;
%             dw_dy = 10^3*(W(id5)-W(id6))/120;
%             Matrix_grad = [du_dx dv_dx dw_dx; du_dy dv_dy dw_dy; du_dz dv_dz dw_dz];
%             Lamb_2_temp = imag(eig(Matrix_grad));
%             S_grad = Matrix_grad + Matrix_grad';
%             R_grad = Matrix_grad - Matrix_grad';
%             L2_grad = median(eig(S_grad*S_grad + R_grad*R_grad));
%             Lamb_2 = -L2_grad;
%             Lamb_2 = mean(Lamb2(id));

            id = find(X==X_center & Y==Y_center & Z==Z_center & w_y<0);
        
            Lamb_2 = -Lamb2(id);
            
            id1 = find((abs(U_M)+abs(V_M)+abs(W_M)>0) & (abs(U)+abs(V)+abs(W)>0) & X_M<2900 & X_M>=300 & Z_M>=340 & Z_M<=2000 & Y>420 & Y<2200);
            Count = Count+1;
            U_LSE(id1) = U_LSE(id1) + abs(Lamb_2)*(U(id1)-U_M(id1));
            V_LSE(id1) = V_LSE(id1) + abs(Lamb_2)*(V(id1)-V_M(id1));
            W_LSE(id1) = W_LSE(id1) + abs(Lamb_2)*(W(id1)-W_M(id1));
            Lamb2_LSE(id1) = Lamb2_LSE(id1) + abs(Lamb_2)*(Lamb2(id1)-Lamb2_M(id1));
            wx_LSE(id1) = wx_LSE(id1) + abs(Lamb_2)*(w_x(id1)-wx_M(id1));
            wy_LSE(id1) = wy_LSE(id1) + abs(Lamb_2)*(w_y(id1)-wy_M(id1));
            wz_LSE(id1) = wz_LSE(id1) + abs(Lamb_2)*(w_z(id1)-wz_M(id1));
            Sol4_LSE(id1) = Sol4_LSE(id1) + abs(Lamb_2)*(Sol4(id1)-Sol4_M(id1));
            Sol5_LSE(id1) = Sol5_LSE(id1) + abs(Lamb_2)*(Sol5(id1)-Sol5_M(id1));
            Sol6_LSE(id1) = Sol6_LSE(id1) + abs(Lamb_2)*(Sol6(id1)-Sol6_M(id1));
            Sol7_LSE(id1) = Sol7_LSE(id1) + abs(Lamb_2)*(Sol7(id1)-Sol7_M(id1));
            Sol8_LSE(id1) = Sol8_LSE(id1) + abs(Lamb_2)*(Sol8(id1)-Sol8_M(id1));
            Sol9_LSE(id1) = Sol9_LSE(id1) + abs(Lamb_2)*(Sol9(id1)-Sol9_M(id1));
            Sol10_LSE(id1) = Sol10_LSE(id1) + abs(Lamb_2)*(Sol10(id1)-Sol10_M(id1));
            Sol11_LSE(id1) = Sol11_LSE(id1) + abs(Lamb_2)*(Sol11(id1)-Sol11_M(id1));
            Sol12_LSE(id1) = Sol12_LSE(id1) + abs(Lamb_2)*(Sol12(id1)-Sol12_M(id1));
            
        end
        
        U_LSE = U_LSE/Count;
        V_LSE = V_LSE/Count;
        W_LSE = W_LSE/Count;
        wx_LSE = wx_LSE/Count;
        wy_LSE = wy_LSE/Count;
        wz_LSE = wz_LSE/Count;
        Lamb2_LSE = Lamb2_LSE/Count;
        Sol4_LSE = Sol4_LSE/Count;
        Sol5_LSE = Sol5_LSE/Count;
        Sol6_LSE = Sol6_LSE/Count;
        Sol7_LSE = Sol7_LSE/Count;
        Sol8_LSE = Sol8_LSE/Count;
        Sol9_LSE = Sol9_LSE/Count;
        Sol10_LSE = Sol10_LSE/Count;
        Sol11_LSE = Sol11_LSE/Count;
        Sol12_LSE = Sol12_LSE/Count;
        
        for k = 1:length(Sol4_LSE)
            V_tensor = [Sol4_LSE(k) Sol5_LSE(k) Sol6_LSE(k); Sol7_LSE(k) Sol8_LSE(k) Sol9_LSE(k); Sol10_LSE(k) Sol11_LSE(k) Sol12_LSE(k)];
            S_tensor = V_tensor + V_tensor';
            R_tensor = V_tensor - V_tensor';
            L2_LSE(k) = median(eig(S_tensor*S_tensor + R_tensor*R_tensor));
        end
        
        fid = fopen(fout, 'w+');
        fprintf(fid, 'TITLE = "INITIAL"\nVARIABLES = "x"\n"y"\n"z"\n"u"\n"v"\n"w"\n"Lamb2"\n"L2"\n"w_x"\n"w_y"\n"w_z"\nZONE T="zeros"\nI=51, J=32, K=37, F=POINT\n');
        for k=1:length(X)
            fprintf(fid, '%f %f %f %f %f %f %f %f %f %f %f\n', X(k), Y(k), Z(k), U_LSE(k), V_LSE(k), W_LSE(k), Lamb2_LSE(k), L2_LSE(k), wx_LSE(k), wy_LSE(k), wz_LSE(k));
        end
        fclose(fid);
        clear U_LSE V_LSE W_LSE L2_LSE wx_LSE wy_LSE wz_LSE Lamb2_LSE Sol4_LSE Sol5_LSE Sol6_LSE Sol7_LSE Sol8_LSE Sol9_LSE Sol10_LSE Sol11_LSE Sol12_LSE; 
        toc;
    end
end
figure(1);