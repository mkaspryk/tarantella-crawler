#! /usr/bin/python3

#============================================
# Name          :   create_table.py
# Author        :   Marcin Grzegorz Kaspryk
# Version       :   1.0.0
# Copyright     :   ASL
# Description   :   Creats the table
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
        
# creates table in database - pages_data
def create_table():
    
    if len(sys.argv) < 3:
        print("Not enough arguments passed")
        return
    
    command = """ CREATE TABLE """
    command += sys.argv[1]
    command += """ ( page_id INTEGER PRIMARY KEY, """
    
    try:
        f = open(sys.argv[2], "r")
        for x in f:
            command += (f'"{x}"'+""" INTEGER, """)
        command=command[:-2]
        command +=""" ) """
    except:
         print("File "+ sys.argv[1] +" doesnt't exist")
         
    try:
        cur = conn.cursor()
        cur.execute(command)
        cur.close()
        conn.commit()
        print("Data table" + sys.argv[1]+" created successfully")
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            
if __name__ == '__main__':
    create_table()
