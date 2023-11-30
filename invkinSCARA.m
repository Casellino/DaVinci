function q = invkinSCARA(T, p, lefty)
% Cineamtica inversa di posizione SCARA

% Calcolo della Matrice A
% A = inv(p.T0w)*T*inv(p.Ttn) % matrice T40
% A = p.T0w\T/p.Ttn % alternativa più veloce e accurata della precedente,
% matlab risolve un sistema lineare invece che operare l'inversa
A = invT(p.T0w)*T*invT(p.Ttn);

% Origine terna 4 nel sistema 0
x = A(1,4);
y = A(2,4);
z = A(3,4);

% Parametri DH
a1 = p.a1;
a2 = p.a2;

% Traslazione asse 3
q3 = p.d1 + p.d2 - z - p.d30; % devo sottrarre l'offset in questo caso

% Angolo del gomito
q2 = ((-1)^lefty)*(acosd((x^2 + y^2 - a1^2 - a2^2)/(2*a1*a2)));

% Angolo della spalla
beta = acosd((a1 + a2*cosd(q2))/sqrt(x^2 + y^2));
q1 = atan2d(y,x) + ((-1)^(lefty + 1))*beta; % oppure - (-1)^lefty

% Angolo
q4 = q1 + q2 - atan2d(A(2,1), A(1,1));

% Soluzione (punto robot - vettore)
q = [q1 q2 q3 q4];



