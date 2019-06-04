% Multi-focus noisy image fusion based on LRR
addpath('./lrr');
addpath(genpath('./methods'));

% multi-scale transform
methods = {'lrr_wave2', ...
        'shearlet', 'lrr_shearlet', 'nsst', 'lrr_nsst', ...
        'contourlet', 'lrr_contourlet', 'nsct', 'lrr_nsct'};
    
% noise type
noise_lambda={{'_gau_0005', '4.5'}, {'_gau_001', '3'}, {'_gau_005', '1'}, {'_gau_01', '1'}, ...
        {'_sp_01', '1.5'}, {'_sp_02', '1'},...
        {'_poi','2'}};

unit = 16; % windwos size
index = 1;
fusion_method = methods{index}; % multi-scale transform
noise_label = noise_lambda{index}{1}; % noise type
lam = str2double(noise_lambda{index}{2}); % \lambda of LRR for different noises

disp([fusion_method,'-',noise_label]);
for i=1:10

    image_left = ['./mf_noise_images/image',num2str(i),noise_label,'_left.png'];
    image_right = ['./mf_noise_images/image',num2str(i),noise_label,'_right.png'];

    sourceTestImage1 = imread(image_left);
    sourceTestImage2 = imread(image_right);

    tic
    eval(['fusion_image_LRR = ', fusion_method, '(sourceTestImage1,sourceTestImage2,lam, unit, 0);']);
    toc
    fused_path = ['./fused_images/fused',num2str(i),noise_label, '_', fusion_method, '_unit',num2str(unit), '.png'];
    imwrite(fusion_image_LRR,fused_path,'png');

end