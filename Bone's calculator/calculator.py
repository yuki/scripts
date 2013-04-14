#!/usr/bin/python
# -*- coding: utf8
"""Probando huesos!"""

"""
El formato del fichero que se le pasa al programa debe ser un fichero CSV cuya separación
de columnas debe ser el símbolo ;

En la primera fila deben aparecer el nombre de los huesos y su lado del cuerpo al que pertenecen
ambos separados por coma (,) 

El fichero debería quedar tal que:

      ;hueso1,L ;hueso2,R   ;hueso3,R
hueso1;0        ;1,2        ;2       
hueso2;1        ;0;3        ;2
hueso3;2        ;2;0        ;3

"""

import sys
from numpy import *
 
def main(args):
    if len(args) != 4:
        print "Debes hacer ./calculator.py Fichero 1.2 1.4"
        return 1
    else:
        file = args[1]
        media1 = args[2]
        media2 = args[3]
        
        try:
            my_data = recfromtxt(file, delimiter=';')
        except:
            print "ha habido error en el fichero"
            return 1
        
        header = my_data[0]
        #lineas
        for l in range(1,len(my_data)):
            row = my_data[l]
            #columnas
            for c in range(1,len(row)):
                bone1 = header[c].split(',')[0]
                side1 = header[c].split(',')[1]
                bone2 = row[0]
                side2 = header[l].split(',')[1]
                if bone1 != bone2:
                    if side1 != side2:
                        #print "Hago %s side %s con %s side %s y media %s" %(hueso1,lado1,hueso2,lado2, row[c])
                        if row[c] > media1 and row[c] < media2:
                            print "NOS GUSTA la combinacion %s side %s con %s side %s y media %s" %(bone1,side1,bone2,side2, row[c])
#                    else:
#                        print "IGNORO %s side %s con %s side %s" %(hueso1,lado1,hueso2,lado2)
#                else:
#                    print "NO HAGO %s con %s " %(cabecera[c],row[0])

if __name__ == '__main__':
    sys.exit(main(sys.argv))    