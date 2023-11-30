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
% Parametri DH
a1 = dati.ai(2);
a2 = dati.ai(3);
a3 = dati.ai(4);
d2 = dati.di(2);
d3 = dati.di(3);
d4 = dati.di(4);
alfa4 = dati.alphai(5);
alfa5 = dati.alphai(6);
a6 = dati.ai(5);
a7 = dati.ai(6);
a8 = dati.ai(7);
alfa8 = dati.alphai(9);

%% Cinematica Diretta di Posizione
q = [0 0 0 0 0 0 0 0 0]; % 9 coordinate libere (q1, ..., q8)


%% Posizionamento primi 4 giunti

%% Definizione punto target

%% Cinematica Inversa di Posizione



% Codice per fare disegno e video dello SCARA - da modificare
% %% Disegno
% % Inizializzazione figura
% hf = figure(1);
% clf % clear figure
% hf.MenuBar = 'none';
% hf.Name = sprintf('simulazione 3D ROBOT %s [%dmm]', params.name, params.a1+params.a2);
% hf.NumberTitle = 'off';
% hf.Color = 'w';
% % hf.Position = [100, 100, 1920, 1080]
% 
% % assi
% axis equal
% view(30,20)
% grid on
% rotate3d on
% xlabel 'x[mm]'
% ylabel 'y[mm]'
% zlabel 'z[mm]'
% xlim(1000*[-0.2 0.8])
% ylim(1000*[-0.2 0.8])
% zlim(1000*[-0.2 1])
% 
% %% Simulazione
% % Inizializzazione oggetto video
% writerObj = VideoWriter('videoSCARA', 'MPEG-4'); % se apro vedo tutti i
% % parametri che posso modificare (es. il path, frame rate, ecc)
% writerObj.FrameRate = round((N-1)/T); % fotogrammi al secondo
% writerObj.Quality = 100; % [%]
% writerObj.open % apertura dell'oggetto video per inserire i fotogrammi
% 
% % figure(hf) % richiamo la figura per sicurezza (?) -> non necessario
% % perché poi utilizziamo "getframe(hf)"
% for nf = 1:N % nf, numero frame -> righe matrici Q, Qp, Qpp
%     % Calcolo matrici di trasformazione
%     q = Q(nf,:);
%     mat = fwdkinSCARA(q, params);
% 
%     % Disegno nf
%     cla % cancella ciò che è stato disegnato ma mantieni la figura creata fuori il ciclo
%     hold on
% 
%     % Lunghezza terne
%     L = 70; %[mm]
%     % terne di riferimento
%     disframe(eye(4), 2*L, 'o') % world
%     disframe(params.T0w, L, 's') % base robot
%     disframe(mat.T1w, L) % terna 1
%     disframe(mat.T2w, L) % terna 2
%     disframe(mat.T3w, L) % terna 3
%     disframe(mat.T4w, L) % terna 4
%     disframe(Ttw1, L, '*') % terna iniziale
%     disframe(Ttw2, L, 'x') % terna finale
% 
%     % linee modello
%     line(mat.Pw(1,:),mat.Pw(2,:),mat.Pw(3,:),'linestyle','--','color','b','linewidth',1)
% 
%     % base robot
%     Pbw = params.T0w*base.P;
%     hp0 = patch('faces',base.faces,'vertices',Pbw(1:3,:)','facecolor',0.95*[0 1 1],'edgecolor','none','facealpha',0.75);
% 
%     % link1
%     P1w = mat.T1w*link(1).P;
%     hp1 = patch('faces',link(1).faces,'vertices',P1w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.75);
% 
%     % link2
%     P2w = mat.T2w*link(2).P;
%     hp2 = patch('faces',link(2).faces,'vertices',P2w(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.75);
% 
%     % link3
%     P3w = mat.T3w*link(3).P;
%     hp3 = patch('faces',link(3).faces,'vertices',P3w(1:3,:)','facecolor',0.5*[1 1 1],'edgecolor','none','facealpha',0.75);
% 
%     light
%     drawnow
% 
%     % grab fotogramma
%     IM = getframe(hf);
%     writeVideo(writerObj,IM.cdata); % cdata matrice 3D (immagine a colori)
% 
% end
% 
% % Chiusura video e salvataggio
% writerObj.close


