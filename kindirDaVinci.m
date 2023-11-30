function m = kindirDaVinci(q,p) 
% q: coordinate libere, p: parametri DH
% cinematica diretta DaVinci

% trasformazioni relative [Ti,i-1]
m.T10 = transDH(p.alphai(1), p.ai(1), 0   , q(1)+p.di(1)); 
m.T21 = transDH(p.alphai(2), p.ai(2), q(2), p.di(2));
m.T32 = transDH(p.alphai(3), p.ai(3), q(3), p.di(3));
m.T43 = transDH(p.alphai(4), p.ai(4), q(4), p.di(4));
m.T54 = transDH(p.alphai(5), p.ai(5), q(5), p.di(5));
m.T65 = transDH(p.alphai(6), p.ai(6), q(6), 0);
m.T76 = transDH(p.alphai(7), p.ai(7), q(7), 0);
m.T87 = transDH(p.alphai(8), p.ai(8), q(8), 0);
m.T98 = transDH(p.alphai(9), p.ai(9), 0   , q(9)-p.Ltool+p.di(9));

% trasformazioni assolute [Tiw]
m.T1w = p.T0w*m.T10;
m.T2w = m.T1w*m.T21;
m.T3w = m.T2w*m.T32;
m.T4w = m.T3w*m.T43;
m.T5w = m.T4w*m.T54;
m.T6w = m.T5w*m.T65;
m.T7w = m.T6w*m.T76;
m.T8w = m.T7w*m.T87;
m.T9w = m.T8w*m.T98;

% terna tool rispetto a world
m.Ttw = m.T9w*p.Ttn;

% punti per linee modello
P1w = m.T1w*p.P1;
P2w = m.T2w*p.P2;
P3w = m.T3w*p.P3;
P5w = m.T5w*p.P5;
P7w = m.T7w*p.P7;
P8w = m.T8w*p.P8;
P9w = m.T9w*p.P9;
Ptw = m.Ttw*p.Pt;
% P95 = m.T5w*p.P9;

m.Pw = [P1w P2w P3w P5w P7w P8w P9w Ptw];