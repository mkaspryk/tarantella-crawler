#!/usr/bin/python3

#============================================
# Name          :   insert_data.py
# Author        :   Marcin Grzegorz Kaspryk
# Version       :   1.1.1
# Copyright     :   ASL
# Description   :   Inserts data to the database
#============================================

import sys
import psycopg2

# creates connection
try:
    conn = psycopg2.connect(
        host="localhost",
        database="pages_data",
        user="postgres",
        password="zxcv")
    print("Connected to database")
except:
    print("Can't connect to database")

class webPagesData:
    domain_name=[]
    page_name=[]

def read_from_files(formatted_web_content,wbd):
    f = open(formatted_web_content+"/pageNames.txt", "r")
    for x in f:
        wbd.domain_name.append(x)
    f = open(formatted_web_content+"/pageFiles.txt", "r")
    for x in f:
        wbd.page_name.append(x)

# inserts data to table
def insert_data():
    if len(sys.argv) < 4:
        print("Not enough arguments passed")
        return
    
    wbd=webPagesData()
    formatted_web_content=sys.argv[3]
    read_from_files(formatted_web_content,wbd)

    table_name = sys.argv[1]
    command = """"""

    try:
        cur = conn.cursor()
        for i in range(len(wbd.page_name)):
            try:
                f = open(sys.argv[2] + "/"+ str(i) + ".txt", "r")
                try:
                    for x in f:
                        command = """"""
                        command ="""INSERT INTO """ + table_name
                        command +=""" VALUES(DEFAULT, """
                        command += "\'" + wbd.domain_name[i][:-1] + "\'"+ ", "
                        command += "\'" + wbd.page_name[i][:-1] + "\'" + ", "
                        command += x
                        command = command[:-2]
                        command += """)"""
                        cur.execute(command)
                except (Exception, psycopg2.DatabaseError) as error:
                        print(error)
            except:
                print("File "+ sys.argv[2] + "/" + str(i) + ".txt" +" doesnt't exist")
                return  
        cur.close()
        conn.commit()
        print("Data inserted successfully to table " + table_name)
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

if __name__ == '__main__':
    insert_data()
