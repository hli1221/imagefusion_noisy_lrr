%% LRR + wavelet level 2
function fusionMap = lrr_wavelet_2level(sourceTestImage1,sourceTestImage2,lambda, unit, type)

image_data1 = im2double(sourceTestImage1);
image_data2 = im2double(sourceTestImage2);

% wavelet level 2
wname = 'sym2';
N = 2;
[C1,S1] = wavedec2(image_data1,N,wname);
A2_x1 = appcoef2(C1,S1,wname,N);%level 2, low
[H1_x1,V1_x1,D1_x1] = detcoef2('all',C1,S1,1);%level 1, high
[H2_x1,V2_x1,D2_x1] = detcoef2('all',C1,S1,2);%level 2, high

[C2,S2] = wavedec2(image_data2,N,wname);
A2_x2 = appcoef2(C2,S2,wname,N);%level 2, low
[H1_x2,V1_x2,D1_x2] = detcoef2('all',C2,S2,1);%level 1, high
[H2_x2,V2_x2,D2_x2] = detcoef2('all',C2,S2,2);%level 2, high

%--------------------------------------------------------------------------------------------%
% mutli-focus
% unit = 16;
% multi-modal
% unit = 8;
% unit = 9;

%% calculate level 1
[row1,col1] = size(H1_x1);
fusion_H1 = zeros(row1,col1);
fusion_V1 = zeros(row1,col1);
fusion_D1 = zeros(row1,col1);

% m1 = row1;
% n1 = col1;

m1 = floor(row1/unit);
n1 = floor(col1/unit);

data_H1_x1 = H1_x1;
data_V1_x1 = V1_x1;
data_D1_x1 = D1_x1;

data_H1_x2 = H1_x2;
data_V1_x2 = V1_x2;
data_D1_x2 = D1_x2;

% disp('Strat');
% tic;
for i=1:m1
    for j=1:n1
       %% High - horizontal
        coe_H1_x1 = data_H1_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_H1_x2 = data_H1_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        fusion_H1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareHighCoe(coe_H1_x1, coe_H1_x2,lambda);

       %% High - vertical
        coe_V1_x1 = data_V1_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_V1_x2 = data_V1_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        fusion_V1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareHighCoe(coe_V1_x1, coe_V1_x2,lambda);

       %% Hogh - diagonal
        coe_D1_x1 = data_D1_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_D1_x2 = data_D1_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        fusion_D1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareHighCoe(coe_D1_x1, coe_D1_x2,lambda);

    end
end
% toc;
% disp('Done');


%% calculate level 2
[row2,col2] = size(A2_x1);
fusion_A2 = zeros(row2,col2);
fusion_H2 = zeros(row2,col2);
fusion_V2 = zeros(row2,col2);
fusion_D2 = zeros(row2,col2);
% map for low
mark_A2 = zeros(row2,col2);

m1 = floor(row2/unit);
n1 = floor(col2/unit);

data_A2_x1 = A2_x1;
data_H2_x1 = H2_x1;
data_V2_x1 = V2_x1;
data_D2_x1 = D2_x1;

data_A2_x2 = A2_x2;
data_H2_x2 = H2_x2;
data_V2_x2 = V2_x2;
data_D2_x2 = D2_x2;

% disp('Start');
% tic;
for i=1:m1
    for j=1:n1
       %% low
        coe_A2_x1 = data_A2_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_A2_x2 = data_A2_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);

        mark_A2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareLowCoe(coe_A2_x1, coe_A2_x2, type, unit);
        
       %% High - horizontal
        coe_H2_x1 = data_H2_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_H2_x2 = data_H2_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        fusion_H2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareHighCoe(coe_H2_x1, coe_H2_x2,lambda);

       %% High - vertical
        coe_V2_x1 = data_V2_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_V2_x2 = data_V2_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        fusion_V2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareHighCoe(coe_V2_x1, coe_V2_x2,lambda);

       %% High - diagonal
        coe_D2_x1 = data_D2_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_D2_x2 = data_D2_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        fusion_D2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareHighCoe(coe_D2_x1, coe_D2_x2,lambda);

    end
end
% toc;
% disp('Done');
fusion_A2 = mark_A2.*A2_x1 + (1-mark_A2).*A2_x2;

% Inverse DWT
[f_m,f_n] = size(image_data1);

S_temp = S1;
C_temp = zeros(1,f_m*f_n);
[m2,n2] = size(A2_x1);
len1 = m2*n2;
[m1,n1] = size(H1_x1);
len2 = m1*n1;

C_temp(1:len1) = fusion_A2(:);
C_temp(len1+1:2*len1) = fusion_H2(:);
C_temp(2*len1+1:3*len1) = fusion_V2(:);
C_temp(3*len1+1:4*len1) = fusion_D2(:);
C_temp(4*len1+1:4*len1+len2) = fusion_H1(:);
C_temp(4*len1+len2+1:4*len1+2*len2) = fusion_V1(:);
C_temp(4*len1+2*len2+1:4*len1+3*len2) = fusion_D1(:);

fusionImage = waverec2(C_temp,S_temp,wname);

% figure;
% imshow((fusionImage));

fusionMap = (fusionImage);
end

%% choose strategy for Low freauency - SF
function coeL = compareLowCoe(coe1,coe2, type, unit)

if type==1
    coeL = ones(unit)/2;
else
    var_A2_x1 = variance_block(coe1);
    var_A2_x2 = variance_block(coe2);
    
    if var_A2_x1>var_A2_x2
        coeL = ones(unit);
    else
        coeL = zeros(unit);
    end
    
end

end

%% choose strategy for High freauency - Lrr
function coeH = compareHighCoe(coe1,coe2,lambda)
% lrr
[Z1,E1] = solve_lrr(coe1,coe1,lambda,0,1);
[Z2,E2] = solve_lrr(coe2,coe2,lambda,0,1);

LRR1 = sum(svd(Z1));
LRR2 = sum(svd(Z2));

% choose-max
if LRR1>LRR2
    coeH = coe1*Z1;
else
    coeH = coe2*Z2;
end

end

