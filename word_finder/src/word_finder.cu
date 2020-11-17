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

__global__ void finderKernel(int *count, char *dic_words, char *web_words,int *long_dic, int *long_web){

	int tid = blockIdx.x*blockDim.x+threadIdx.x;

	while(tid< *long_dic){

		int i=0;
		while(i< *long_web){
			if(dic_words[tid]==web_words[i]){
				count[tid]=i;
			}
			i++;
		}
		tid+=blockDim.x*gridDim.x;
	}
}

void finder(int *set_device, int *flag, int *count, char **dic_words, char **web_words, int long_dic, int long_web, int LONGEST_WORD){


	char *dic_words_d, *web_words_d;
	int *count_d, *long_dic_d, *long_web_d;

	TRY(cudaMalloc((void**)&count_d,long_dic*sizeof(int)));
	TRY(cudaMalloc((void**)&dic_words_d,long_dic*LONGEST_WORD*sizeof(char*)));
	TRY(cudaMalloc((void**)&web_words_d,long_web*LONGEST_WORD*sizeof(char*)));
	TRY(cudaMalloc((void**)&long_dic_d,sizeof(int)));
	TRY(cudaMalloc((void**)&long_web_d,sizeof(int)));

	TRY(cudaMemcpy(count_d,count,long_dic*sizeof(int),cudaMemcpyHostToDevice));
	TRY(cudaMemcpy(dic_words_d,dic_words,long_dic*LONGEST_WORD*sizeof(char),cudaMemcpyHostToDevice));
	TRY(cudaMemcpy(web_words_d,web_words,long_web*LONGEST_WORD*sizeof(char),cudaMemcpyHostToDevice));

	TRY(cudaMemcpy(long_dic_d,&long_dic,sizeof(int),cudaMemcpyHostToDevice));
	TRY(cudaMemcpy(long_web_d,&long_web,sizeof(int),cudaMemcpyHostToDevice));

	finderKernel<<< (long_dic+127)/128,128 >>>(count_d, dic_words_d, web_words_d, long_dic_d, long_web_d);

	TRY(cudaDeviceSynchronize());

	TRY(cudaMemcpy(count,count_d,long_dic*sizeof(int),cudaMemcpyDeviceToHost));

	// frees the device memory
	cudaFree(count_d);
    cudaFree(dic_words_d);
    cudaFree(web_words_d);
    cudaFree(long_dic_d);
    cudaFree(long_web_d);

	cudaDeviceReset();

	return;
}
