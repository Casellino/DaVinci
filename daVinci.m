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
load('roboCouch.mat');
base_couch = base;
dati_couch = dati;
link_couch = link;

load('DaVinci_mod/DaVinci_mod.mat')
%% Dati robot
% Modello del robot
dati.name = 'DaVinci';

% posizione base robot rispetto a world (disegno)
dati.T0w = transE(550,700,0,0,0,-90);
% posizione/orientazione tool rispetto flangia robot
dati.Ttn = transP(0,0,dati.Ltool);

%% Posizionamento braccio (primi 4 giunti)
q = [600 50 -30 250];

% Punti per linee modello
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
% origine terna RCM
dati.PRCM = [0;0;0;1];
% origine terna 7
dati.P7 = [0;0;0;1];
% origine terna 8
dati.P8 = [0;0;0;1];
% origine terna 9
dati.P9 = [0;0;0;1];
% origine terna tool
dati.Pt = [0;0;0;1];

%% Cinematica inversa di posizione
% terna tool nella posizione iniziale
Ttw1 = transE(800,-600,1000,0,0,0);
% terna tool nella posizione finale
Ttw2 = transE(600,-800,300,0,180,180);
theta = q; % corrispondono a q1, q2, q3 e q4 che rappresentano i giunti passivi

q1 = invkinDaVinci(theta,Ttw1,dati);
q2 = invkinDaVinci(theta,Ttw2,dati);

q1 = [theta q1];
q2 = [theta q2];
dq = q2 - q1;

%% pianificazione ai giunti P-P

% dati della legge
T = 1; % [s]
dt = 0.1; % [s]
t = 0:dt:T;
N = length(t);

% legge normalizzata (sigma)
tau = t/T;
sigma = 3*tau.^2 - 2*tau.^3;
sigmap = 6*tau - 6*tau.^2;
sigmapp = 6 - 12*tau;

[tau' sigma' sigmap' sigmapp']

% grafico sigma(tau) e derivate
figure(2)

subplot(3,1,1)
plot(tau,sigma)
grid on
xlabel '\tau []'
ylabel '\sigma []'

subplot(3,1,2)
plot(tau,sigmap)
grid on
xlabel '\tau []'
ylabel '\sigmap []'

subplot(3,1,3)
plot(tau,sigmapp)
grid on
xlabel '\tau []'
ylabel '\sigmapp []'

% leggi qi
Q1 = q1(1) + dq(1)*sigma;
Q2 = q1(2) + dq(2)*sigma;
Q3 = q1(3) + dq(3)*sigma;
Q4 = q1(4) + dq(4)*sigma;
Q5 = q1(5) + dq(5)*sigma;
Q6 = q1(6) + dq(6)*sigma;
Q7 = q1(7) + dq(7)*sigma;
Q8 = q1(8) + dq(8)*sigma;
Q9 = q1(9) + dq(9)*sigma;

Q = [Q1' Q2' Q3' Q4' Q5' Q6' Q7' Q8' Q9'];

Qp = sigmap'*dq/T;
Qpp = sigmapp'*dq/(T^2);

% grafico qi(t) e derivate
figure(3)
clf

subplot(3,1,1)
plot(t,Q(:,5:9))
grid on
xlabel 't [s]'
ylabel 'q_i [°,mm]'
legend({'q_5','q_6','q_7','q_8','q_9'})

subplot(3,1,2)
plot(t,Qp(:,5:9))
grid on
xlabel 't [s]'
ylabel 'qp_i [°/s,mm/s]'

subplot(3,1,3)
plot(t,Qpp(:,5:9))
grid on
xlabel 't [s]'
ylabel 'qpp_i [°/s^2,mm/s^2]'

%% disegno
% creazione figura
hf = figure(1);
clf
hf.MenuBar = 'none';
hf.Name = sprintf('Linee Modello %s [%dmm]',dati.name,dati.ai(1)+dati.ai(2));
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
m = kindirDaVinci(Q(end,:),dati); % terna finale 
%% simulazione

% inizializzazione oggetto video
writerObj = VideoWriter('video DaVinci','MPEG-4');
writerObj.FrameRate = round((N-1)/T); % fps
writerObj.Quality = 100; % qualità percentuale
writerObj.open

hf.Position = [0 0 1850 1000];
hf.OuterPosition = hf.Position;

% figure(hf)
for nf = 1:N
    mi = kindirDaVinci(Q(1,:),dati);    % inizio
    mf = kindirDaVinci(Q(end,:),dati); % fine 
    % calcolo matrici di trasformazione
    q = Q(nf,:);
    mat = kindirDaVinci(q,dati);

    % disegno
    cla
    hold on 
    % terne di riferimento
    L = 100; %[mm]
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
    disframe(mat.TRCMw,L) % terna RCM

    disframe(mi.Ttw,L,'o') % terna iniziale
    disframe(mf.Ttw,L,'o') % terna finale

    % linee modello
    line(mat.Pw(1,:),mat.Pw(2,:),mat.Pw(3,:),'linestyle','--','color','b','linewidth',1);
    line(mat.P5RCM8w(1,:),mat.P5RCM8w(2,:),mat.P5RCM8w(3,:),'linestyle','--','color','b','linewidth',1);
    line(mat.P9tw(1,:),mat.P9tw(2,:),mat.P9tw(3,:),'linestyle','--','color','black','linewidth',1);

    % MODELLO 3D
    % base robot
    Pbw = dati.T0w*base.P;
    patch('faces',base.faces,'vertices',Pbw(1:3,:)','facecolor',0.95*[0 1 1],'edgecolor','none','facealpha',0.6);

    % lettino 
    PLw = dati.T0w*transE(1000,700,600,180,0,0)*link_couch(6).P;
    patch('faces',link_couch(6).faces,'vertices',PLw(1:3,:)','facecolor',0.1*[1 1 1],'edgecolor','none','facealpha',0.6);

    % membri passivi
    % link1
    P1w = mat.T1w*link(1).P;
    patch('faces',link(1).faces,'vertices',P1w(1:3,:)','facecolor',0.5*[1 1 1],'edgecolor','none','facealpha',0.6);
    % link2
    P2w = mat.T2w*link(2).P;
    patch('faces',link(2).faces,'vertices',P2w(1:3,:)','facecolor',0.5*[1 1 1],'edgecolor','none','facealpha',0.6);
    % link3
    P3w = mat.T3w*link(3).P;
    patch('faces',link(3).faces,'vertices',P3w(1:3,:)','facecolor',0.5*[1 1 1],'edgecolor','none','facealpha',0.6);
    % link4
    P4w = mat.T4w*link(4).P;
    patch('faces',link(4).faces,'vertices',P4w(1:3,:)','facecolor',0.5*[1 1 1],'edgecolor','none','facealpha',0.6);

    % membri attivi
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
    P8w = mat.T8w*link(8).P;
    patch('faces',link(8).faces,'vertices',P8w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.6);

    % tool
    P9w = mat.T9w*link(9).P;
    patch('faces',link(9).faces,'vertices',P9w(1:3,:)','facecolor',0.99*[1 1 1],'edgecolor','none','facealpha',0.6);

    light
    drawnow

    % grab immagine fotogramma
    IM = getframe(hf);
    writeVideo(writerObj,IM.cdata);
end

% chiusura/salvataggio video
writerObj.close
% plot3(mat.Ttw(1,4),mat.Ttw(2,4),mat.Ttw(3,4),'o') % TARGET
