# Multi-focus Noisy Image Fusion using Low-Rank Representation

[Hui Li, Xiao-Jnu Wu. Multi-focus Noisy Image Fusion using Low-Rank Representation.](https://arxiv.org/abs/1804.09325)



## The framework for fusion method

### <b>DWT for level 2</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/dwt_images.png)

### <b>NSCT for level 2</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/dec_nsct.png)


### <b>The framework</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/framework.png)

### <b>Fusion high frequency</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/fs_lrr.png)

### <b>Original images</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/original_images.png)

### <b>Noise images with multi-focus</b>
![](https://github.com/hli1221/imagefusion_noisy_lrr/blob/master/framework/nosie_example.png)


## Figures
1 original_images  

2 mf_noise_images  ---- multi-focus images contain different noises

3 focus_images ---- sources images


## Source code
1 main.m --- test demo.

2 'methods' - multi-scale transform frameworks

3 The code of LRR in 'lrr'

	solve_lrr.m

	solve_l1l2.m

	inexact_alm_lrr_l1l2.m, inexact_alm_lrr_l1.m

	exact_alm_lrr_l1l2.m, exact_alm_lrr_l1.m

## LRR parts
Thr LRR method is proposed by Guangcan Liu in 2010.

"Liu G, Lin Z, Yu Y. Robust Subspace Segmentation by Low-Rank Representation[C]// International Conference on Machine Learning. DBLP, 2010:663-670."

And we just use this method in our paper without change.


# Citation

For codes: 

```
@misc{li2017noisyimagefusion,
    author = {Hui Li},
    title = {CODE: Multi-focus Noisy Image Fusion using Low-Rank Representation},
    year = {2017},
    note = {\url{https://github.com/hli1221/imagefusion_noisy_lrr}}
  }
```

