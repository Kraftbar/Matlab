%% Initialiserer NXT
COM_CloseNXT all                % lukker alle NXT-håndtak
close all                       % lukker alle figurer
clear all                       % sletter alle variable
handle_NXT = COM_OpenNXT();     % etablerer nytt håndtak
COM_SetDefaultNXT(handle_NXT);  % setter globalt standard-håndtak

%% Opnar trykksensor
OpenSwitch(SENSOR_1);   % Opnar trykksensor
OpenSwitch(SENSOR_2);   % Opnar trykksensor
OpenSwitch(SENSOR_3);   % Opnar trykksensor

%% Signalbehandling
i=1;
a=true;
morse = []; %tvinger den til å sette inn tall istedenfor bokstaver
while a;
    if GetSwitch(SENSOR_1);           % Kort eller langt signal (trykk)
        tic
        while GetSwitch(SENSOR_1);
            NXT_PlayTone(800,50)
        end
        signal(i)=toc;
        
        if signal(i)<0.2
            morse(i)='.'; %kan egentlig byttes ut med askii verdier
        else
            morse(i)='-';
        end
    end
    
    if GetSwitch(SENSOR_2);
        while GetSwitch(SENSOR_2);
            NXT_PlayTone(14000,50)
        end
        morse(i)=' ';
    end
    
    if GetSwitch(SENSOR_3);
        a=false;                % Går ut av while-loopen
    end
    
    if length(morse) ~= i - 1
        char(morse)
        i = i+1;
    end
    
end

morse(i)=32       % så for løkken nedenfor fungerer
k=1
l=1


bokstaver={}
morse=char(morse)
for j=1:length(morse)
    if double(morse(j))==32
        bokstaver(l)={(morse(k:(j-1)))};
        k=j+1
        l=l+1
    end
end


for j=1:length(bokstaver)
    if strcmp(bokstaver(j),' ')
        fprintf(' ')
    elseif strcmp(bokstaver(j),'.-')
        fprintf('A')
    elseif strcmp(bokstaver(j),'-...')
        fprintf('B')
    elseif strcmp(bokstaver(j),'-.-.')
        fprintf('C')
    elseif strcmp(bokstaver(j),'-..')
        fprintf('D')
    elseif strcmp(bokstaver(j),'.')
        fprintf('E')
    elseif strcmp(bokstaver(j),'..-.')
        fprintf('F')
    elseif strcmp(bokstaver(j),'--.')
        fprintf('G')
    elseif strcmp(bokstaver(j),'....')
        fprintf('H')
    elseif strcmp(bokstaver(j),'..')
        fprintf('I')
    elseif strcmp(bokstaver(j),'.---')
        fprintf('J')
    elseif strcmp(bokstaver(j),'-.-')
        fprintf('K')
    elseif strcmp(bokstaver(j),'.-..')
        fprintf('L')
    elseif strcmp(bokstaver(j),'--')
        fprintf('M')
    elseif strcmp(bokstaver(j),'-.')
        fprintf('N')
    elseif strcmp(bokstaver(j),'---')
        fprintf('O')
    elseif strcmp(bokstaver(j),'.--.')
        fprintf('P')
    elseif strcmp(bokstaver(j),'--.-')
        fprintf('Q')
    elseif strcmp(bokstaver(j),'.-.')
        fprintf('R')
    elseif strcmp(bokstaver(j),'...')
        fprintf('S')
    elseif strcmp(bokstaver(j),'-')
        fprintf('T')
    elseif strcmp(bokstaver(j),'..-')
        fprintf('U')
    elseif strcmp(bokstaver(j),'...-')
        fprintf('V')
    elseif strcmp(bokstaver(j),'.--')
        fprintf('X')
    elseif strcmp(bokstaver(j),'-..-')
        fprintf('Y')
    elseif strcmp(bokstaver(j),'-.--')
        fprintf('Z')
    elseif strcmp(bokstaver(j),'.----')
        fprintf('1')
    elseif strcmp(bokstaver(j),'..---')
        fprintf('2')
    elseif strcmp(bokstaver(j),'...--')
        fprintf('3')
    elseif strcmp(bokstaver(j),'....-')
        fprintf('4')
    elseif strcmp(bokstaver(j),'.....')
        fprintf('5')
    elseif strcmp(bokstaver(j),'-....')
        fprintf('6')
    elseif strcmp(bokstaver(j),'--...')
        fprintf('7')
    elseif strcmp(bokstaver(j),'---..')
        fprintf('8')
    elseif strcmp(bokstaver(j),'----.')
        fprintf('9')
    elseif strcmp(bokstaver(j),'-----')
        fprintf('0')
    end
end
fprintf('\n')   
% Morse={'.-','-...','-.-.','-..','.','..-.','--.','....','..','.---',...
%     '-.-','.-..','--','-.','---','.--.','--.-','.-.','...','-','..-',...
%     '...-','.--','.--','-..-','-.--','.----','..---','...--','....-',...
%     '.....','-....','--...','---..','----.','-----'}
% Bokstaver={'A','B','C','D','E','F','G','H','I','J','K','L','M','N,'O','P','Q','R','S','T',...
%     'U','V','W','X','Y','Z,'1','2','3','4','5','6','7','8','9','0'}
%% Lukker trykksensor
CloseSensor(SENSOR_1);  % Lukker trykksensor
CloseSensor(SENSOR_2);  % Lukker trykksensor
CloseSensor(SENSOR_3);  % Lukker trykksensor

%% Close NXT connection.
COM_CloseNXT(handle_NXT); % Lukker håndtak

