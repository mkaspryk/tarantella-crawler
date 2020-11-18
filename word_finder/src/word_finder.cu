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

__global__ void finderKernel(int *count, char *dic_words, char *web_words,int *long_dic, int *long_web, int *longest_word){

	int j,x,tid = blockIdx.x*blockDim.x+threadIdx.x;

	while(tid< *long_dic){
		for(j=0;j<*long_web;++j){
			x=0;
			while(dic_words[(tid*(*longest_word))+x]==web_words[(j*(*longest_word))+x]){
				if(dic_words[(tid*(*longest_word))+x]=='\0'&&web_words[(j*(*longest_word))+x]=='\0'){
					++count[tid];
					break;
				}
				++x;
			}
		}
		tid+=blockDim.x*gridDim.x;
	}
}

void finder(int *set_device, int *flag, int *count, char *dic_words, char *web_words, int long_dic, int long_web, int LONGEST_WORD){

	char *dic_words_d, *web_words_d;
	int *count_d, *long_dic_d, *long_web_d, *longest_word_d;

	TRY(cudaMalloc((void**)&count_d,long_dic*sizeof(int)));
	TRY(cudaMalloc((void**)&dic_words_d,long_dic*LONGEST_WORD*sizeof(char*)));
	TRY(cudaMalloc((void**)&web_words_d,long_web*LONGEST_WORD*sizeof(char*)));
	TRY(cudaMalloc((void**)&long_dic_d,sizeof(int)));
	TRY(cudaMalloc((void**)&long_web_d,sizeof(int)));
	TRY(cudaMalloc((void**)&longest_word_d,sizeof(int)));

	TRY(cudaMemcpy(count_d,count,long_dic*sizeof(int),cudaMemcpyHostToDevice));
	TRY(cudaMemcpy(dic_words_d,&(dic_words[0]),long_dic*LONGEST_WORD*sizeof(char),cudaMemcpyHostToDevice));
	TRY(cudaMemcpy(web_words_d,&(web_words[0]),long_web*LONGEST_WORD*sizeof(char),cudaMemcpyHostToDevice));

	TRY(cudaMemcpy(long_dic_d,&long_dic,sizeof(int),cudaMemcpyHostToDevice));
	TRY(cudaMemcpy(long_web_d,&long_web,sizeof(int),cudaMemcpyHostToDevice));
	TRY(cudaMemcpy(longest_word_d,&LONGEST_WORD,sizeof(int),cudaMemcpyHostToDevice));

	finderKernel<<< (long_dic+1023)/1024,1024 >>>(count_d, dic_words_d, web_words_d, long_dic_d, long_web_d, longest_word_d);

	TRY(cudaDeviceSynchronize());

	TRY(cudaMemcpy(count,count_d,long_dic*sizeof(int),cudaMemcpyDeviceToHost));

	// frees the device memory
	cudaFree(count_d);
    cudaFree(dic_words_d);
    cudaFree(web_words_d);
    cudaFree(long_dic_d);
    cudaFree(long_web_d);
    cudaFree(longest_word_d);

	cudaDeviceReset();

	return;
}
