function T = transY(beta)
% rotazione elemntare su Y
% ATTENZIONE l'angolo beta deve essere in gradi

T = [cosd(beta) 0 sind(beta) 0;
    0 1 0 0;
    -sind(beta) 0 cosd(beta) 0
    0 0 0 1];