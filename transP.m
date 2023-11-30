function T = transP(dx, dy, dz)
% Matrice di pura traslazione

T = eye(4);
T(1,4) = dx;
T(2,4) = dy;
T(3,4) = dz;