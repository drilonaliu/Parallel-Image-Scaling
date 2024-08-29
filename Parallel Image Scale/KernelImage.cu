#include "KernelImage.cuh"
#include <iostream>
//#include "device_launch_parameters.h"

//for __syncthreads()
#ifndef __CUDACC__ 
#define __CUDACC__
#endif
#include <device_functions.h>


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