//=======================================================================
// Name            : files_handling.hpp
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : Handling files
//=======================================================================

#ifndef __FILES_HANDLING_HPP__
#define __FILES_HANDLING_HPP__

// export C interface
extern "C"
void readingFiles(char**argv, int *flag, char *dic_words, char *web_words, int longest_word);

//! reads formated files content
void readingFiles(char**argv, int *flag, char *dic_words, char *web_words, int longest_word);

// export C interface
extern "C"
void writingFile(char**argv, int *flag,int *count, int long_dic);

//! writes count to the result file
void writingFile(char**argv, int *flag,int *count, int long_dic);

#endif //! __FILES_HANDLING_HPP__
