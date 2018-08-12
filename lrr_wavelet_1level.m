%% LRR + wavelet level 1
function fusionMap = lrr_wavelet_1level(sourceTestImage1,sourceTestImage2,lam, unit,type)

image_data1 = im2double(sourceTestImage1);
image_data2 = im2double(sourceTestImage2);

% wavelet operation
wname = 'sym2';
N = 1;% decomposition level
[C1,S1] = wavedec2(image_data1,N,wname);
A1_x1 = appcoef2(C1,S1,wname,N);% low frequency
[H1_x1,V1_x1,D1_x1] = detcoef2('all',C1,S1,1);% high frequency for level 1

[C2,S2] = wavedec2(image_data2,N,wname);
A1_x2 = appcoef2(C2,S2,wname,N);% low frequency
[H1_x2,V1_x2,D1_x2] = detcoef2('all',C2,S2,1);% high frequency for level 1

%--------------------------------------------------------------------------------------------%
% parameter for LRR
lambda = lam;
% unit = 16;

%% calculate level 1
[row1,col1] = size(H1_x1);
fusion_A1 = zeros(row1,col1);
fusion_H1 = zeros(row1,col1);
fusion_V1 = zeros(row1,col1);
fusion_D1 = zeros(row1,col1);
% map for low frequency
mark_A1 = zeros(row1,col1);

% m1 = row1;
% n1 = col1;

m1 = floor(row1/unit);
n1 = floor(col1/unit);

data_A1_x1 = A1_x1;
data_H1_x1 = H1_x1;
data_V1_x1 = V1_x1;
data_D1_x1 = D1_x1;

data_A1_x2 = A1_x2;
data_H1_x2 = H1_x2;
data_V1_x2 = V1_x2;
data_D1_x2 = D1_x2;

% disp('Start');
tic;
for i=1:m1
    for j=1:n1
       % low
        coe_A1_x1 = data_A1_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_A1_x2 = data_A1_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);

        if type==1
            mark_A1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = ones(unit)/2;
        else
            var_A1_x1 = variance_block(coe_A1_x1);
            var_A1_x2 = variance_block(coe_A1_x2);

            if var_A1_x1>var_A1_x2
                mark_A1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = ones(unit);
            else
                mark_A1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = zeros(unit);
            end
        end
        
        % High - horizontal
        coe_H1_x1 = data_H1_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_H1_x2 = data_H1_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        % lrr
        [Z1_H1_x1,E1_H1_x1] = solve_lrr(coe_H1_x1,coe_H1_x1,lambda,0,1);
        LRR1_H1_x1 = sum(svd(Z1_H1_x1));
        
        [Z2_H1_x2,E2_H1_x2] = solve_lrr(coe_H1_x2,coe_H1_x2,lambda,0,1);
        LRR2_H1_x2 = sum(svd(Z2_H1_x2));
        
        if LRR1_H1_x1>LRR2_H1_x2
            fusion_H1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = coe_H1_x1*Z1_H1_x1;
        else
            fusion_H1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = coe_H1_x2*Z2_H1_x2;
        end
        
        % High - vertical
        coe_V1_x1 = data_V1_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_V1_x2 = data_V1_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        [Z1_V1_x1,E1_V1_x1] = solve_lrr(coe_V1_x1,coe_V1_x1,lambda,0,1);
        [Z2_V1_x2,E2_V1_x2] = solve_lrr(coe_V1_x2,coe_V1_x2,lambda,0,1);
        
        LRR1_V1_x1 = sum(svd(Z1_V1_x1));
        LRR2_V1_x2 = sum(svd(Z2_V1_x2));

        if LRR1_V1_x1>LRR2_V1_x2
            fusion_H1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = coe_V1_x1*Z1_V1_x1;
        else
            fusion_H1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = coe_V1_x2*Z2_V1_x2;
        end
        
        % Hogh - diagonal
        coe_D1_x1 = data_D1_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_D1_x2 = data_D1_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        [Z1_D1_x1,E1_D1_x1] = solve_lrr(coe_D1_x1,coe_D1_x1,lambda,0,1);
        [Z2_D1_x2,E2_D1_x2] = solve_lrr(coe_D1_x2,coe_D1_x2,lambda,0,1);
        
        LRR1_D1_x1 = sum(svd(Z1_D1_x1));
        LRR2_D1_x2 = sum(svd(Z2_D1_x2));
        
        if LRR1_D1_x1>LRR2_D1_x2
            fusion_H1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = coe_D1_x1*Z1_D1_x1;
        else
            fusion_H1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = coe_D1_x2*Z2_D1_x2;
        end
    end
end
% toc;
% disp('Done');

fusion_A1 = mark_A1.*A1_x1 + (1-mark_A1).*A1_x2;
% Inverse DWT
[f_m,f_n] = size(image_data1);

S_temp = S1;
C_temp = zeros(1,f_m*f_n);
[m2,n2] = size(A1_x1);
len1 = m2*n2;

C_temp(1:len1) = fusion_A1(:);
C_temp(len1+1:2*len1) = fusion_H1(:);
C_temp(2*len1+1:3*len1) = fusion_V1(:);
C_temp(3*len1+1:4*len1) = fusion_D1(:);

fusionImage = waverec2(C_temp,S_temp,wname);

% figure;
% imshow((fusionImage));

fusionMap = (fusionImage);
end