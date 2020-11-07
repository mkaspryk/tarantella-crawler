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
#include <fstream>

// includes header(files_handling)
#include "files_handling.hpp"

#define NOT_ENOUGH_PARAMETERS -1
#define DICTIONARY_FILE_NOT_FOUND -2
#define WEB_CONTENT_FILE_NOT_FOUND -3

void readingFiles(int argc, char**argv, int flag){

	if(argc<2){
		flag=NOT_ENOUGH_PARAMETERS;
		return;
	}
	std::string dictionary_file = argv[1];
	std::cout<<"dictionary_file: "<<dictionary_file<<std::endl;

	std::string web_content_file = argv[2];
	std::cout<<"web_content_file: "<<dictionary_file<<std::endl;
}

