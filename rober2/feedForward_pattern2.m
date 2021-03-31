
function [a,n1,a1,n2,a2] = feedForward_pattern2(W1,W2,W3, b1,b2,b3, pattern)
 %feedforward para un solo patron de entrada recibido
    n1 = W1*pattern+b1;
    a1 = (1.0)./((1.0)+exp(-n1)); %salida capa 1 (logsig)
    n2 = W2*a1+b2;
    a2 = (1.0)./((1.0)+exp(-n2)); %salida capa 2 (logsig)
    n3 = W3*a2+b3;
    a = n3; %salida capa 3 (purelin)
end

 






