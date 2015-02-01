% M�ling distanse, hastighet og vektor
COM_CloseNXT all                % lukker alle NXT-h�ndtak
close all                       % lukker alle figurer
clear all                       % sletter alle variable
handle_NXT = COM_OpenNXT();     % etablerer nytt h�ndtak
COM_SetDefaultNXT(handle_NXT);  % setter globalt standard-h�ndtak

%% Initialiserer motor B og C
motorB = NXTMotor('B','SmoothStart',true); % initialiserer motor B
motorC = NXTMotor('C','SmoothStart',true); % initialiserer motor C

%%
d=90;

neg=sign(d)
motorB.ResetPosition();                 % Resetter motor B
motorC.ResetPosition();                 % Resetter motor C


    motorB.Power = 20*neg
    motorC.Power = -20*neg
    


motorB.SendToNXT();
motorC.SendToNXT();

            dataB = motorB.ReadFromNXT()


    while dataB.Position*neg<d*2.4*neg
            dataB = motorB.ReadFromNXT()

    end

motorB.Stop;
motorC.Stop;
%%

COM_CloseNXT(handle_NXT);
