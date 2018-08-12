%% LRR + wavelet level 3
function fusionMap = lrr_wavelet_3level(sourceTestImage1,sourceTestImage2,lambda, unit, type)

image_data1 = im2double(sourceTestImage1);
image_data2 = im2double(sourceTestImage2);

% wavelet level 3
wname = 'sym2';
N = 3;
[C1,S1] = wavedec2(image_data1,N,wname);
A3_x1 = appcoef2(C1,S1,wname,N);%level 3, low
[H1_x1,V1_x1,D1_x1] = detcoef2('all',C1,S1,1);%level 1, high
[H2_x1,V2_x1,D2_x1] = detcoef2('all',C1,S1,2);%level 2, high
[H3_x1,V3_x1,D3_x1] = detcoef2('all',C1,S1,3);%level 3, high

[C2,S2] = wavedec2(image_data2,N,wname);
A3_x2 = appcoef2(C2,S2,wname,N);%level 2, low
[H1_x2,V1_x2,D1_x2] = detcoef2('all',C2,S2,1);%level 1, high
[H2_x2,V2_x2,D2_x2] = detcoef2('all',C2,S2,2);%level 2, high
[H3_x2,V3_x2,D3_x2] = detcoef2('all',C2,S2,3);%level 3, high

%--------------------------------------------------------------------------------------------%
% mutli-focus

% multi-modal
% unit = 8;
% unit = 9;

%% calculate level 1
% unit = 16; % for level 1 and 2
[row1,col1] = size(H1_x1);
fusion_H1 = zeros(row1,col1);
fusion_V1 = zeros(row1,col1);
fusion_D1 = zeros(row1,col1);

m = floor(row1/unit);
n = floor(col1/unit);

data_H1_x1 = H1_x1;
data_V1_x1 = V1_x1;
data_D1_x1 = D1_x1;

data_H1_x2 = H1_x2;
data_V1_x2 = V1_x2;
data_D1_x2 = D1_x2;

% disp('Start');
% tic;
for i=1:m
    for j=1:n
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

       %% High - diagonal
        coe_D1_x1 = data_D1_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_D1_x2 = data_D1_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        fusion_D1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareHighCoe(coe_D1_x1, coe_D1_x2,lambda);

    end
end
% toc;
% disp('Done');


%% calculate level 2
% unit = 16; % for level 1 and 2
[row2,col2] = size(H2_x1);
fusion_H2 = zeros(row2,col2);
fusion_V2 = zeros(row2,col2);
fusion_D2 = zeros(row2,col2);

m = floor(row2/unit);
n = floor(col2/unit);

data_H2_x1 = H2_x1;
data_V2_x1 = V2_x1;
data_D2_x1 = D2_x1;

data_H2_x2 = H2_x2;
data_V2_x2 = V2_x2;
data_D2_x2 = D2_x2;

% disp('Start');
% tic;
for i=1:m
    for j=1:n
       %% High - horizonal
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


%% calculate level 3
if unit>=32
    unit = 8; % for level 3
end
[row3,col3] = size(A3_x1);
fusion_A3 = zeros(row3,col3);
fusion_H3 = zeros(row3,col3);
fusion_V3 = zeros(row3,col3);
fusion_D3 = zeros(row3,col3);

data_A3_x1 = A3_x1;
data_H3_x1 = H3_x1;
data_V3_x1 = V3_x1;
data_D3_x1 = D3_x1;

data_A3_x2 = A3_x2;
data_H3_x2 = H3_x2;
data_V3_x2 = V3_x2;
data_D3_x2 = D3_x2;

m = floor(row3/unit);
n = floor(col3/unit);

% disp('Strat');
% tic;
for i=1:m
    for j=1:n
       %% Low
        coe_A3_x1 = data_A3_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_A3_x2 = data_A3_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);

        fusion_A3((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareLowCoe(coe_A3_x1, coe_A3_x2, type, unit);
%         mark_A3((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareLowCoe(coe_A3_x1, coe_A3_x2, type, unit);
        
       %% High - horizonal
        coe_H3_x1 = data_H3_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_H3_x2 = data_H3_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        fusion_H3((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareHighCoe(coe_H3_x1, coe_H3_x2,lambda);

       %% High - vertical
        coe_V3_x1 = data_V3_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_V3_x2 = data_V3_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        fusion_V3((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareHighCoe(coe_V3_x1, coe_V3_x2,lambda);

       %% High - diagonal
        coe_D3_x1 = data_D3_x1((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        coe_D3_x2 = data_D3_x2((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit);
        %lrr
        fusion_D3((i-1)*unit+1:i*unit,(j-1)*unit+1:j*unit) = compareHighCoe(coe_D3_x1, coe_D3_x2,lambda);

    end
end
% toc;
% disp('Done');

% Inverse DWT
[f_m,f_n] = size(image_data1);

S_temp = S1;
C_temp = zeros(1,f_m*f_n);
[m3,n3] = size(A3_x1);
len1 = m3*n3;
[m2,n2] = size(H2_x1);
len2 = m2*n2;
[m1,n1] = size(H1_x1);
len3 = m1*n1;

C_temp(1:len1) = fusion_A3(:);
C_temp(len1+1:2*len1) = fusion_H3(:);
C_temp(2*len1+1:3*len1) = fusion_V3(:);
C_temp(3*len1+1:4*len1) = fusion_D3(:);
C_temp(4*len1+1:4*len1+len2) = fusion_H2(:);
C_temp(4*len1+len2+1:4*len1+2*len2) = fusion_V2(:);
C_temp(4*len1+2*len2+1:4*len1+3*len2) = fusion_D2(:);
C_temp(4*len1+3*len2+1:4*len1+3*len2+len3) = fusion_H1(:);
C_temp(4*len1+3*len2+len3+1:4*len1+3*len2+2*len3) = fusion_V1(:);
C_temp(4*len1+3*len2+2*len3+1:4*len1+3*len2+3*len3) = fusion_D1(:);

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
        coeL = coe1;
    else
        coeL = coe2;
    end
    
end

end

%% choose strategy for High freauency - Lrr
function coeH = compareHighCoe(coe1,coe2,lambda)
% lambda = 3.5;
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

