%%%% Boundary Layer Profile, from averaging over all [X, Z] points
clear all;
file_In = '\mean.dat';

[X Y Z U V W Div Q Lamb2 w_x w_y w_z Sol4 Sol5 Sol6 Sol7 Sol8 Sol9 Sol10 Sol11 Sol12] = textread(file_In, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'headerlines', 24);
Z0 = 1498.8;
k = 450;

Zloc = [-0.2, 1.8];

figure(1);
ind = 1;

y_range = 420:60:max(Y)-60;

for i = 1:length(y_range);
    idx = find(Y == y_range(i) & X > 120 & X < 2920 & abs(abs((Z-Z0)/k) - Zloc(ind))< 0.5);

    Ui = U(idx);
    idx1 = find(Ui ~= 0);
    Mean_U(i) = mean(Ui(idx1));
    Mean_Y(i) = (y_range(i)-k)/k;
end
plot(Mean_U/0.156, Mean_Y, 'k.-');
hold;
xlim([4, 12]);
ylim([-0.5, 4.5]);
%%%% PLot Jerry's data
% clear all;
[X Y U] = textread('\meanU.dat', '%f %f %f', 'headerlines', 3);
y_range = min(Y):0.0635:max(Y);
for i = 1:length(y_range)
    idx = find(abs(Y - y_range(i))<0.01);
    Mean_U_J(i) = mean(U(idx));
    Mean_Y_J(i) = y_range(i)/0.450;
end
plot(Mean_U_J/0.156, Mean_Y_J, 'ro-');

ylim([-0.1, 4.5]);
xlabel('u (m/s)');
ylabel('y/k');
title(sprintf('|Z/k| = %1.2f', Zloc(ind)));