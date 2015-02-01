% Angry Birds 1.1

% Gaute Nyboe - 06.10.2014

%% Initialiserer NXT
COM_CloseNXT all                % lukker alle NXT-håndtak
close all                       % lukker alle figurer
clear all                       % sletter alle variable


%% Initialiserer joystick
joymex2('open',0);                     % åpner joystick
joystick      = joymex2('query',0);    % spør etter data fra joystick
JoyMainSwitch = joystick.buttons(1);   % henter verdien fra knapp nr 1 som er stoppknappen


JoyMainSwitch=0



%% Første stadiet 1.1
%  Finner ut hva som er treff ommerådet. I praksis setter man en konstant
%  som blir brukt til å reg ne ut "hvor stor grisen er".
%  Eks: menu output = 3, da blir grisen sitt treffpunkt +- 3

t = 0:0.01:15; % s %  Bruker vektorer som inneholder mange verdier til å regne, for å få en "smooth" graf
g = 9.81;        % m/s^2

vansk=menu('Velg vansklighetsgrad', 'VANSKELIG','middels','lett')

gris= 63 %rand*100
plot(gris,2,'. g','markersize',20*vansk)
axis([0,100,0,100])

%% inputt
linje=[1,1]

axis([0,100,0,100])

pause(3)

%
% % Andre stadiet 1.2
%  Finner userinputs for utgangshastighet og vinkel. Det er bare disse to
%  veridene vi trenger for å plotte hvordan objektet vi sykter ut vil gå.
%  Ettersom vi ikke tar hensyn til luftmotstand.
while ~JoyMainSwitch % oppdateres grafisk helt til du skyter
    %% få tak i joystickdata
    joystick        = joymex2('query',0);       % spør etter data fra joystick
    JoyMainSwitch   = joystick.buttons(1);
    Ang_i   = double(45+(0.45*(joystick.axes(2)/327.68)))   %gjør det om til 45 til 0 eller 90, istedenfor -100 til 100
    Vel_i   = double((100+(-joystick.axes(3)/327.68))/2) % gjør det om til 0-100, istedenfor -100 til 100
    % oppdaterer tellevariabel
    hold off;
    plot(gris,2,'. g','markersize',vansk*20)
    hold on;
    plot([0,cosd(Ang_i)]*Vel_i,[0,sind(Ang_i)*Vel_i])
    axis([0,100,0,100])
    drawnow
    pause(0.01)
end


%% Tredje stadiet 3.1
%  Tar user inputs man har fått, regner ut hele senarioet før man viser det
%  grafisk.
hoyde=t*Vel_i*sind(Ang_i)-g*t.^2;
lengde= t*Vel_i*cosd(Ang_i);
hoyde_fart=Vel_i*sind(Ang_i)+g.*t

xsotertx= sort(abs(hoyde))
null_fake=xsotertx(2)
for n = 1:numel(hoyde);
    if abs(hoyde(n)) == null_fake;
        hoyde_caNull=n
    end
end


%% Tredje stadiet 3.2
%  projektil utskytningen illutreres gafisk
figure(1)
plot(gris,2,'. g','markersize',20*vansk)
hold on
for j=1:hoyde_caNull
    axis([0,100,0,100])
    plot(lengde(j),hoyde(j),'*b');
    drawnow
    pause(0.01)
end


%% Tjerde fase 4.1
%  Meld om man treffer eller ikke - ikke ferdig
treff_x=lengde(hoyde_caNull)
if (treff_x >= gris-vansk && treff_x <= gris+vansk)
    msgbox('Treff!!')
else
    msgbox('Ikke treff, prøv igjen!')
end
