//=======================================================================
// Name            : main.cu
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : CUDA module main function
//=======================================================================

// includes header(Word Finder CUDA module)
#include "word_finder.cuh"
// includes header(files_handling)
#include "files_handling.hpp"

// export C interface
extern "C"
void readingFiles(int argc,char**argv,int flag);

////////////////////////////////////////////////////////////////////////////////
// Program main
////////////////////////////////////////////////////////////////////////////////
int main(int argc, char **argv)
{

	int flag;
	readingFiles(argc,argv,flag);

	return 0;
}
