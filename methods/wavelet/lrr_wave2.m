%% LRR + wavelet level 2
function fusionMap = lrr_wave2(sourceTestImage1,sourceTestImage2,lambda, unit, type)

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
% disp('Strat');
% tic;
% low frequency
[w,h] = size(A2_x1);
lf_col1 = im2col(A2_x1, [unit, unit], 'distinct');
lf_col2 = im2col(A2_x2, [unit, unit], 'distinct');
lf_colf = fusionLowCoe(lf_col1,lf_col2, type, unit);
A2_xf = col2im(lf_colf,[unit, unit],[w,h],'distinct');
% fusion_A2 = A2_xf;

% high frequency - first level
[w,h] = size(H1_x1);
hf1_col1 = im2col(H1_x1, [unit, unit], 'distinct');
hf1_col2 = im2col(H1_x2, [unit, unit], 'distinct');
% hf1_colf = fusionHighCoe_nsct_nsst(hf1_col1,hf1_col2,lambda, unit);
hf1_colf = fusionHighCoe(hf1_col1,hf1_col2,lambda, unit);
H1_xf = col2im(hf1_colf,[unit, unit],[w,h],'distinct');

vf1_col1 = im2col(V1_x1, [unit, unit], 'distinct');
vf1_col2 = im2col(V1_x2, [unit, unit], 'distinct');
% vf1_colf = fusionHighCoe_nsct_nsst(vf1_col1,vf1_col2,lambda, unit);
vf1_colf = fusionHighCoe(vf1_col1,vf1_col2,lambda, unit);
V1_xf = col2im(vf1_colf,[unit, unit],[w,h],'distinct');

df1_col1 = im2col(D1_x1, [unit, unit], 'distinct');
df1_col2 = im2col(D1_x2, [unit, unit], 'distinct');
% df1_colf = fusionHighCoe_nsct_nsst(df1_col1,df1_col2,lambda, unit);
df1_colf = fusionHighCoe(df1_col1,df1_col2,lambda, unit);
D1_xf = col2im(df1_colf,[unit, unit],[w,h],'distinct');


% high frequency - second level
[w,h] = size(H2_x1);
hf2_col1 = im2col(H2_x1, [unit, unit], 'distinct');
hf2_col2 = im2col(H2_x2, [unit, unit], 'distinct');
% hf2_colf = fusionHighCoe_nsct_nsst(hf2_col1,hf2_col2,lambda, unit);
hf2_colf = fusionHighCoe(hf2_col1,hf2_col2,lambda, unit);
H2_xf = col2im(hf2_colf,[unit, unit],[w,h],'distinct');

vf2_col1 = im2col(V2_x1, [unit, unit], 'distinct');
vf2_col2 = im2col(V2_x2, [unit, unit], 'distinct');
% vf2_colf = fusionHighCoe_nsct_nsst(vf2_col1,vf2_col2,lambda, unit);
vf2_colf = fusionHighCoe(vf2_col1,vf2_col2,lambda, unit);
V2_xf = col2im(vf2_colf,[unit, unit],[w,h],'distinct');

df2_col1 = im2col(D2_x1, [unit, unit], 'distinct');
df2_col2 = im2col(D2_x2, [unit, unit], 'distinct');
% df2_colf = fusionHighCoe_nsct_nsst(df2_col1,df2_col2,lambda, unit);
df2_colf = fusionHighCoe(df2_col1,df2_col2,lambda, unit);
D2_xf = col2im(df2_colf,[unit, unit],[w,h],'distinct');

% Inverse DWT
[f_m,f_n] = size(image_data1);

S_temp = S1;
C_temp = zeros(1,f_m*f_n);
[m2,n2] = size(A2_x1);
len1 = m2*n2;
[m1,n1] = size(H1_x1);
len2 = m1*n1;

C_temp(1:len1) = A2_xf(:);
C_temp(len1+1:2*len1) = H2_xf(:);
C_temp(2*len1+1:3*len1) = V2_xf(:);
C_temp(3*len1+1:4*len1) = D2_xf(:);
C_temp(4*len1+1:4*len1+len2) = H1_xf(:);
C_temp(4*len1+len2+1:4*len1+2*len2) = V1_xf(:);
C_temp(4*len1+2*len2+1:4*len1+3*len2) = D1_xf(:);

fusionImage = waverec2(C_temp,S_temp,wname);

% figure;
% imshow((fusionImage));

fusionMap = (fusionImage);
end

