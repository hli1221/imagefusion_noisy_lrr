# Multi-focus Noisy Image Fusion using Low-Rank Representation

[Hui Li, Xiao-Jnu Wu. Multi-focus Noisy Image Fusion using Low-Rank Representation.](https://arxiv.org/abs/1804.09325)

IET image processing(Under Review)

## The framework for fusion method

### <b>DWT for level 2</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/dwt_images.png)

### <b>The framework</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/framework.png)

### <b>Fusion high frequency</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/fusion_high.png)

### <b>Original images</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/original_images.png)

### <b>Noise images with multi-focus</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/nosie_example.png)

## Abstract

We propose a novel fusion method based on LRR for multi-focus noisy image fusion. 

In the discrete wavelet transform(DWT) framework, the low frequency coefficients are fused by spatial frequency, the high frequency coefficients are fused by LRR coefficients. Finally, the fused image is obtained by inverse DWT. 


## Figures
1 original_images
2 mf_noise_images  ---- multi-focus images contain different noise
3 focus_images ---- sources images


## Source code
1 main_lrr.m --- test demo.

2 LRR_wavelet_1level.m --- lrr + wavelet level 1.

  LRR_wavelet_2level.m --- lrr + wavelet level 2(our method).
  
  LRR_wavelet_3level.m --- lrr + wavelet level 3.

3 The code of LRR

	solve_lrr.m

	solve_l1l2.m

	inexact_alm_lrr_l1l2.m, inexact_alm_lrr_l1.m

	exact_alm_lrr_l1l2.m, exact_alm_lrr_l1.m

## LRR parts
Thr LRR method is proposed by Guangcan Liu in 2010.

"Liu G, Lin Z, Yu Y. Robust Subspace Segmentation by Low-Rank Representation[C]// International Conference on Machine Learning. DBLP, 2010:663-670."

And we just use this method in our paper without change.


# Citation
```
@misc{li2017noisyimagefusion,
    author = {Hui Li},
    title = {CODE: Multi-focus Noisy Image Fusion using Low-Rank Representation},
    year = {2017},
    publisher = {GitHub},
    journal = {GitHub repository},
    howpublished = {\url{https://github.com/exceptionLi/imagefusion_noisy_lrr}}
  }
```

