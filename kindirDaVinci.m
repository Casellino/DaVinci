function m = kindirDaVinci(q,p) 
% q: coordinate libere, p: parametri DH
% cinematica diretta DaVinci

% trasformazioni relative [Ti,i-1]
m.T10 = transDH(0,0,0,q(1));
m.T21 = transDH(0,p.ai(1),q(2),p.di(2));
m.T32 = transDH(0,p.a2,q(3),p.di(3));
m.T43 = transDH(0,p.ai(3),q(4),p.di(4));

m.T54 = transDH(-152.63,0,q(5),p.di(5));
m.T65 = transDH(-90,0,q(6),0);
m.T76 = transDH(0,p.ai(6),q(7),0);
m.T87 = transDH(0,p.ai(7),q(8),0);
m.T98 = transDH(90,p.ai(8),0,p.Ltool+q(9));
