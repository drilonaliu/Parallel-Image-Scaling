#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <iostream>
#include "ParallelImageFunctions.cuh"
using namespace std;
using namespace cv;



int main() {

	//Read source image
	Mat img = imread("Images/lena.tif", IMREAD_GRAYSCALE);

	//Scale the source image
	Mat scaledImage = parallelScaleImage(img,4,4);

	// Display the original and scaled images
	imshow("Original Image", img);
	imshow("Scaled Image", scaledImage);

	//Save the scaled image as tif 
	imwrite("Images/scaledImage.tif", scaledImage);
	waitKey(0);

	return  0;
}