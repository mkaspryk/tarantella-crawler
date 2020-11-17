//=======================================================================
// Name            : cpu_word_finder.hpp
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : CPU module - Word Finder
//=======================================================================

#ifndef __CPU_WORD_FINDER_HPP__
#define __CPU_WORD_FINDER_HPP__

// export C interface
extern "C"
void cpu_finder(int *count, char **dic_words, char **web_words, int long_dic, int long_web);

//! module word_finder main function
void cpu_finder(int *count, char **dic_words, char **web_words, int long_dic, int long_web);

#endif //! __CPU_WORD_FINDER_HPP__
