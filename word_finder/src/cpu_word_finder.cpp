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

void cpu_finder(int *count, char *dic_words, char *web_words, int long_dic, int long_web, int longest_word){

	int i,j,x;
	for(i=0;i<long_dic;++i){
		for(j=0;j<long_web;++j){
			x=0;
			while(dic_words[(i*longest_word)+x]==web_words[(j*longest_word)+x]){
				if(dic_words[(i*longest_word)+x]=='\0'&&web_words[(j*longest_word)+x]=='\0'){
					++count[i];
					break;
				}
				++x;
			}
		}
	}
}
