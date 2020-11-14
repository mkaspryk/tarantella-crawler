//=======================================================================
// Name            : word_finder.cu
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : CUDA module - Word Finder
//=======================================================================

// includes, system
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

// includes CUDA
#include <cuda_runtime.h>

// includes header(Word Finder CUDA module)
#include "word_finder.cuh"

// includes header(CUDA errors catcher)
#include "cuda_error.hpp"

__global__ void finderKernel(int *count, char *dic_words, char *web_words,int long_dic, int long_web){

	int tid = blockIdx.x;
	if(tid<long_dic){
		count[tid]++;
	}
}

void finder(int *set_device, int *flag, int *count, char **dic_words, char **web_words, int long_dic, int long_web, int LONGEST_WORD){

	char *dic_words_d=0,*web_words_d=0;
	int *count_d;

	TRY(cudaMalloc((void**)&dic_words_d,long_dic*LONGEST_WORD*sizeof(char)));
	TRY(cudaMalloc((void**)&web_words_d,long_web*LONGEST_WORD*sizeof(char)));
	TRY(cudaMalloc((void**)&count_d,long_dic*LONGEST_WORD*sizeof(int)));

	TRY(cudaMemcpy(dic_words_d,dic_words,long_dic*LONGEST_WORD*sizeof(char),cudaMemcpyHostToDevice));
	TRY(cudaMemcpy(web_words_d,web_words,long_web*LONGEST_WORD*sizeof(char),cudaMemcpyHostToDevice));
	TRY(cudaMemcpy(count_d,count,long_dic*LONGEST_WORD*sizeof(int),cudaMemcpyHostToDevice));

	dim3  grid(1, 1, 1);
	dim3  threads(32, 1, 1);

	finderKernel<<< grid,threads >>>(count_d, dic_words_d, web_words_d, long_dic, long_web);

	TRY(cudaDeviceSynchronize());

	TRY(cudaMemcpy(count,count_d,long_dic*LONGEST_WORD*sizeof(int),cudaMemcpyDeviceToHost));

	// frees the device memory
    cudaFree(dic_words_d);
    cudaFree(web_words_d);
    cudaFree(count_d);

	cudaDeviceReset();

	return;
}
