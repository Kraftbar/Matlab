%% Initialiserer NXT
COM_CloseNXT all                % lukker alle NXT-håndtak 
close all                       % lukker alle figurer  
clear all                       % sletter alle variable 
handle_NXT = COM_OpenNXT();     % etablerer nytt håndtak
COM_SetDefaultNXT(handle_NXT);	% setter globalt standard-håndtak

%% Initialiserer motor B og C
motorA = NXTMotor('A','SmoothStart',true); % initialiserer motor C
motorB = NXTMotor('B','SmoothStart',true); % initialiserer motor B

% åpner akselerometeret
OpenAccelerator(SENSOR_1);
figure
axis([0 90 0 90])
% tellevariabel
i=1;

while 1

a=double(GetAbsoluteIMU_Tilt(SENSOR_1)); % gjør om lesningen til double siden den orgianle lesningen var uint8
a=(a/255)*90  - 45  % convertasjon til grader -45 til 45

    x_deg_ufil(i)=round(a(1)) ; % nedjusterer for å få samme verier som joy
    y_deg_ufil(i)=round(a(2)) ;
     
    
    y_deg(i) = round(filt1(y_deg_ufil,i,5))  % filtrerer
    x_deg(i)=round(filt1(x_deg_ufil,i,5))
    
    foroverA=round(((y_deg(i))+round(x_deg(i)))); % kjører samme som joysick input
    foroverB=round(((y_deg(i))-round(x_deg(i))));
      PowerA = max(-100,min(100,foroverA));
      PowerB = max(-100,min(100,foroverB));
    


    %% beregner motorpådrag og lagrer i vektorer
    

    
    %% set output data
    
      motorA.Power = PowerA;
      motorB.Power = PowerB;
      motorA.SendToNXT(); 
      motorB.SendToNXT(); 
     


     plot(x_deg(i),y_deg(i),'o')
     xlabel('x-akse')
     ylabel('y-akse')
     axis([-45 45 -45 45])

     drawnow
    
    i=i+1;
end
%% stopp motorer
motorC.Stop;
motorB.Stop;
CloseSensor(SENSOR_1);
COM_CloseNXT(handle_NXT);

