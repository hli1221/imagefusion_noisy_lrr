# Noisy image fusion using lrr
multi-focus noisy image fusion using low-rank representation


## Abstract

In the process of image acquisition, the noise is inevitable for source image. The multi-focus noisy image fusion is a very challenging task. However, there is no truly adaptive noisy image fusion approaches at present. As we all know, Low-Rank representation (LRR) is robust to noise and outliers. 

In this paper, we propose a novel fusion method based on LRR for multi-focus noisy image fusion. In the discrete wavelet transform(DWT) framework, the low frequency coefficients are fused by spatial frequency, the high frequency coefficients are fused by LRR coefficients. Finally, the fused image is obtained by inverse DWT. 

Experimental results demonstrate that the proposed algorithm can obtain state-of-the-art performance when the source image contains noise.