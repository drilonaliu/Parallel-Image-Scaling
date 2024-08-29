#include "ParallelImageFunctions.cuh"
#include "KernelImage.cuh"


/* Parallel Image Scaling Function using Billinear Interpolation
*
* @param image - the image to scale
* @param m - width scale
* @param n - height scale
*
* @return scaled image
*/
Mat parallelScaleImage(Mat image, int m, int n) {


	uchar* imageData = image.data;
	Mat scaledImage(m*image.rows, n*image.cols, CV_8U);

	//Image Sizes
	int imageSize = image.rows * image.cols;
	int scaledImageSize = m * n * imageSize;

	//Device pointers 
	uchar* d_image;
	uchar* d_scaledImage;

	//Memory Allocation
	cudaMalloc((void**)&d_image, imageSize * sizeof(uchar));
	cudaMalloc((void**)&d_scaledImage, scaledImageSize * sizeof(uchar));

	//Memory Copy
	cudaMemcpy(d_image, imageData,imageSize*sizeof(uchar),cudaMemcpyHostToDevice);

	//Launch Kernel
	//Launch Kernel
	int threadsPerBlock = 256;
	int blocksPerGrid = (int)ceil(scaledImageSize / threadsPerBlock);
	dim3 grid_size(scaledImage.rows, scaledImage.cols);
	cudaScaleImage << <blocksPerGrid, threadsPerBlock >> > (d_image, d_scaledImage, m, n, image.rows, image.cols);
	
	//Wait For Cuda
	cudaDeviceSynchronize();

	//Copy Results back
	cudaMemcpy(scaledImage.data , d_scaledImage, scaledImageSize * sizeof(uchar), cudaMemcpyDeviceToHost);

	//Free device memory
	cudaFree(d_image);
	cudaFree(d_scaledImage);

	return scaledImage;
}
