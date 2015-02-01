%%  Tar inn nå rå verdi og forrige filtrerte, filtrerer derifra

% @Innparamtere: raaverdi for nåmåling "n"; forrige filtrerte verdi "n-1"
% Mattematisk sett glemmer denne funksjonen aldri første verdi, uten om når
% n -> oo.
% @Retur: Den filtrerte av "n"

function filtrert = filt2(signal,signal_forrige,C) % tar inn (signalarray(n), 
K=1-C %finner det resterende gangfaktor

filtrert=signal*C+signal_forrige*K
