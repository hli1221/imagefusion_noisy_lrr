% NSCT
function fusionMap = nsct(sourceTestImage1,sourceTestImage2,lam, unit,type)
% Nonsubsampled Contourlet Toolbox
% https://ww2.mathworks.cn/matlabcentral/fileexchange/10049-nonsubsampled-contourlet-toolbox

[w,h] = size(sourceTestImage1);
NN = max(w,h);
image_data1 = imresize(im2double(sourceTestImage1), [NN,NN]);
image_data2 = imresize(im2double(sourceTestImage2), [NN,NN]);

% Nonsubsampled Contourlet decomposition
% Decomposition level
nlevels = [2,2];
% Pyramidal filter
pfilter = 'maxflat';
% Directional filter
dfilter = 'dmaxflat7';

coeffs1 = nsctdec(image_data1, nlevels, dfilter, pfilter );
coeffs2 = nsctdec(image_data2, nlevels, dfilter, pfilter );

% shownsct(coeffs1) ;

%--------------------------------------------------------------------------------------------%
% parameter for LRR
lambda = lam;
% unit = 16;

%% calculate low frequency
% figure;imshow(dst1{1});
% figure;imshow(dst2{1});
% lf_col1 = coeffs1{1};
% lf_col2 = coeffs2{1};
% lf_colf = fusionLowCoe_sh(lf_col1,lf_col2);
lf_col1 = im2col(coeffs1{1}, [unit, unit], 'distinct');
lf_col2 = im2col(coeffs2{1}, [unit, unit], 'distinct');
lf_colf = fusionLowCoe(lf_col1,lf_col2, type, unit);
% lf_colf = lf_col1;
% lf_coe_f = lf_colf;
lf_coe_f = col2im(lf_colf,[unit, unit],[NN,NN],'distinct');
coeffs_f{1} = lf_coe_f;
% figure;imshow(lf_coe_f);

%% calculate high frequency
nb_level = size(coeffs1,2);
for i=2:nb_level
    disp(['high frequency level: ', num2str(i)]);
    hf_coe1 = coeffs1{i};
    hf_coe2 = coeffs2{i};
    nb_subbands = size(hf_coe1,2);
    for j=1:nb_subbands
        hf_col1 = hf_coe1{j};
        hf_col2 = hf_coe2{j};
        hf_colf = fusionHighCoe_sh(hf_col1, hf_col2);
%         hf_colf = hf_col1;
        coeffs_f{i}{j} = hf_colf;
    end
end

% Reconstruct image
fusionImage = nsctrec(coeffs_f, dfilter, pfilter) ;
% figure;
% imshow((fusionImage));
fusionImage = imresize(fusionImage, [w, h]);
fusionMap = (fusionImage);
end



function f_coe = fusionHighCoe_sh(coe1,coe2)

mask = coe1-coe2;
mask(find(mask<0)) = 0;
mask(find(mask>0)) = 1;

f_coe = mask.*coe1 + (1-mask).*coe2;

end