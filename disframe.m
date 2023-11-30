function disframe(T,L,m)
% Disegna una terna definita da T rispetto il sistema 0

% Punti estremi dei segmenti da disegnare
Pw = T*[[0; 0; 0; 1] [L; 0; 0; 1] [0; L; 0; 1] [0; 0; L; 1]];

% Marker assi (se non fornito in ingresso, mette a 'none')
if nargin<3
    m = 'none';
end


% Linea asse x
line(Pw(1,[1 2]), Pw(2,[1 2]), Pw(3,[1 2]), 'color', 'r', 'linewidth', 2, 'marker', m);

% Linea asse y
line(Pw(1,[1 3]), Pw(2,[1 3]), Pw(3,[1 3]), 'color', 'g', 'linewidth', 2, 'marker', m);

% Linea asse z
line(Pw(1,[1 4]), Pw(2,[1 4]), Pw(3,[1 4]), 'color', 'b', 'linewidth', 2, 'marker', m);
