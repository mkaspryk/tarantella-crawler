//=======================================================================
// Name            : word_finder.cuh
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.1
// Copyright       : ASL
// Description     : CUDA module - Word Finder
//=======================================================================

#ifndef __WORD_FINDER_CUH__
#define __WORD_FINDER_CUH__

//! finder kernel
__global__ void finderKernel(int *count, char *dic_words, char *web_words,int *long_dic, int *long_web, int *longest_word);

//! module word_finder main function
void finder(int *flag, int *count, char *dic_words, char *web_words, int long_dic, int long_web, int LONGEST_WORD, int device);

#endif //! __WORD_FINDER_CUH__
