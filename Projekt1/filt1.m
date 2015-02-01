%% Tar gjennomsnittet av signalene den f�r inn.

% @Innparametere: signal - vektor med signaler; n - numel av signal
% N�r vektoren av m�linger
% best�r av mer enn 5 verdier, bruker den bare de 5 siste m�lingene.
% Med andre ord, vektlegger n*0.2+(n-1)*0.2+(n-2)*0.2+(n-3*)0.2+(n-4)*0.2
% @Retunerer da den filtrerte verdien. B�r settes inn i en filtrert vektor
% av samme lengde som siganlvektoren i main prog.

function [filtrert] = filt1(signal,n,k) % k= antall gjennomsnitt
    if n<=k
    filtrert=(sum(signal)/n);
    else
    filtrert=(sum(signal(n-(k-1):n))/k);        % siden arrayet 
    end
