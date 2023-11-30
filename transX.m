function T = transX(alfa)
% rotazione elemntare su X
% ATTENZIONE l'angolo alfa deve essere in gradi

T = [1 0 0 0;
    0 cosd(alfa) -sind(alfa) 0;
    0 sind(alfa) cosd(alfa) 0
    0 0 0 1];