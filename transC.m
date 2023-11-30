function T = transC(x, y, z, alfa, beta, gamma)
% Calcola la matrice di trasformazione con traslazione + Cardano
% gli angoli dovranno essere in gradi

T = transP(x,y,z)*transZ(gamma)*transY(beta)*transX(alfa);