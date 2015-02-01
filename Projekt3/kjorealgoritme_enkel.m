% M�ling distanse, hastighet og vektor
COM_CloseNXT all                % lukker alle NXT-h�ndtak
close all                       % lukker alle figurer
clear all                       % sletter alle variable
handle_NXT = COM_OpenNXT();     % etablerer nytt h�ndtak
COM_SetDefaultNXT(handle_NXT);  % setter globalt standard-h�ndtak

%% Initialiserer motor B og C
motorA = NXTMotor('A','SmoothStart',true); % initialiserer motor A
motorB = NXTMotor('B','SmoothStart',true); % initialiserer motor B
motorC = NXTMotor('C','SmoothStart',true); % initialiserer motor C

%% Initialiserer sensorer
OpenUltrasonic(SENSOR_4,'ACTIVE')      % �pner Ultralyd-sensor


%%
d=90;   %distansen man vil m�le og svinge
motorA.TachoLimit = 90-d    % setter motoren i riktig vinkel f�r starter l�kken
motorA.Power = 10;
motorA.SendToNXT();
motorA.WaitFor();



tic;   % Starter tid
motorA.ResetPosition();                 % Resetter motor B
motorB.ResetPosition();                 % Resetter motor B
motorC.ResetPosition();                 % Resetter motor C
%% Kj�rel�kke, styrt av Button2 p� Joystick
while 1
    
    
    %% set output data
    motorB.Power = 10 +0
    motorC.Power = 10 +0
    motorB.TachoLimit = 0;
    motorC.TachoLimit = 0;
    %% Sender data til NXT
    
    motorB.SendToNXT();
    motorC.SendToNXT();
    
    while toc>3
        motorB.Stop;
        motorC.Stop;
        
        
        i=1;
        for j=0:2
            motorA.TachoLimit = d;           %roterer ikke p� f�rste m�ling
            motorA.Power = 20*j;                % Hastighet rotering
            motorA.SendToNXT();
            motorA.WaitFor();                   % Venter til motor har stoppet
            motorA.Stop;                        % f�r posisjon hentes fra motor
            avstand(i) = GetUltrasonic(SENSOR_4) % Henter avstand mellom 1-255
            dataA = motorA.ReadFromNXT();
            i=1+i;
        end
        dataA = motorA.ReadFromNXT();
        motorA.TachoLimit = dataA.Position;             % 10 Grader mellom hver m�ling
        motorA.Power = -motorA.Power;
        motorA.SendToNXT();
        motorA.WaitFor();
        
        motorA.Stop;
        
        hvilken_vei = find(avstand==(max(max(avstand))))   % finner indexen til h�yeste verdi
        
        switch hvilken_vei
            case 1  % h�yre
                
                d=-d; % siden det er venstre
                
                neg=sign(d)
                motorB.ResetPosition();                 % Resetter motor B
                motorC.ResetPosition();                 % Resetter motor C
                
                
                motorB.Power = 20*neg
                motorC.Power = -20*neg
                
                motorB.SendToNXT();
                motorC.SendToNXT();
                
                dataC = motorC.ReadFromNXT()
                
                
                while dataC.Position<d*2.5*neg
                    dataC = motorC.ReadFromNXT()
                end
                d=90
                motorB.Stop;
                motorC.Stop;
                
            case 2               
                disp('fortsett � kj�r')
                
            case 3                % venstre
                
                neg=sign(d)
                motorB.ResetPosition();                 % Resetter motor B
                motorC.ResetPosition();                 % Resetter motor C
                
                motorB.Power = 20*neg
                motorC.Power = -20*neg
                
                motorB.SendToNXT();
                motorC.SendToNXT();
                
                dataB = motorB.ReadFromNXT()
                
                
                while dataB.Position<d*2.5
                    dataB = motorB.ReadFromNXT()
                end
                
                motorB.Stop;
                motorC.Stop;
                
                
        end
        tic
        motorC.Stop;
        motorB.Stop;
        
    end
    
end
%% stopp motorer og sensorer
motorA.Stop;
motorB.Stop;
motorC.Stop;
CloseSensor(SENSOR_4)

% Close NXT connection.
COM_CloseNXT(handle_NXT);
