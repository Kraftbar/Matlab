%% Akelerasjon. Utregning av fart og distanse ved bruk av akeslerasjon


COM_CloseNXT all                % lukker alle NXT-håndtak 
close all                       % lukker alle figurer  
clear all                       % sletter alle variable 
handle_NXT = COM_OpenNXT();     % etablerer nytt håndtak
COM_SetDefaultNXT(handle_NXT);	% setter globalt standard-håndtak

%% Initialiserer motor B og C
% motorC = NXTMotor('C','SmoothStart',true); % initialiserer motor C
% motorB = NXTMotor('B','SmoothStart',true); % initialiserer motor B

% %% Initialiserer joystick
% joymex2('open',0);                     % åpner joystick
% joystick      = joymex2('query',0);    % spør etter data fra joystick
% JoyMainSwitch = joystick.buttons(1);   % henter verdien fra knapp nr 1 som er stoppknappen 

% Utganger
PowerC     = zeros(1,100);  % lagrer motorpådrag
PowerB     = zeros(1,100);  % lagrer motorpådrag
% Egendefinerte vektorere
JoyForover = zeros(1,100);  % lagrer Fremover bevegelsen til joystick
JoySide    = zeros(1,100);  % lagrer side bevegelsen til joystick


% åpner akselerometeret
OpenAccelerator(SENSOR_1);

%definerer noen vektorer for å samle rå data i
tilt_vector = zeros(3,100);
acc_vector  = zeros(3,100);

%definerer egene vektorer
vel_vector  = zeros(3,100);
dist_vector  = zeros(3,100);
tid_sek     = zeros(1,100)


%% index for lagring i vektorer
i=1;
k=i
tic;
% både akselerasjon, fart og distanse  er 0 ved t_1, Dvs. at vi ikke starter
% prog med roboten i bevegelse

k=k+1

figure (1)
while 1

       
    % Avlesing av akselerasjon:
    acc_vector(:,k) = double(GetAbsoluteIMU_Acc(SENSOR_1))/100;
   
    
    %% Integrerte
    tid_sek(k) = toc;                             % ny tidsverdi    
    Ts = tid_sek(k)-tid_sek(k-1);              %   tidsskritt i sekund
    vel_vector(1:3,k) = vel_vector(1:3,k-1) + acc_vector(1:3,k)*Ts;     % numerisk integrerer velocity
    dist_vector(1:3,k) = dist_vector(1:3,k-1) + vel_vector(1:3,k)*Ts;   % numerisk integrerer distance
    
    
    %% Plotter akelerasjon i x, y plan
    subplot(2,2,1)
    plot(acc_vector(1,i),acc_vector(2,i),'O')
    axis([-10 10 -10 10])
    
    %% Plotter distanse i x, y plan
    subplot(2,2,2)
    plot((dist_vector(1,:)),(dist_vector(2,:)),'O')                            

%     %% Får tak i joystickdata
%     joystick        = joymex2('query',0);       % spør etter data fra joystick
%     JoyMainSwitch   = joystick.buttons(1);
%     JoyForover(i)   = -joystick.axes(2)/327.68; % 32768 fremover, -32768 bakover
%     JoySide(i)      = -joystick.axes(4)/327.68; % 32768 høyre,    -32768 venstre
    
%     % Frem Signal fra joystick + Sidesignal fra joystick = MotorC
%     foroverB=round(((JoyForover(i))+round(JoySide(i)))); %Kraftig nedjustert for å kjøre nøyaktig
%     foroverC=round(((JoyForover(i))-round(JoySide(i)))); %Kraftig nedjustert for å kjøre nøyaktig

%     %% beregner motorpådrag og lagrer i vektorer
%     PowerC(i) = max(-100,min(100,foroverC));
% 	PowerB(i) = max(-100,min(100,foroverB)); 
%     
%     %% set output data
%     motorC.Power = PowerC(i);
%     motorB.Power = PowerB(i);
%     motorC.SendToNXT();
%     motorB.SendToNXT();
    
    k=k+1;
    i=i+1;
end
    
    

    drawnow
%% stopp motorer
motorC.Stop;
motorB.Stop;
CloseSensor(SENSOR_3)
% Clear MEX-file to release joystick
clear joymex2

% Close NXT connection.
COM_CloseNXT(handle_NXT);