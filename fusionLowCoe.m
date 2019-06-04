% choose strategy for Low freauency - SF
function coe_f = fusionLowCoe(coe1,coe2, type, unit)

[m,n]=size(coe1);
if type==1
    coe_f = ones(unit)/2;
else
    coe_f = zeros(m,n);
    for i=1:n
        
        var_A2_x1 = variance_block(reshape(coe1(:,i), [unit unit]));
        var_A2_x2 = variance_block(reshape(coe2(:,i), [unit unit]));

        if var_A2_x1>var_A2_x2
            coe_f(:,i) = coe1(:,i);
        else
            coe_f(:,i) = coe2(:,i);
        end
    end
    
end
end