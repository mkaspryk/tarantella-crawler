//=======================================================================
// Name            : files_handling.hpp
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : Handling files
//=======================================================================

#ifndef FILES_HANDLING_HPP
#define FILES_HANDLING_HPP

// export C interface
extern "C"
void readingFiles(int argc, char**argv, int *flag, char **dic_words, char **web_words);

//! reads files content
void readingFiles(int argc, char**argv, int *flag, char **dic_words, char **web_words);

#endif
