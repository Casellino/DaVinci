function q = invkinDaVinci(theta,T,p)
% cinematica inversa di posizione DaVinci
% trasformazioni relative [Ti,i-1]
T10 = transDH(p.alphai(1), p.ai(1), 0       , theta(1)+p.di(1));
T21 = transDH(p.alphai(2), p.ai(2), theta(2), p.di(2));
T32 = transDH(p.alphai(3), p.ai(3), theta(3), p.di(3));
T43 = transDH(p.alphai(4), p.ai(4), theta(4), p.di(4));
T40 = T10*T21*T32*T43;
% posizione del target rispetto alla terna RCM
TRCMw = p.T0w * T40 * transX(p.alphai(5)+90) * transP(0,p.di(5)+p.ai(8),0);
% posizione del target rispetto alla terna RCM
A = TRCMw \ T;
x = A(1,4);
y = A(2,4);
z = A(3,4);
% parametri DH
a6 = p.ai(7);
% a7 = p.ai(8);
a8 = p.ai(9);
% inclinazione del piano di lavoro del braccio rispetto a al piano verticale z4y4
q5 = atan2(-z,x) + 180; % configurazione spalla
q6 = atan2(y,z/sind(q5)) + asind(a8/a6);
q7 = 3 * 180 / 2 - q6;
q8 = atan2(y,z/sind(q5));
q9 = sqrt(a6^2 - a8^2) + sqrt(x^2 + y^2 + z^2) - p.Ltool;
% soluzione (punto robot)
q = [q5 q6 q7 q8 q9];
