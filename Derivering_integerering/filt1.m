% % Tar gjennomsnittet av signalene den f�r inn.
% 
% @Innparametere: signal - vektor med signaler; k - numel av signal
% N�r vektoren av m�linger
% best�r av mer enn n verdier, bruker den bare de n siste m�lingene.
% F.eks, sett n=5, vektlegger x(k)*0.2+X(k-1)*0.2+X(k-2)*0.2+X(k-3*)0.2+X(k-4)*0.2 
% @Retunerer da den filtrerte verdien. B�r settes inn i en filtrert vektor
% av samme lengde som siganlvektoren i main prog.

function [filtrert] = FIR1(signal,k,n)
if k<=n
    filtrert=(sum(signal)/k);
else
    filtrert=(sum(signal(k-(n-1):k))/n);        % siden arrayet
end
