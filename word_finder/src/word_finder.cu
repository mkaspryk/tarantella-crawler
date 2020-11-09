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

void finder(int *set_device, int *flag, int *count, char **dic_words, char **web_words, int long_dic, int long_web, int LONGEST_WORD){

	char **dic_words_d,**web_words_d;

	cudaMalloc((void**)&dic_words_d,long_dic*LONGEST_WORD*sizeof(char));
	cudaMalloc((void**)&web_words_d,long_web*LONGEST_WORD*sizeof(char));

	//cudaMemcpy();

	//cudaMemcpy();

//	int i;
//	for(i=0;i<long_dic;++i){
//		//dic_words_d[i] = (char*)malloc(LONGEST_WORD * sizeof(char));
//	}
//
//	for(i=0;i<long_web;++i){
//		//web_words_d[i] = (char*)malloc(LONGEST_WORD * sizeof(char));
//	}


	return;
}



