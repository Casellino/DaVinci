function m = fwdkinSCARA(q, p)
% In input vettore q e struttura p, in output la struttura m
% Cinematica diretta SCARA 

% Trasformazioni relative [Ti,i-1]
m.T10 = transDH(0, 0, q(1), p.d1);
m.T21 = transDH(0, p.a1, q(2), p.d2);
m.T32 = transDH(180, p.a2, 0, q(3)+p.d30);
m.T43 = transDH(0, 0, q(4), 0);

% Trasformazioni assolute [Tiw]
m.T1w = p.T0w*m.T10;
m.T2w = m.T1w*m.T21;
m.T3w = m.T2w*m.T32;
m.T4w = m.T3w*m.T43;

% Terna Tool rispetto a world
m.Ttw = m.T4w*p.Ttn;

% Punti per linee modello
P1w = m.T1w*p.P1;
P2w = m.T2w*p.P2;
m.Pw = [P1w P2w m.T4w(:,4)];