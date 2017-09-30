
% 1 image process - wavelet
% 2 get image pacthes - 9*9
% 3 get LRR coefficients

for i=1:10
%     lam = 2;
%     lam = 4.5;
    lam = 100;

%     image_left = ['./made_images_poi/image',num2str(i),'_poi_left.png'];
%     image_right = ['./made_images_poi/image',num2str(i),'_poi_right.png'];
%     picname = ['fused_poi_',num2str(i)];
    
%     image_left = ['./made_images_gau/image',num2str(i),'_001_gau_left.png'];
%     image_right = ['./made_images_gau/image',num2str(i),'_001_gau_right.png'];
%     picname = ['fused_gau_001_',num2str(i)];

      image_left = ['./made_images_gau/image',num2str(i),'_0005_gau_left.png'];
      image_right = ['./made_images_gau/image',num2str(i),'_0005_gau_right.png'];
      picname = ['fused_gau_0005_',num2str(i)];

%     image_left = ['./made_images_no/image',num2str(i),'_02_no_left.png'];
%     image_right = ['./made_images_no/image',num2str(i),'_02_no_right.png'];
%     picname = ['fused_no_02_',num2str(i)];

%     image_left = ['./made_images_no/image',num2str(i),'_01_no_left.png'];
%     image_right = ['./made_images_no/image',num2str(i),'_01_no_right.png'];
%     picname = ['fused_no_01_',num2str(i)];

%     image_left = ['./made-images/image',num2str(i),'_left.png'];
%     image_right = ['./made-images/image',num2str(i),'_right.png'];
%     picname = ['fused',num2str(i)];
    
    sourceTestImage1 = imread(image_left);
    sourceTestImage2 = imread(image_right);

%     %% LRR+DWT

      tic;
      fusion_image_LRR = LRR_wavelet_1level(sourceTestImage1,sourceTestImage2,lam, 1);
      toc;


%     path_LRR = ['./fused_images_noise/',picname,'_',num2str(lam),'_wavelet_LRR.png'];
%     path_LRR = ['./fused_images10/',picname,'_',num2str(lam),'_wavelet_LRR.png'];

     path_LRR = ['./fused_images_new/',picname,'_',num2str(lam),'_wavelet_LRR.png'];
  
     imwrite(fusion_image_LRR,path_LRR,'png');


end



