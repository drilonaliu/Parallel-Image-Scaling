#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <iostream>
#include "ImageFunctions.h"
using namespace cv;
using namespace std;


#include <chrono>

using namespace chrono;


int main() {
	//Read Image
	Mat img = imread("Images/lena.tif", IMREAD_GRAYSCALE);

	//Scaling parametres
	double m = 3;
	double n = 3;

	//Use the scale image function to scale image 
	Mat scaledImg = scaleImage(img, m, n);

	// Display the original and scaled images
	imshow("Original Image", img);
	imshow("Scaled Image", scaledImg);
	waitKey(0);

	imwrite("Images/lena-3.tif", scaledImg);

	return 0;
}

