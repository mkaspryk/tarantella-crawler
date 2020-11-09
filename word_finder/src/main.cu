//=======================================================================
// Name            : main.cu
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : CUDA module - main function
//=======================================================================

// includes, system
#include <stdio.h>
#include <stdlib.h>
#include <cstring>

// includes header(Word Finder CUDA module)
#include "word_finder.cuh"

// includes header(files_handling)
#include "files_handling.hpp"

// export C interface
extern "C"
void readingFiles(int argc, char**argv, int *flag,char **dic_words,char **web_words);

#define LONGEST_WORD 45
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
	int i,j;
	// sets the GPU
	int set_device = strtol(argv[1], &p, 10);
	int long_dic = strtol(argv[2], &p, 10);
	int long_web = strtol(argv[3], &p, 10);

	char **dic_words = (char**)malloc(long_dic*sizeof(char *));
	char **web_words = (char**)malloc(long_web*sizeof(char *));

	for(i=0;i<long_dic;++i){
		dic_words[i] = (char*)malloc(LONGEST_WORD * sizeof(char));
	}

	for(i=0;i<long_web;++i){
		web_words[i] = (char*)malloc(LONGEST_WORD * sizeof(char));
	}

	readingFiles(argc,argv,&flag,dic_words,web_words);

	if(flag!=0){return flag;}

	//================================
	// data to collect
	int *count;
	count = (int*)malloc(long_dic * sizeof(int));
	for(i=0;i<long_dic;++i){
		count[i] = 0;
	}
	//================================

	finder(&set_device,&flag,count,dic_words,web_words,long_dic,long_web,LONGEST_WORD);

	for(i=0;i<long_dic;++i){

		printf("%s\n",dic_words[i]);
	}

	for(i=0;i<long_web;++i){

		printf("%s\n",web_words[i]);
	}

	// frees the memory
	for (i = 0; i < long_dic; ++i) {
		free(dic_words[i]);
	}
	for (i = 0; i < long_web; ++i) {
		free(web_words[i]);
	}

	printf("flag = %d\n",flag);

	return flag;
}
