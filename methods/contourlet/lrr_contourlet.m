% LRR + contourlet
function fusionMap = lrr_contourlet(sourceTestImage1,sourceTestImage2,lam, unit,type)
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
% figure;imshow(coeffs1{1}{1});
% figure;imshow(coeffs2{1}{1});
[x1,x2] = size(coeffs1{1});
if x1>16 && x2>16
    lf_col1 = im2col(coeffs1{1}, [unit, unit], 'distinct');
    lf_col2 = im2col(coeffs2{1}, [unit, unit], 'distinct');
    lf_colf = fusionLowCoe(lf_col1,lf_col2, type, unit);
    % lf_colf = lf_col1;
    lf_coe_f = col2im(lf_colf,[unit, unit],[x1,x2],'distinct');
else
    lf_col1 = coeffs1{1};
    lf_col2 = coeffs2{1};
    lf_colf = fusionLowCoe_no_unit(lf_col1,lf_col2);
    % lf_colf = lf_col1;
    lf_coe_f = lf_colf;
end
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
        [xt1,xt2] = size(hf_coe1{j});
        if xt1>16 && xt2>16
            hf_col1 = im2col(hf_coe1{j}, [unit, unit], 'distinct');
            hf_col2 = im2col(hf_coe2{j}, [unit, unit], 'distinct');
            hf_colf = fusionHighCoe(hf_col1, hf_col2, lambda, unit);
%           hf_colf = hf_col1;
            coeffs_f{i}{j} = col2im(hf_colf,[unit, unit],[xt1,xt2],'distinct');
        else
            hf_colf = fusionHighCoe_nsct_nsst(hf_coe1{j}, hf_coe2{j}, lambda, unit);
%           hf_colf = hf_col1;
            coeffs_f{i}{j} = hf_colf;
        end
    end
end

% Reconstruction
fusionImage = pdfbrec(coeffs_f, pfilt, dfilt);

% figure;
% imshow((fusionImage));

fusionMap = (fusionImage);
end



%% choose strategy for Low freauency - SF
function coe_f = fusionLowCoe_no_unit(coe1,coe2)

[m,n]=size(coe1);

var_A2_x1 = variance_block(coe1);
var_A2_x2 = variance_block(coe2);

if var_A2_x1>var_A2_x2
    coe_f = coe1;
else
    coe_f = coe2;
end

end


