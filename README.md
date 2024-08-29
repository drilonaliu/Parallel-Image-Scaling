# Parallel-Image-Scaling

Image Scaling is done with bilinear interpolation algorithm, which can be used both for scaling up or scaling down an image. Each thread corresponds to the pixels of the scaled image. In the sequential version, we iterate on each pixel of the scaled image. In the both versions we use inverse mapping, that is, we take pixels from the original image and paste them in the scaled version of the image. Below is given the kernel code for the image scaling. 

```
/*
* Kernel Method for scaling image using Billinear Interpolation.
* 
* @param image - Uchar array of source image.
* @param scaledImage - uchar array of the scaled image.
* @param m - width scale.
* @param n - height scale.
* @param r - rows of source image.
* @paarm c - coloumns of src image.
*/
__global__ void cudaScaleImage(uchar* image, uchar* scaledImage, int m, int n, int r, int c) {
	int thread_index = threadIdx.x + blockDim.x * blockIdx.x;
	if (thread_index < m * n * r * c) {
		int i = thread_index % (m*r); //column
		int j = thread_index / (c*n); //row
		double a = (i - 1) * (r - 1) / (m * r - 1) + 1;
		double b = (j - 1) * (c - 1) / (n * c - 1) + 1;

		int  ii = round(a);
		int  jj = round(b);

		scaledImage[thread_index] = image[ii + r * jj];

	}
}
```
If we scale the image with a scale factor of 4, we get the resulting image.

<div>
 <img src = "readMeImages\lena.jpg">
 <img src = "readMeImages\scaledImage.jpg">
</div>





