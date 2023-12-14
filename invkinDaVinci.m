function q = invkinDaVinci(T40,P,p)
% T40: terna 4 rispetto a 0
% P: coordinate punto target rispetto a world
% p: parametri

% terna RCM rispetto a world
TRCMw = p.T0w * T40 * transX(p.alphai(5)+90) * transP(0,p.di(5)+p.ai(8),0);

% coordinate del target rispetto alla terna RCM
A = TRCMw \ P;
x = A(1);
y = A(2);
z = A(3);

% parametri DH
a6 = p.ai(7);
a8 = p.ai(9);

% calcolo delle coordinate di giunto
q5 = atan2(-z,x) + 180; % inclinazione del piano di lavoro del braccio rispetto a al piano verticale z4y4
q6 = atan2(y,z/sind(q5)) + asind(a8/a6);
q7 = 3 * 180 / 2 - q6;
q8 = atan2(y,z/sind(q5));
q9 = sqrt(a6^2 - a8^2) + sqrt(x^2 + y^2 + z^2) - p.Ltool;

% output: coordinate dei giunti attivi
q = [q5 q6 q7 q8 q9];
