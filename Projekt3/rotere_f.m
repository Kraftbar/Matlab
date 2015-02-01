function [] = rotere(d)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% Initialiserer motor B og C
motorB = NXTMotor('B','SmoothStart',true); % initialiserer motor B
motorC = NXTMotor('C','SmoothStart',true); % initialiserer motor C

%%

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

end

