% Multi-focus noisy image fusion

label='';
lam = 4.5;
for k = 1:7
% different noise
if k==1
    label='_gau_0005';
    lam = 4.5;
end
if k==2
    label='_gau_001';
    lam = 3;
end
if k==3
    label='_gau_005';
    lam = 1;
end
if k==4
    label='_gau_01';
    lam = 1;
end
if k==5
    label='_sp_01';
    lam = 1.5;
end
if k==6
    label='_sp_02';
    lam = 1;
end
if k==7
    label='_poi';
    lam = 2;
end
disp(label);

for k=1:4
% different patch size
if k == 1
    unit = 4;
end
if k == 2
    unit = 8;
end
if k == 3
    unit = 16;
end
if k == 4
    unit = 32;
end
for i=1:10
    disp(num2str(i));
    image_left = ['./mf_noise_images/image',num2str(i),label,'_left.png'];
    image_right = ['./mf_noise_images/image',num2str(i),label,'_right.png'];

    sourceTestImage1 = imread(image_left);
    sourceTestImage2 = imread(image_right);

    % LRR+DWT
    disp('Start-LRR wave 1');
    tic;
    fusion_image_LRR = lrr_wavelet_1level(sourceTestImage1,sourceTestImage2,lam, unit, 0);
%     fused_path = ['./fused_mf_noise_unit/fused',num2str(i),label,'_lrr_wave1_unit',num2str(unit),'.png'];
%     imwrite(fusion_image_LRR,fused_path,'png');
    toc;
    disp('Start-LRR wave 2');
    tic;
    fusion_image_LRR = lrr_wavelet_2level(sourceTestImage1,sourceTestImage2,lam, unit, 0);
%     fused_path = ['./fused_mf_noise_unit/fused',num2str(i),label,'_lrr_wave2_unit',num2str(unit),'.png'];
%     imwrite(fusion_image_LRR,fused_path,'png');
    toc;
    disp('Start-LRR wave 3');
    tic;
    fusion_image_LRR = lrr_wavelet_3level(sourceTestImage1,sourceTestImage2,lam, unit, 0);
%     fused_path = ['./fused_mf_noise_unit/fused',num2str(i),label,'_lrr_wave3_unit',num2str(unit),'.png'];
%     imwrite(fusion_image_LRR,fused_path,'png');
    toc;
    disp('Done');

%     fusion_image_LRR = compare_DWT_based(sourceTestImage1,sourceTestImage2);
    
end
end
end

