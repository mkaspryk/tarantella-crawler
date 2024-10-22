//=======================================================================
// Name            : main.cu
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.1
// Copyright       : ASL
// Description     : CUDA module - main function
//=======================================================================

// includes, system
#include <stdio.h>
#include <stdlib.h>

// includes CUDA
#include <cuda_runtime.h>

// includes header(Word Finder CUDA module)
#include "word_finder.cuh"

// includes header(Word Finder CPU module)
#include "cpu_word_finder.hpp"

// includes header(files_handling)
#include "files_handling.hpp"

// includes header(CUDA errors catcher)
#include "cuda_error.hpp"

// export C interface (reads content from files)
extern "C"
void readingFiles(char**argv, int *flag, char *dic_words, char *web_words, int longest_word);

// export C interface (writes to file dictionary count)
extern "C"
void writingFile(char**argv, int *flag,int *count, int long_dic);

// export C interface (CPU word finder)
extern "C"
void cpu_finder(int *count, char *dic_words, char *web_words, int long_dic, int long_web, int longest_word);

#define LONGEST_WORD 46
#define NOT_ENOUGH_PARAMETERS -1

////////////////////////////////////////////////////////////////////////////////
// Program main
////////////////////////////////////////////////////////////////////////////////
int main(int argc, char **argv)
{
	int flag=0;
	if(argc<4){
		flag=NOT_ENOUGH_PARAMETERS;
		return flag;
	}

	// uses only by strtol
	char *p;
	int i;
	// sets the GPU or if -1 -> CPU
	int set_device = strtol(argv[1], &p, 10);
	int long_dic = strtol(argv[2], &p, 10);
	int long_web = strtol(argv[3], &p, 10);

	char *dic_words = (char*)malloc(LONGEST_WORD*long_dic*sizeof(char));
	char *web_words = (char*)malloc(LONGEST_WORD*long_web*sizeof(char));

	//================================
	// data to collect
	int *count;
	count = (int*)malloc(long_dic * sizeof(int));
	//================================

	for(i=0;i<long_dic;++i){
		count[i] = 0;
	}

	readingFiles(argv, &flag, dic_words, web_words, LONGEST_WORD);

	if(flag!=0){return flag;}

	if(set_device==-1){
		cpu_finder(count, dic_words, web_words, long_dic, long_web, LONGEST_WORD);
	}else{
		finder(&flag, count, dic_words, web_words, long_dic, long_web, LONGEST_WORD, set_device);
	}

	//printf("dic words: \n");
	//for(i=0;i<long_dic;++i){
	//	printf("%d: %s\n",i,&(dic_words[i*LONGEST_WORD]));
	//}

	//printf("web words: \n");
	//for(i=0;i<long_web;++i){
	//	printf("%d: %s\n",i,&(web_words[i*LONGEST_WORD]));
	//}

	//printf("count dic words: \n");
	//for(i=0;i<long_dic;++i){
	//		printf("%d: %d\n",i,count[i]);
	//}

	writingFile(argv, &flag, count, long_dic);

	// frees the memory
	free(dic_words);
	free(web_words);
	free(count);

	return flag;
}
