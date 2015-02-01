%% Initialiserer NXT
COM_CloseNXT all                % lukker alle NXT-håndtak
close all                       % lukker alle figurer
clear all                       % sletter alle variable
handle_NXT = COM_OpenNXT();     % etablerer nytt håndtak
COM_SetDefaultNXT(handle_NXT);  % setter globalt standard-håndtak

Morse={' ','.-','-...','-.-.','-..','.','..-.','--.','....','..','.---',...
    '-.-','.-..','--','-.','---','.--.','--.-','.-.','...','-','..-',...
    '...-','.--','.--','-..-','-.--','.----','..---','...--','....-',...
    '.....','-....','--...','---..','----.','-----'}
Askii=[32,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,...
   88,89,90,49,50,51,52,53,54,55,56,57,48]

outputmap=containers.Map(Morse,Askii)
  

OpenSound(SENSOR_1, 'DB');

tic;
i=1
    %% Måler hvor lange lydene er, og skiller de

while toc<6
    if GetSound(SENSOR_1)>400
        toc;
        if toc>1    % sjekker om det er mellomrom
            lyd(i)=toc
            i=i+1
        end
        tic;
        
        while GetSound(SENSOR_1)>400    % snurrer helt til den ikke har lyd
        end
    lyd(i)= toc
    i=i+1;
    tic;
    end
end


%% Tolket i morsesignaler
i=0
for j=1:length(lyd)
    if lyd(j)<0.45
        tolket(j+i)='.'
    elseif lyd(j)<0.9
        tolket(j+i)='-'
    elseif lyd(j) <1.40
        tolket(j+i)=','
    else
        tolket(j+i)=','
        i=i+1
        tolket(j+i)=' '
        i=i+1        
        tolket(j+i)=','
    end
end

%% bryter opp teksten - kutter ut mellomrom
    bokstaver = strsplit(tolket,',')

    
%% Mapper morse stringene til askii verider
    for j=2:length(bokstaver)   % starter fra 2 siden vi alltid vil ha en pause i starten
        s=char(bokstaver(j));
        helt_tolk(j)=outputmap(s);
    end
    char(helt_tolk) %skirver ut resultatet




        

CloseSensor(SENSOR_1);