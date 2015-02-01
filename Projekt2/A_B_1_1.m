%%
% Angry Birds 1.0
% Gaute Nyboe - 04.09.2014

%% konst
t = 0:0.01:15;% s
g = 9.81;        % m/s^2

gris=[rand*100]
plot(gris,0, '*')
axis([0,100,0,100])
vansk=menu('Velg vansklighetsgrad', 'VANSKELIG','middels','lett')

%% inputt
axis([0,100,0,100])
prompt = 'What angle? ';
Ang_i = input(prompt);
prompt = 'What initaial velocity (m/s)? ';
Vel_i = input(prompt);
plot([0,cosd(Ang_i)]*Vel_i,[0,sind(Ang_i)*Vel_i])

%% plot

hoyde=t*Vel_i*sind(Ang_i)-g*t.^2;
lengde= t*Vel_i*cosd(Ang_i);
figure(1)
plot(gris,0, '*')
hold on

% finne ut når den treffer bakken
xsotertx= sort(abs(hoyde))
null_fake=xsotertx(2)
for n = 1:numel(hoyde);
    if abs(hoyde(n)) == null_fake;
        hoyde_caNull=n
    end
end


for j=1:hoyde_caNull
    axis([0,100,0,100])
    plot(lengde(j),hoyde(j),'*b');
    drawnow
    pause(0.001)
end

% meld om man treffer eller ikke - ikke ferdig
treff_x=lengde(hoyde_caNull)
if (treff_x >= gris-vansk && treff_x <= gris+vansk)
    msgbox('Du traff!!')
else
    msgbox('Du tapte')
end
