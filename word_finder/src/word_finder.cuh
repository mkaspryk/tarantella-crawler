//=======================================================================
// Name            : word_finder.cuh
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : CUDA module - Word Finder
//=======================================================================

#ifndef WORD_FINDER_CUH
#define WORD_FINDER_CUH

//! module word_finder main function
void finder(int *flag,char **dic_words,char **web_words,int long_dic,int long_web);

#endif
