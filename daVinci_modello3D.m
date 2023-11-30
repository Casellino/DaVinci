%% EX5: CINEMATICA INVERSA DA VINCI
% Caselli Alessandro
% Castellaro Alessandro
% Miah Saiok
% Tassinato Irene

% OBIETTIVI
% - funzione kindirDaVinci
% - posizionamento braccio (primi 4 giunti)
% - definizione punto target Pw
% - funzione invkinDaVinci
% - disegno robot in posizione
% - movimento robot
% - aggiunta lettino e ridefinizione target

clear, clc, close all
%% Caricamento dati modello

load('DaVinci_mod/DaVinci_mod.mat')

%% Dati robot
% Modello del robot
dati.name = 'DaVinci';

% posizione base robot rispetto a world (disegno)
dati.T0w = transE(0,0,0,0,0,0);
% posizione/orientazione tool rispetto flangia robot
dati.Ttn = transP(0,0,dati.Ltool); % da controllare la posizione del tool rispetto alla flangia nel DaVinci

%% Cinematica Diretta di Posizione
q = [50 0 0 0 0 0 0 0 1000]; % 9 coordinate libere (q1, ..., q8)

% punti per linee modello
% punti 1, 2, 3 descritti rispetto alla terna 1
dati.P1 = [[0;0;-dati.di(1)-q(1);1] [0;0;0;1] [dati.ai(1);0;0;1]]; 
% [[origine della terna 0 vista da 1] [origine terna 1 vista da 1] [estremo asse x terna 1]]

% punti 4,5,6 descritti rispetto alla terna 2
dati.P2 = [[0;0;0;1] [dati.ai(2);0;0;1]];
% [[origine della terna 2 vista da 2] [punto 5 visto da 2]]
% punti 6, 7, 8 descritti rispetto alla terna 3
dati.P3 = [[0;0;0;1] [dati.ai(3);0;0;1] [dati.ai(3);0;dati.di(4);1]];
% [[origine terna 3 vista da 3] [punto 7 visto da 3] [origine terna 4 visto da 3]]
% origine terne 5 e 6
dati.P5 = [0;0;0;1];
% origine terna 7
dati.P7 = [0;0;0;1];
% origine terna 8
dati.P8 = [0;0;0;1];
% origine terna 9
dati.P9 = [0;0;0;1];
% origine terna tool
dati.Pt = [0;0;0;1];

mat = kindirDaVinci(q,dati); % da controllare meglio il valore di dati.di(9) se ci sono errori

%% disegno

% creazione figura
hf = figure(1);
clf
hf.MenuBar = 'none';
hf.Name = sprintf('MODELLO 3D robot %s [%dmm]',dati.name,dati.ai(1)+dati.ai(2));
hf.NumberTitle = 'off';
hf.Color = 'w';

% assi
axis equal
view(30,20)
grid on
rotate3d on
xlabel 'x[mm]'
ylabel 'y[mm]'
zlabel 'z[mm]'

% disegno
hold on

% terne di riferimento
L = 120; %[mm]
disframe(eye(4),2*L,'o') % world
disframe(dati.T0w,L,'s') % base robot
disframe(mat.T1w,L) % terna 1
disframe(mat.T2w,L) % terna 2
disframe(mat.T3w,L) % terna 3
disframe(mat.T4w,L) % terna 4
disframe(mat.T5w,L) % terna 5
disframe(mat.T6w,L) % terna 6
disframe(mat.T7w,L) % terna 7
disframe(mat.T8w,L) % terna 8
disframe(mat.T9w,L) % terna 9
disframe(mat.Ttw,L,'.') % terna tool

% linee modello
line(mat.Pw(1,:),mat.Pw(2,:),mat.Pw(3,:),'linestyle','--','color','b','linewidth',1);

% base robot
Pbw = dati.T0w*base.P;
patch('faces',base.faces,'vertices',Pbw(1:3,:)','facecolor',0.95*[0 1 1],'edgecolor','none','facealpha',0.6);

% link1
P1w = mat.T1w*link(1).P;
patch('faces',link(1).faces,'vertices',P1w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.6);

% link2
P2w = mat.T2w*link(2).P;
patch('faces',link(2).faces,'vertices',P2w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.6);

% link3
P3w = mat.T3w*link(3).P;
patch('faces',link(3).faces,'vertices',P3w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.6);


% link4
P4w = mat.T4w*link(4).P;
patch('faces',link(4).faces,'vertices',P4w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.6);


% link5
P5w = mat.T5w*link(5).P;
patch('faces',link(5).faces,'vertices',P5w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.6);


% link6
P6w = mat.T6w*link(6).P;
patch('faces',link(6).faces,'vertices',P6w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.6);


% link7
P7w = mat.T7w*link(7).P;
patch('faces',link(7).faces,'vertices',P7w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.6);


% link8
P8w = mat.T3w*link(8).P;
patch('faces',link(8).faces,'vertices',P8w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.6);


% link9
P9w = mat.T9w*link(9).P;
patch('faces',link(9).faces,'vertices',P9w(1:3,:)','facecolor',0.5*[1 1 1],'edgecolor','none','facealpha',0.6);

light



%% Posizionamento primi 4 giunti

%% Definizione punto target

%% Cinematica Inversa di Posizione

