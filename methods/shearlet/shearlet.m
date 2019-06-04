%% shearlet level
function fusionMap = shearlet(sourceTestImage1,sourceTestImage2,lam, unit,type)
% ShearLab, www.shearlab.org
% 
%  G. Kutyniok, W.-Q. Lim, R. Reisenhofer
%  ShearLab 3D: Faithful Digital SHearlet Transforms Based on Compactly Supported Shearlets.
%  ACM Trans. Math. Software 42 (2016), Article No.: 5.
%
% Kutyniok G, Lim W Q, Reisenhofer R. 
% ShearLab 3D: Faithful Digital Shearlet Transforms Based on Compactly Supported Shearlets[J]. 
% ACM Transactions on Mathematical Software (TOMS), 2016, 42(1): 5.
% 


[w,h] = size(sourceTestImage1);
% NN = 256;
image_data1 = im2double(sourceTestImage1);
image_data2 = im2double(sourceTestImage2);

% create shearlets
scales = 2;
shearletSystem = SLgetShearletSystem2D(0,size(image_data1,1),size(image_data1,2),scales);
% decomposition
coeffs1 = SLsheardec2D(image_data1,shearletSystem);
coeffs2 = SLsheardec2D(image_data2,shearletSystem);
[x1,x2,x3] = size(coeffs1);
coeffs_f = zeros(x1,x2,x3);
%--------------------------------------------------------------------------------------------%
% parameter for LRR
lambda = lam;
% unit = 16;

%% calculate low frequency
% figure;imshow(coeffs1(:,:,end));
% figure;imshow(coeffs2(:,:,end));
% lf_colf = fusionLowCoe_sh(coeffs1(:,:,end),coeffs2(:,:,end));
lf_col1 = im2col(coeffs1(:,:,end), [unit, unit], 'distinct');
lf_col2 = im2col(coeffs2(:,:,end), [unit, unit], 'distinct');
lf_colf = fusionLowCoe(lf_col1,lf_col2, type, unit);
% lf_colf = lf_col1;
% lf_coe_f = lf_colf;
lf_coe_f = col2im(lf_colf,[unit, unit],[w,h],'distinct');
coeffs_f(:,:,end) = lf_coe_f;
% figure;imshow(coeffs_f(:,:,end));

%% calculate high frequency
for i=1:(x3-1)
%     disp(['high frequency level: ', num2str(i)]);
    hf_col1 = coeffs1(:,:,i);
    hf_col2 = coeffs2(:,:,i);
    hf_colf = fusionHighCoe_sh(hf_col1, hf_col2);
    coeffs_f(:,:,i) = hf_colf;
end
% reconstruction
fusionImage = SLshearrec2D(coeffs_f,shearletSystem);
% figure;imshow(fusionImage);

fusionMap = (fusionImage);
end


function f_coe = fusionHighCoe_sh(coe1,coe2)

mask = coe1-coe2;
mask(find(mask<0)) = 0;
mask(find(mask>0)) = 1;

f_coe = mask.*coe1 + (1-mask).*coe2;

end
