clear all
for i = 1:8
    fname = sprintf('\\face%d.dat', i);
    fout = sprintf('\\face_new_%d.dat', i);
    [X Y Z T] = textread(fname, '%f %f %f %f', 'headerlines', 7);
    X1 = 3300 - X;
    Y1 = Z;
    Z1 = Y;
    fid = fopen(fout, 'w+');
    fprintf(fid, 'TITLE = "face 1"\nVARIABLES = "x"\n"y"\n"z"\n"T"\nZONE T="zeros"\nI=207,J=207, F=POINT\n');
    for k = 1:length(X1)
        fprintf(fid, '%f   %f   %f   %f \n', X1(k), Y1(k), Z1(k), T(k));
    end
    fclose(fid);
end