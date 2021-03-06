%% Initialiserer NXT
COM_CloseNXT all                % lukker alle NXT-h�ndtak
close all                       % lukker alle figurer
clear all                       % sletter alle variable
handle_NXT = COM_OpenNXT();     % etablerer nytt h�ndtak
COM_SetDefaultNXT(handle_NXT);  % setter globalt standard-h�ndtak

%% Opnar trykksensor
OpenSwitch(SENSOR_1);   % Opnar trykksensor
OpenSwitch(SENSOR_2);   % Opnar trykksensor
OpenSwitch(SENSOR_3);   % Opnar trykksensor

Morse={' ','.-','-...','-.-.','-..','.','..-.','--.','....','..','.---',...
    '-.-','.-..','--','-.','---','.--.','--.-','.-.','...','-','..-',...
    '...-','.--','.--','-..-','-.--','.----','..---','...--','....-',...
    '.....','-....','--...','---..','----.','-----'}
Bokstaver={' ','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U'...
    'V','W','X','Y','Z','1','2','3','4','5','6','7','8','9','0'}
Askii=[32,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,...
   88,89,90,49,50,51,52,53,54,55,56,57,48]


inputmap=containers.Map(Askii,Morse)
prompt= 'huurebukk'
result = input(prompt,'s')
a=double(result)



for j=1:length(a)
    if a(j)==32
        pause(1)
    end
    morsebokstav=inputmap(a(j)) % putter ut hver bokstav, s�nn at vi kan jobbe med den
    for j=1:length(morsebokstav)
        if morsebokstav(j) == '.'
            NXT_PlayTone(800,100) % 100 MS
            
        else
            NXT_PlayTone(800,300) % 300 MS
        end
        pause(0.2)                % 200 MS
    end
end
            
            


values(inputmap,mat2cell(a,1,ones(1,size(a,2))))    %mat2cell l�nt fra http://www.mathworks.com/matlabcentral/newsreader/view_thread/156758




%% Lukker trykksensor
CloseSensor(SENSOR_1);  % Lukker trykksensor
CloseSensor(SENSOR_2);  % Lukker trykksensor
CloseSensor(SENSOR_3);  % Lukker trykksensor

%% Close NXT connection.
COM_CloseNXT(handle_NXT); % Lukker h�ndtak

