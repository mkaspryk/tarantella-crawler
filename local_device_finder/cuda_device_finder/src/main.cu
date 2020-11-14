//=======================================================================
// Name            : main.cu
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : CUDA config module
//=======================================================================

// includes, system
#include <stdio.h>

// includes CUDA
#include <cuda_runtime.h>

// includes header(CUDA errors catcher)
#include "cuda_error.hpp"

#define CUDA_DEVICE_NOT_FOUND -1

int set_device(){

	cudaDeviceProp prop;
	int i,count,set;
	float compute_capability;
	TRY(cudaGetDeviceCount(&count));

	if(count==0){
		return CUDA_DEVICE_NOT_FOUND;
	}

	set=0;
	compute_capability=prop.major+(prop.minor*0.1);

	printf("Number of devices: %d\n", count);
	for (i = 0; i < count; ++i) {
		printf("----------------Device specification------------------\n");
	    TRY(cudaGetDeviceProperties(&prop, i));
	    printf("Device number: %d\n", i);
	    printf("Device name: %s\n", prop.name);
	    printf("Compute capability: %d.%d\n", prop.major, prop.minor);
	    printf("Multi processor count: %d\n", prop.multiProcessorCount);
	    printf("Max threads per block: %d\n", prop.maxThreadsPerBlock);
	    printf("Max threads dimension: (%d, %d, %d)\n", prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2]);
	    printf("Max grid size: (%d, %d, %d)\n", prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2]);
	    printf("---------------------------------------------------------\n");
	    if(compute_capability<(prop.major+(prop.minor*0.1))){
	    	compute_capability=prop.major+(prop.minor*0.1);
	    	set=i;
	    }
	}
	printf("Setted device: %d",set);
	return set;
}


int main(int argc, char **argv)
{
	return set_device();
}

