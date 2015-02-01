function [  ] = rotere( vinkel_lest )
%Rotere Tar inn arument og får roboten til å roterer etter input
%   Detailed explanation goes here
    O_s=0.115*2*pi   % cm den har svingt
    (3.6*vinkel_lest)/O_s;
    motorB.TachoLimit = 360;
end

