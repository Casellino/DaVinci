function q = invkinDaVinci(T,p,lefty)
% cinematica inversa di posizione DaVinci

% matrice A
% A = inv(p.T0w)*T*inv(p.Ttn)
% A = p.T0w\T/p.Ttn
A = invT(p.T0w)*T*invT(p.Ttn);

% posizione del target rispetto alla terna RCM
TRCMw = p.T0w * A * transX(p.alphai(4)+90) * transP(0,0,p.di(5)+p.ai(7));

% origine terna 4 nel sistema 0
x = A(1,4);
y = A(2,4);
z = A(3,4);

% parametri DH
a1 = p.a1;
a2 = p.a2;

% traslazione asse 3
q3 = p.d1 + p.d2 - z - p.d30;

% angolo del gomito
q2 = ((-1)^lefty)*acosd((x^2+y^2-a1^2-a2^2)/(2*a1*a2));

% angolo della spalla
beta = acosd((a1+a2*cosd(q2))/sqrt(x^2+y^2));
% q1 = atan2d(y,x) + ((-1)^(lefty+1))*beta;
q1 = atan2d(y,x) - ((-1)^lefty)*beta;

q4 = q1 + q2 - atan2d(A(2,1),A(1,1));

% soluzione (punto robot)
q = [q1 q2 q3 q4];



