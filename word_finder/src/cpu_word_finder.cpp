//=======================================================================
// Name            : cpu_word_finder.cpp
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : CPU module - Word Finder
//=======================================================================

// includes, system
#include <iostream>
#include <string.h>

#include "cpu_word_finder.hpp"

void cpu_finder(int *count, char **dic_words, char **web_words, int long_dic, int long_web){

	int i,j;
	for(i=0;i<long_dic;++i){

		for(j=0;j<long_web;++j){

			if(strcmp(dic_words[i],web_words[j])==0){
				++count[i];
			}
		}
	}
}


