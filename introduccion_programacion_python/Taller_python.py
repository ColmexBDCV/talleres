
######### Tipos de variables (cadenas, números, listas, diccionarios, boleanos) #########


texto = "Taller de Python"  # cadena

num = 35  # entero

floatante = 3.5  # flotante

verdadero = True  # boleano

falso = False  # boleano

list = ["pedro", "pablo", "juan", texto]  # lista

print(list[3])

dict = {"altura": "1.80",  # diccionario
        "peso": 100,
        "edad": num
        }

print(dict["edad"])


######### Operaciones básicas con variables #########

cadena1 = 'Python'  # Declara cadena con 'Python'

cadena2 = 'Lenguaje ' + cadena1.upper()  # Lenguaje PYTHON

cadena3 = 'Lenguaje ' 'Python'  # Lenguaje Python

cadena4 = "Python para principiantes"

cadena5 = " <-> " * 5  # repite 5 veces la cadena que precede al *

print(cadena5)

print(cadena4.title())  # Python Para principiantes

texto1 = "4.5"  # declara texto1
texto2 = "67"  # declara texto2
flotante2 = float(texto1)  # Convierte cadena a flotante -> 4.5
numero = int(texto2)  # Convierte de cadena a entero -> 67

print(flotante)
print(numero)

######### Operadores aritméticos y uso de paréntesis #########

total = ((24 - 10 + 2.3) * 4.3 / 2.1) ** 2

print(total)


######### Operadores comparación o relacionales #########

print("a" != "b")

print(3 == 4)

print(1000 > num)


######### Control del flujo: if #########


if "hola" != "Hola":
    print("son diferentes")

if 5 < 4:
    print("incorrecto")
else:
    print("correcto")


if dict["edad"] <= 12:  # se evalúa edad
    precio = 2  # precio = 2
elif 13 <= dict["edad"] <= 18:  # en caso contrario se evalúa...
    precio = 3  # si edad está entre 13 y 18, precio = 3
else:  # en cualquier otro caso...
    precio = 4  # precio = 4

print('A Pagar: ' + str(precio) + ' $')  # Muestra costo


######### Control del flujo: for... in #########

for l in list:  # recorre todos los elementos en la variable list
    print(l) #imprime elemento por elemento


for n in range(1, 50):  # recorre todos los elementos contenidos en una serie de 1 a 50
    if n % 2 == 0:  # evalua si el numero es par y lo imprime en caso de que lo sea.
        print(n)


######### Funciones con un número fijo de parámetros #########

# funcion que recibe dos parámetros y devuelve la sumatoria de los mismos
def sumar_dos_nums(num1, num2):
    return num1 + num2


print(sumar_dos_nums(5, 9))


######### Funciones con un número variable de parámetros #########

# funcion que recibe una cantidad indefinidad parámetros, los cuales agrupa en una lista
# y devuelve la sumatoria de los mismos

def sumar_varios_nums(*nums):
    total = 0
    for n in nums:
       total += n
    return total


print("primera llamada: "+str(sumar_varios_nums(1, 2, 3, 4, 5, 6)))

print("segunda llamada: "+str(sumar_varios_nums(1, 2, 3, 4)))

######### Funciones con parámetros con valores por defecto #########

# funcion donde se define el valor de uno de sus parámetros por defecto (iva)
# y hace un calculo de aumento porcentual al otro (total):


def tipo_iva(total, iva=16):
    return total + (total * iva / 100)


costo_zapatos = 568.3

# se invoca la funcion con un solo parámetro, por defecto se hace el calculo con iva= 16
print(tipo_iva(costo_zapatos))

# se invoca la funcion indicando 2 paramtros, por lo que el calculo on iva= 8
print(tipo_iva(costo_zapatos, 8))


######### Funciones con todos los parámetros con valores por defecto #########

# cuando se defienen todos los valores por defcto el orden que se utilice no importa
def repite_caracter(caracter="-", repite=3):
    return caracter * repite


print(repite_caracter())  # Se utilizan valores por omisión
print(repite_caracter('~', 30))  # Muestra línea con 30 ~
print(repite_caracter(repite=10, caracter='*'))  # Muestra: ~~~~~~~~~~


######### Funciones con parámetros que contienen diccionarios #########


def porc_aprobados(aprobados, **grupos):
    # Calcula el % de aprobados

    total = 0
    for alumnos in grupos.values():
        total += alumnos

    return aprobados * 100 / total


porcentaje_aprobados = porc_aprobados(48, g1=22, g2=25, g3=21)
print(porcentaje_aprobados)

#########  Uso de Módulos  #########


import math  # se pide la carga del modulo math

# se invoca a la funcion pi que esta dentro del modulo math
print('El valor de pi', math.pi)


# En vez de cargar todo el módulo se carga la función pi del módulo math

from math import pi

# Este uso no se recomienda:
print('El valor de pi', pi)  # es mejor: math.pi

# se le asigna un alias a la funcion pi del módulo math
from math import pi as mpi

# Este uso evita coliciones de nombres:
print('El valor de pi', mpi)  # es mejor: math.pi
