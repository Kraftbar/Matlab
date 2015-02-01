%% Filtrerer signaler ved hjelp av brukers parametrisering

% @Innparamtere: signal - vektor med alle signaler; k - numel av signal;
% n - hvor mange "sampels" bruker vil bruke; eksp - hvor mye bruker vil
% vektlegge de siste verdiene i målingen sin (anbefalt k=[1,5])
% Forklaring på hvordan kode fungerer, se "kommentar" og kommentar i linjer
% @Returerer: filtrert verdi
% 


function [filtrert] = FIR2(signal,k,n,eksp)      % 
    if k>n   % n løper fra 1 til 4, for de første signalene
        n=k
    end
    %finner gangefaktorer
    gange_f=(1:n).^eksp
    gange_f=gange_f/sum(gange_f)
 
    


    
    %regner filtert verdi
     
   filtrert=sum(signal(k-n+1:k).*gange_f) % o= antall målinger
   
    filtrert=0;
    for j=1:n 
        a=signal(k-j+1 )*gange_f(n-j+1 )  % singal - k lang; g_f - n lang
        filtrert= a+ filtrert
    end
    
    