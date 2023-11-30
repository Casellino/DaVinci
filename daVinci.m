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
% Parametri DH
% a1 = dati.ai(2);
% a2 = dati.ai(3);
% a3 = dati.ai(4);
% d2 = dati.di(2);
% d3 = dati.di(3);
% d4 = dati.di(4);
% alfa4 = dati.alphai(5);
% alfa5 = dati.alphai(6);
% a6 = dati.ai(5);
% a7 = dati.ai(6);
% a8 = dati.ai(7);
% alfa8 = dati.alphai(9);

% posizione base robot rispetto a world (disegno)
dati.T0w = transE(0,0,200,0,0,-20);
% posizione/orientazione tool rispetto flangia robot
dati.Ttn = transP(0,0,100); % da controllare la posizione del tool rispetto alla flangia nel DaVinci

% punti per linee modello
% [[origine della terna 0 vista da 1] [terna 1 vista da 1] [estremo asse x terna 1]]
dati.P1 = [[0;0;-dati.di(1);1] [0;0;0;1] [dati.ai(1);0;0;1]]; 
dati.P2 = [[0;0;-dati.di(2);1] [0;0;0;1] [dati.ai(2);0;0;1]];
dati.P3 = [[0;0;-dati.di(3);1] [0;0;0;1] [dati.ai(3);0;0;1]];
dati.P4 = [[0;0;-dati.di(4);1] [0;0;0;1] [dati.ai(4);0;0;1]];
dati.P5 = [[0;0;-dati.di(5);1] [0;0;0;1] [dati.ai(5);0;0;1]];
dati.P6 = [[0;0;-dati.di(6);1] [0;0;0;1] [dati.ai(6);0;0;1]];
dati.P7 = [[0;0;-dati.di(7);1] [0;0;0;1] [dati.ai(7);0;0;1]];
dati.P8 = [[0;0;-dati.di(8);1] [0;0;0;1] [dati.ai(8);0;0;1]];
dati.P9 = [[0;0;0;1] [dati.ai(9);0;0;1]];





%% Cinematica Diretta di Posizione
q = [0 0 0 0 0 0 0 0 0]; % 9 coordinate libere (q1, ..., q8)

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

