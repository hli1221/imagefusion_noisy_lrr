% contourlet
function fusionMap = contourlet(sourceTestImage1,sourceTestImage2,lam, unit,type)
% Contourlet Toolbox, http://www.ifp.uiuc.edu/~minhdo/software/

image_data1 = im2double(sourceTestImage1);
image_data2 = im2double(sourceTestImage2);

% Parameters
pfilt = '9-7';
dfilt = 'pkva';
nlevs = [2,2];    % Number of levels for DFB at each pyramidal level
% Contourlet decomposition
coeffs1= pdfbdec(image_data1, pfilt, dfilt, nlevs );
coeffs2= pdfbdec(image_data2, pfilt, dfilt, nlevs );

%--------------------------------------------------------------------------------------------%
% parameter for LRR
lambda = lam;
% unit = 16;

%% calculate low frequency
[x1,x2] = size(coeffs1{1});
% lf_col1 = coeffs1{1};
% lf_col2 = coeffs2{1};
% lf_colf = fusionLowCoe_sh(lf_col1,lf_col2);
lf_col1 = im2col(coeffs1{1}, [unit, unit], 'distinct');
lf_col2 = im2col(coeffs2{1}, [unit, unit], 'distinct');
lf_colf = fusionLowCoe(lf_col1,lf_col2, type, unit);
% lf_colf = lf_col1;
% lf_coe_f = lf_colf;
lf_coe_f = col2im(lf_colf,[unit, unit],[x1,x2],'distinct');
coeffs_f{1} = lf_coe_f;
% figure;imshow(lf_coe_f);

%% calculate high frequency
nb_level = size(coeffs1,2);
for i=2:nb_level
%     disp(['high frequency level: ', num2str(i)]);
    hf_coe1 = coeffs1{i};
    hf_coe2 = coeffs2{i};
    nb_subbands = size(hf_coe1,2);
    for j=1:nb_subbands
        hf_colf = fusionHighCoe_sh(hf_coe1{j}, hf_coe2{j});
        coeffs_f{i}{j} = hf_colf;
    end
end

% Reconstruction
fusionImage = pdfbrec(coeffs_f, pfilt, dfilt);

% figure;
% imshow((fusionImage));

fusionMap = (fusionImage);
end


function f_coe = fusionHighCoe_sh(coe1,coe2)

mask = coe1-coe2;
mask(find(mask<0)) = 0;
mask(find(mask>0)) = 1;

f_coe = mask.*coe1 + (1-mask).*coe2;

end


