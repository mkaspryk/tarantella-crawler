//=======================================================================
// Name            : word_finder.cuh
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : CUDA module - Word Finder
//=======================================================================

#ifndef __WORD_FINDER_CUH__
#define __WORD_FINDER_CUH__

//! finder kernel
__global__ void finderKernel(int *count, char *dic_words, char *web_words,int *long_dic, int *long_web);

//! module word_finder main function
void finder(int *set_device, int *flag, int *count, char **dic_words, char **web_words, int long_dic, int long_web, int LONGEST_WORD);

#endif //! __WORD_FINDER_CUH__
