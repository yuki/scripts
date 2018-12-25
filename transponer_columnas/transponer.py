#!/usr/bin/python
# -*- coding: utf8

"""
Recorre ficheros con datos tales que:

File    Imax_103FEMURMIRADOR.asc

finr_020.asc    33280.84877
finr_021.asc    29841.17951
finr_022.asc    26751.39889
finr_023.asc    25190.55222
finr_024.asc    23552.67586

Lo que nos interesa es transponer las columnas que empiezan por "finr" y
concatenar todos los resultados de los ficheros de un mismo directorio

"""

import sys
import os
import re

if __name__ == '__main__':
    for root, dirs, files in os.walk("."):
        print("root: " + root)
        results = [[],[]]
        results[0].append(root)
        results[1].append(root)
        for filename in sorted(files):
            print("file " + filename)
            file = open(root+"/"+filename,"r")
            for line in file:
                if re.search("^finr",line):
                    tup = line.split("\t")
                    tup[1] = tup[1].rstrip("\r\n")
                    tup[0] = tup[0].replace("finr_","")
                    tup[0] = tup[0].replace(".asc","")
                    tup[0] = filename+"_"+tup[0]
                    # print(tup)
                    results[0].append(tup[1])
                    results[1].append(tup[0])
            file.close()
            print results

        o_file = root+"/total.csv"
        print (o_file)
        file = open(o_file,"w")
        file.write(",".join(results[1])+"\n")
        file.write(",".join(results[0])+"\n")
        file.close()
