#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>


__global__ void cudaScaleImage(uchar* image, uchar* scaledImage, int m, int n, int r, int c);