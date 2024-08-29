#include "ImageFunctions.h"

/* Image Scaling Function using Billinear Interpolation
*
* @param img - the image to scale 
* @param m - width scale
* @param n - height scale
* 
* @return scaled image
*/
Mat scaleImage(Mat img, double m, double n) {

	Mat copiedImage(m * img.rows, n * img.cols, img.type());

	int r = img.rows;
	int c = img.cols;

	for (int i = 0; i < m * r; i++) {
		double a = (i - 1) * (r - 1) / (m * r - 1) + 1;
		int  ii = round(a);
		for (int j = 0; j < n * c; j++) {
			double b = ((j - 1) * (c - 1) / (n * c - 1) + 1);
			int  jj = round(b);
			uchar pixel_value = img.at<uchar>(ii, jj);
			copiedImage.at<uchar>(i, j) = pixel_value;
		}
	}

	return copiedImage;
}