#! /usr/bin/python3

#============================================
# Name          :   insert_data.py
# Author        :   Marcin Grzegorz Kaspryk
# Version       :   1.0.0
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

# INSERT INTO table_name
# VALUES (value1, value2, value3, ...);

# inserts data to table
def insert_data():

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
        print("Data inserted successfully to " + sys.argv[1])
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

if __name__ == '__main__':
    insert_data()
