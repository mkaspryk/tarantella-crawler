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

#define DICTIONARY_FILE_NOT_FOUND -2
#define WEB_CONTENT_FILE_NOT_FOUND -3
#define PAGE_COUNT_FILE_NOT_FOUND -4

void readingFiles(char**argv, int *flag, char *dic_words, char *web_words, int longest_word){

	std::string dictionary_file = argv[4];
	//std::cout<<"dictionary_file: "<<dictionary_file<<std::endl;

	std::string web_content_file = argv[5];
	//std::cout<<"web_content_file: "<<web_content_file<<std::endl;

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
		std::strcpy(&(dic_words[longest_word*i]),tmp_str.c_str());
		++i;
	}
	i=0;
	while (std::getline(web_file, tmp_str)) {
		std::strcpy(&(web_words[longest_word*i]), tmp_str.c_str());
		++i;
	}

	dic_file.close();
	web_file.close();

	return;
}

void writingFile(char**argv, int *flag,int *count, int long_dic){

	std::string page_count_file = argv[6];
	//std::cout << "page_count: " << page_count_file << std::endl;
	std::fstream count_file;

	count_file.open(page_count_file,std::ios::out);
	if(!count_file.is_open()){
		*flag = PAGE_COUNT_FILE_NOT_FOUND;
		return;
	}

	int i;
	for(i=0;i<long_dic;++i){
		count_file<<count[i];
		count_file<<", ";
	}

	count_file.close();
}

