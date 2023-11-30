function T = transZ(gamma)
% rotazione elemntare su Z
% ATTENZIONE l'angolo gamma deve essere in gradi

T = [cosd(gamma) -sind(gamma) 0 0;
    sind(gamma) cosd(gamma) 0 0;
    0 0 1 0
    0 0 0 1];