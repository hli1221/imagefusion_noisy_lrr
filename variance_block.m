%% Spatial Frequency
function [variance] = variance_block(A)
[V_A]=variance_coe(A);
variance = V_A;
end

function [v] = variance_coe(X)
coefficient = X;
[row,clom] = size(coefficient);
MN = row*clom;
sumRF = 0;
for i=1:row
    for j=2:clom
        sumRF = (coefficient(i,j)-coefficient(i,j-1))^2+sumRF;
    end
end
RF = sumRF/MN;

sumCF = 0;
for i=1:clom
    for j=2:row
        sumCF = (coefficient(j,i)-coefficient(j-1,i))^2+sumCF;
    end
end
CF = sumCF/MN;
v = sqrt(RF+CF);
end










