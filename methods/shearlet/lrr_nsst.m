%% LRR + ns shearlet
function fusionMap = lrr_nsst(sourceTestImage1,sourceTestImage2,lam, unit,type)
% Easley G, Labate D, Lim W Q. Sparse directional image representations 
% using the discrete shearlet transform[J]. Applied and Computational Harmonic Analysis, 2008, 25(1): 25-46.

[w,h] = size(sourceTestImage1);
NN = max(w,h);
image_data1 = imresize(im2double(sourceTestImage1), [NN,NN]);
image_data2 = imresize(im2double(sourceTestImage2), [NN,NN]);

% NSST decomposition
lpfilt='maxflat';
shear_parameters.dcomp =[2,2]; % 4 levels
shear_parameters.dsize =[32 32 16 16]; % directions for each level
[dst1,shear_f1]=nsst_dec2(image_data1, shear_parameters, lpfilt);
[dst2,shear_f2]=nsst_dec2(image_data2, shear_parameters, lpfilt);
% showcoes(dst1)

%--------------------------------------------------------------------------------------------%
% parameter for LRR
lambda = lam;
% unit = 16;
[x1, x2] = size(dst1);
%% calculate low frequency
% figure;imshow(dst1{1});
% figure;imshow(dst2{1});
lf_col1 = im2col(dst1{1}, [unit, unit], 'distinct');
lf_col2 = im2col(dst2{1}, [unit, unit], 'distinct');
lf_colf = fusionLowCoe(lf_col1,lf_col2, type, unit);
% lf_colf = lf_col1;
lf_coe_f = col2im(lf_colf,[unit, unit],[NN NN],'distinct');
dst_f{1} = lf_coe_f;
% figure;imshow(coeffs_f(:,:,end));

%% calculate high frequency

for i=2:x2
%     disp(['high frequency level: ', num2str(i)]);
    [n1, n2, n3] = size(dst1{i});
    for ii = 1:n3
        hf_col1 = im2col(dst1{i}(:,:,ii), [unit, unit], 'distinct');
        hf_col2 = im2col(dst2{i}(:,:,ii), [unit, unit], 'distinct');
        hf_colf = fusionHighCoe_nsct_nsst(hf_col1, hf_col2, lambda, unit);
        coeffs_f(:,:,ii) = col2im(hf_colf,[unit, unit],[NN NN],'distinct');
    end
    dst_f{i} = coeffs_f;
end
% reconstruction
fusionImage=nsst_rec2(dst_f, shear_f1, lpfilt);    
fusionImage = imresize(fusionImage, [w h]);
% figure;imshow(fusionImage);

fusionMap = (fusionImage);
end



