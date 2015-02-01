%% Initialiserer NXT
COM_CloseNXT all                % lukker alle NXT-håndtak
close all                       % lukker alle figurer
clear all                       % sletter alle variable
handle_NXT = COM_OpenNXT();     % etablerer nytt håndtak
COM_SetDefaultNXT(handle_NXT);  % setter globalt standard-håndtak


Morse={' ','.-','-...','-.-.','-..','.','..-.','--.','....','..','.---',...
    '-.-','.-..','--','-.','---','.--.','--.-','.-.','...','-','..-',...
    '...-','.--','.--','-..-','-.--','.----','..---','...--','....-',...
    '.....','-....','--...','---..','----.','-----'};
Bokstaver={' ','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U'...
    'V','W','X','Y','Z','1','2','3','4','5','6','7','8','9','0'};
Askii=[32,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,...
   88,89,90,49,50,51,52,53,54,55,56,57,48];


inputmap=containers.Map(Askii,Morse);
prompt= 'Melding: ';
bruker = input(prompt,'s');
a=double(bruker);

% 
% MELLOM = 1.5
% LITEN= 0.2
% LANG= 0.4
% PAUSE=0.7

for i=1:length(a)
    if a(i)==32
        pause(1.5)
    else
    morsebokstav=inputmap(a(i)); % putter ut hver bokstav
        for j=1:length(morsebokstav)        % prikkene og bindestrekene
            if morsebokstav(j) == '.'
                NXT_PlayTone(800,200) % 100 mS
                pause(0.7)
            else
                NXT_PlayTone(800,400) % 300 mS
                pause(0.9)
            end
        end
    pause(0.7)% pause for slutt av bokstav
    end
end
            
            


Morsebokstaver=values(inputmap,mat2cell(a,1,ones(1,size(a,2))))    %mat2cell lånt fra http://www.mathworks.com/matlabcentral/newsreader/view_thread/156758

% mat2cell(a,1,ones(1,size(a,2))), denne er lånt. Siden datatyper er alt
% for vanskelig å sette seg inn i.



%% Close NXT connection.
COM_CloseNXT(handle_NXT); % Lukker håndtak

