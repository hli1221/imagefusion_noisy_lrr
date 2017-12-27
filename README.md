# Multi-focus Noisy Image Fusion using Low-Rank Representation

"[Hui Li, Xiao-Jnu Wu. Multi-focus Noisy Image Fusion using Low-Rank Representation.](https://pan.baidu.com/s/1bpg31KF)"

Under Review(IET image processing)

## The framework for fusion method

<b>The framework</b>
![](https://github.com/exceptionLi/imagefusion_noisy_lrr/blob/master/framework/framework_for_method.jpg)

<b>Fusion high frequency</b>
![](https://github.com/exceptionLi/imagefusion_noisy_lrr/blob/master/framework/fusion_highfrequency.jpg)

## Abstract

We propose a novel fusion method based on LRR for multi-focus noisy image fusion. 

In the discrete wavelet transform(DWT) framework, the low frequency coefficients are fused by spatial frequency, the high frequency coefficients are fused by LRR coefficients. Finally, the fused image is obtained by inverse DWT. 


## Figures
1 made_images_gau ---- source images contain Gaussian noise.
2 made_images_no  ---- source images contain Salt & Pepper noise.
3 made_images_poi ---- source images contain Poisson noise.


## Source code
1 main.m --- test demo.

2 LRR_wavelet_1level.m --- our method.

2 The code of LRR

	solve_lrr.m

	solve_l1l2.m

	inexact_alm_lrr_l1l2.m, inexact_alm_lrr_l1.m

	exact_alm_lrr_l1l2.m, exact_alm_lrr_l1.m

## LRR parts
Thr LRR method is proposed by Guangcan Liu in 2010.

"Liu G, Lin Z, Yu Y. Robust Subspace Segmentation by Low-Rank Representation[C]// International Conference on Machine Learning. DBLP, 2010:663-670."

And we just use this method in our paper without change.

