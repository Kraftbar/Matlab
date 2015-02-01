%%  Tar inn n� r� verdi og forrige filtrerte, filtrerer derifra

% @Innparamtere: raaverdi for n�m�ling "k"; forrige filtrerte verdi "k-1"
% Mattematisk sett glemmer denne funksjonen aldri f�rste verdi, uten om n�r
% k -> oo.
% @Retur: Den filtrerte av "k"

function filtrert = IIR(signal,signal_forrige_fil,A) % tar inn (signalarray(n), 
B=1-A %finner det resterende gangfaktor

filtrert=signal*A+signal_forrige_fil*B
