%%  Tar inn n� r� verdi og forrige filtrerte, filtrerer derifra

% @Innparamtere: raaverdi for n�m�ling "n"; forrige filtrerte verdi "n-1"
% Mattematisk sett glemmer denne funksjonen aldri f�rste verdi, uten om n�r
% n -> oo.
% @Retur: Den filtrerte av "n"

function filtrert = filt2(signal,signal_forrige,C) % tar inn (signalarray(n), 
K=1-C %finner det resterende gangfaktor

filtrert=signal*C+signal_forrige*K
