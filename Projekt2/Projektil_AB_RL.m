% Angry birds real life

% Gaute Nybø -- 25.10.14

COM_CloseNXT all                % lukker alle NXT-håndtak 
close all                       % lukker alle figurer  
clear all                       % sletter alle variable 
handle_NXT = COM_OpenNXT();     % etablerer nytt håndtak
COM_SetDefaultNXT(handle_NXT);	% setter globalt standard-håndtak

%% Åpne Motorer

motorA = NXTMotor('A','SmoothStart',true); % initialiserer motor B
motorB = NXTMotor('B','SmoothStart',true); % initialiserer motor B
motorC = NXTMotor('C','SmoothStart',true); % initialiserer motor C

%% Måling av dist
V=2 % m/s  Ta film med kamera, og regne ut vel_i
G=9.8%m/s^2
r=0.028 % m
D(1)= 0;

OpenSwitch(SENSOR_2);
while ~GetSwitch(SENSOR_2)
    motorC.Power =40;
    motorB.Power = 40;
    motorC.SendToNXT();
    motorB.SendToNXT();
end
     motorC.Stop;
     motorB.Stop;
    %% kjorer tilbake
    dataC = motorC.ReadFromNXT();
    dataB = motorB.ReadFromNXT();
    motorC.TachoLimit= dataC.Position; %gjore om til funksjon studass
    motorB.TachoLimit= dataB.Position;
    motorC.SmoothStart= true;
    motorB.SmoothStart= true;
    motorC.Power = -motorC.Power;
    motorB.Power = -motorB.Power;
    motorC.SendToNXT();
    motorB.SendToNXT();
    motorC.WaitFor();       %tregner ikke Bwait?
    

     
     %% regner ut dist til prosjektilen
     RadC  = pi*(dataC.Position/180)*r;
     RadB  = pi*(dataB.Position/180)*r;
     D= (RadC+RadB)/2;

    
     
     

%% Åpne akselereometer
OpenAccelerator(SENSOR_1);
i=1;
a=[1;1;1]
vater=0

while vater ~=15
    if (a(2)==0 || a(1)==128)
        vater= vater+1
    end
    motorA.Power = 1;
    motorA.SendToNXT();
    
    
a=GetAbsoluteIMU_Tilt(SENSOR_1);
end

NXT_ResetMotorPosition(MOTOR_A, true);
motorA.TachoLimit= real(round((asind((D*G)/V^2))/2)); % se bilde formel for vinkel  
motorA.SmoothStart= true;
motorA.Power = -motorA.Power;
motorA.SendToNXT();
motorA.WaitFor();






%% Lukker motorer og NXT
motorA.Stop;
motorB.Stop;
motorC.Stop;
CloseSensor(SENSOR_3)
COM_CloseNXT(handle_NXT);