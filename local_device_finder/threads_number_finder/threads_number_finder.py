#!/usr/bin/python3

#============================================
# Name          :   threads_number_finder.py
# Author        :   Marcin Grzegorz Kaspryk
# Version       :   1.0.0
# Copyright     :   ASL
# Description   :   Returns the number of threads
#============================================

import os

def cpuNumber():
    return os.cpu_count()

cpuNumber()





