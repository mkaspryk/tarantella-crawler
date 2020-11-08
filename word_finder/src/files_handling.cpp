//=======================================================================
// Name            : files_handling.cpp
// Author          : Marcin Grzegorz Kaspryk
// Version         : 1.0.0
// Copyright       : ASL
// Description     : Handling files
//=======================================================================

// includes, system
#include <iostream>
#include <string>
#include <cstring>
#include <fstream>

// includes header(files_handling)
#include "files_handling.hpp"

#define LOADED_CORRECTLY 0
#define DICTIONARY_FILE_NOT_FOUND -2
#define WEB_CONTENT_FILE_NOT_FOUND -3

void readingFiles(int argc, char**argv, int *flag, char **dic_words, char **web_words){

	std::string dictionary_file = argv[3];
	std::cout<<"dictionary_file: "<<dictionary_file<<std::endl;

	std::string web_content_file = argv[4];
	std::cout<<"web_content_file: "<<web_content_file<<std::endl;

	std::fstream dic_file;
	std::fstream web_file;

	dic_file.open(dictionary_file,std::ios::in);
	web_file.open(web_content_file,std::ios::in);

	if(!dic_file.is_open()){

		*flag = DICTIONARY_FILE_NOT_FOUND;
		return;
	}
	if(!web_file.is_open()){

		*flag=WEB_CONTENT_FILE_NOT_FOUND;
		return;
	}

	int i=0;
	std::string tmp_str;
	while (std::getline(dic_file, tmp_str)) {
		std::strcpy(dic_words[i],tmp_str.c_str());
		++i;
	}
	i=0;
	while (std::getline(web_file, tmp_str)) {
		std::strcpy(web_words[i], tmp_str.c_str());
		++i;
	}

	dic_file.close();
	web_file.close();

	*flag=LOADED_CORRECTLY;
	return;
}



