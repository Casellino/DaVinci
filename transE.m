function T = transE(x, y, z, alfa, beta, gamma)
% Calcola la matrice di trasformazione con traslazione + Eulero
% gli angoli dovranno essere in gradi

T = transP(x,y,z)*transZ(alfa)*transY(beta)*transZ(gamma);