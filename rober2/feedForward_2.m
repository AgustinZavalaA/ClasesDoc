
function a = feedForward_2(nPatrones,W1,W2,W3,b1,b2,b3,p)
%feedforward para todos los patrones
a = zeros(nPatrones, 1);
for i = 1:size(p,2)
    n1 = W1*p(:,i)+b1;
    a1 = (1.0)./((1.0) + exp(-n1)); %salida capa 1 (logsig)
    n2 = W2*a1+b2;
    a2 = (1.0)./((1.0) + exp(-n2)); %salida capa 2 (logsig)
    n3 = W3*a2+b3;
    a3 = n3;              %salida capa 3 (purelin)
    a(i,1) = a3;
end

end








