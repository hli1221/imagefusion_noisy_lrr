% choose strategy for High freauency - LRR
% for conturlet, shearlet, NSCT, NSST
function coe_f = fusionHighCoe_nsct_nsst(coe1,coe2,lambda, unit)
% faster version
[m,n]=size(coe1);
coe_f = zeros(m,n);
% reshape(coe2(:,ii), [unit unit])
for ii=1:n
    coe1_t = reshape(coe1(:,ii), [unit unit]);
    coe2_t = reshape(coe2(:,ii), [unit unit]);
    [Z1,E1] = solve_lrr(coe1_t, coe1_t, lambda,0,1);
    [Z2,E2] = solve_lrr(coe2_t, coe2_t, lambda,0,1);
    LRR1 = sum(svd(Z1));
    LRR2 = sum(svd(Z2));
    % choose-max
    if LRR1>LRR2
        coe_t = reshape(coe1(:,ii), [unit unit])*Z1;
    else
        coe_t = reshape(coe2(:,ii), [unit unit])*Z2;
    end
    coe_f(:,ii) = coe_t(:);

end

% % same as wavelet
% [m,n]=size(coe1);
% coe_f = zeros(m,n);
% % reshape(coe2(:,ii), [unit unit])
% for ii=1:n
%     coe1_t = reshape(coe1(:,ii), [unit unit]);
%     coe2_t = reshape(coe2(:,ii), [unit unit]);
%     [Z1,E1] = solve_lrr(coe1_t, coe1_t, lambda,0,1);
%     [Z2,E2] = solve_lrr(coe2_t, coe2_t, lambda,0,1);
%     LRR1 = sum(svd(Z1));
%     LRR2 = sum(svd(Z2));
%     % choose-max
%     if LRR1>LRR2
%         coe_t = reshape(coe1(:,ii), [unit unit])*Z1;
%     else
%         coe_t = reshape(coe2(:,ii), [unit unit])*Z2;
%     end
%     coe_f(:,ii) = coe_t(:);
% 
% end

end