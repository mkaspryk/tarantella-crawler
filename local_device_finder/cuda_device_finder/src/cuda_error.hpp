//=======================================================================
// Name            : cuda_error.hpp
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : Handling CUDA errors
//=======================================================================

#ifndef __CUDA_ERROR_HPP__
#define __CUDA_ERROR_HPP__
#include <stdio.h>
#include <cuda_runtime.h>

//! caching CUDA errors
static void tryError(cudaError_t err, const char* file, int line) {

	if (err != cudaSuccess) {
		printf("%s in %s at line %d\n", cudaGetErrorString(err),file, line);
		exit(-100);
	}
}

#define TRY(err) (tryError(err,__FILE__,__LINE__))

#endif //! __CUDA_ERROR_HPP__
