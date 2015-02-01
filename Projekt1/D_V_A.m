% Måling raa distanse, hastighet og vektor

% Kommentar: Dette programmet hviler på antagelsen om at det kun er statisk
% friksjon mellom hjul og materiale. Kunne analysere data og funnet de
% forskjellige kinetiske firksjonene til forsjellige underlagene, men det
% er ikke gjort.
% Antaglesen trer forøvrig i kraft i linje 48,49

%% Initialiserer NXT
COM_CloseNXT all                % lukker alle NXT-håndtak 
close all                       % lukker alle figurer  
clear all                       % sletter alle variable 
handle_NXT = COM_OpenNXT();     % etablerer nytt håndtak
COM_SetDefaultNXT(handle_NXT);	% setter globalt standard-håndtak

%% Initialiserer motor B og C
motorC = NXTMotor('C','SmoothStart',true); % initialiserer motor C
motorB = NXTMotor('B','SmoothStart',true); % initialiserer motor B

meny=menu('Hvilket motorpådrag vil du finne farten til?','10','20','30',...
'40','50','60','70','80','90','100')
meny=meny*10;
%% index for lagring i vektorer
i=1;
k=i
tic;
r=0.028     % radius på hjulene i cm; Kilde: avlest på hjul
% både distanse, fart, akselerasjon er 0 ved t_1, Dvs. at vi ikke starter
% prog med roboten i bevegelse
D(1)= 0;    
V(1)= 0;
A(1)= 0;
k=k+1
tic
while 4>toc

     dataC = motorC.ReadFromNXT();            % får litt forskjellig info fra motor C
     dataB = motorB.ReadFromNXT();
     RadC  = pi*(dataC.Position/180)*r;      % konverterer til radianner: pi*(DistB.Position/180)
     RadB  = pi*(dataB.Position/180)*r;      % også ganger med radius til hjul.
     D(k)= (RadC+RadB)/2;           
     %% Deriverter
     S(k) = toc;
     Ts = S(k)-S(k-1);
     V(k) = (D(k)-D(k-1))/Ts;
     A(k) = (V(k)-V(k-1))/Ts;


    PowerC=meny;
    PowerB=meny; % 0.4m/s
    

    
    %% set output data
    motorC.Power = PowerC;
    motorB.Power = PowerB;
    motorC.SendToNXT();
    motorB.SendToNXT(); 
    
    %%
    subplot(3,1,1)
    plot(S,D)
    xlabel('Tid')
    ylabel('Strekning')
    drawnow
    
    subplot(3,1,2)
    plot(S,V)
    xlabel('Tid')
    ylabel('Fart')
    drawnow
    
    
    subplot(3,1,3)
    plot(S,A)
    xlabel('Tid')
    ylabel('Akselerasjon')
    drawnow
    
    i=i+1;
    k=k+1;
end

%% stopp motorer
motorC.Stop;
motorB.Stop;

% Close NXT connection.
COM_CloseNXT(handle_NXT);