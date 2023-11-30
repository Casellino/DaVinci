function T = transDH(alfa, a, theta, d)
% Calcola la matrice di trasformazione con DH
% Gli angoli devono essere espressi in gradi

T = transX(alfa)*transP(a,0,0)*transZ(theta)*transP(0,0,d);
