function T12 = invT(T21)
% Calcola la matrice di rotazione inversa

% Matrice di rotazione inversa
R12 = T21(1:3,1:3)';
O12 = -R12*T21(1:3,4);

% Matrice di trasformazione
T12 = eye(4);
T12(1:3,1:3) = R12;
T12(1:3,4) = O12;