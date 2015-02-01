%% Akelerasjon. Utregning av fart og distanse ved bruk av akeslerasjon

%% kommentar til projekteringen
% Prøvde  å bruke akelerometeret sine 2 forskjellige inputs til å få bedre
% verdier for først og fremst x og y aksen. Ideelt sett skulle
% akselerasjonsvektoren være 9.8 konstant i z retning. Dette trodde vi
% først var mulig på grunn av de to forskjellige innputsene akkselerometert
% ga oss.
% Først jobbet vi med å tyde hva de forskjellige vikel outputsene ,
% ga oss. Da la vi merke til at vinkelene ikke var statiske når den lå 
% akelerometeret lå vannrett på pulten. Bilde13 - hvordan vi målte det
% 
% Det er grunnen til at vi skrinla dette var at vi skulle bruke
% projeksjonene når bilen kjørte, dvs. at akkselerometert trengte å regne
% riktige vinkler når den var i bevegelse, noe som vi skjønnte at den ikke
% gjorde
% 
% Vi tror feilen oppstår på grunn av måten akkelerometert er bygget opp

COMCloseNXT all
clear all
close all

handle = COM_OpenNXT();
COM_SetDefaultNXT(handle);

% åpner akselerometeret
OpenAccelerator(SENSOR_1);

%definerer noen vektorer for å samle rå data i
tilt_vector = zeros(3,100);
acc_vector  = zeros(3,100);

%definerer egene vektorer
vel_vector  = zeros(2,100);
dis_vector  = zeros(2,100);


%% index for lagring i vektorer
i=1;
k=i
r=0.028 % cm
k=k+1



figure
set(gcf,'Position',[20 400 900 200])

tic;
while true
    % Avlesing av tilt:
    tilt_vector(:,i) = GetAbsoluteIMU_Tilt(SENSOR_1);
       
    % Avlesing av akselerasjon:
    acc_vector(:,i) = GetAbsoluteIMU_Acc(SENSOR_1);
    
    
    %[(tilt_vector(1:3,i)/255)*180-90, acc_vector(1:3,i)/100]    % plotting av tilt
    
    A(k) = A(k-1) + avvik(k)*Ts(k);     % numerisk integrerer

    

%     subplot(3,2,1)
%     plot(tilt_vector(1,end-90:end))
%     title('Tilt x')
%     axis([-Inf Inf -5 260])
%     subplot(3,2,3)
%     plot(tilt_vector(2,end-90:end))
%     title('Tilt y')
%     axis([-Inf Inf -5 260])
%     subplot(3,2,5)
%     plot(tilt_vector(3,end-90:end))
%     title('Tilt z')
%     axis([-Inf Inf -5 260])
% 
%     % plotting av akselerasjon
%     subplot(3,2,2)
%     plot(acc_vector(1,end-90:end))
%     title('Akselerasjon x')
%     axis([-Inf Inf -1500 1500])
%     subplot(3,2,4)
%     plot(acc_vector(2,end-90:end))
%     title('Akselerasjon y')
%     axis([-Inf Inf -1500 1500])
%     subplot(3,2,6)
%     plot(acc_vector(3,end-90:end))
%     title('Akselerasjon z')
%     axis([-Inf Inf -1500 1500])

    drawnow
    i=i+1;
end
CloseSensor(SENSOR_1);

COM_CloseNXT(handle);

