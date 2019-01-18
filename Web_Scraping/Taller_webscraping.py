import sys
import os
import requests
from bs4 import BeautifulSoup

####### Directorio de Trabajo. ######

#os.chdir(sys.path[0])

####### Directorio de Trabajo. ######


base_url = "http://www.proteccioncivil.gob.mx"

req = requests.get(base_url +
                   '/es/ProteccionCivil/2018')
page = BeautifulSoup(req.text, "html.parser")


####### Buscar y recuperar hipervínculos de cada Estado. #######

main = "/Informes Estados"

if not os.path.exists(main):
    os.makedirs(main)

os.chdir(sys.path[0]+main)


estados = page.find_all('li', {"style": "text-align: left;"})

####### Extraer links a partir de los hipervínculos recuperados de cada estado. #######


links = []

for e in estados:
    links.append(e.a['href'])

####### Accediendo al hipervínculo de cada Estado y extraer todos los hipervínculos que apuntan a un documento PDF. #######

for l in links:
    pdfs = []
    req = requests.get(l)
    subpage = BeautifulSoup(req.text, "html.parser")

    pdfs = subpage.select("a[href*=.pdf]")

####### Crear una carpeta por cada Estado y guardar los informes en PDF correspondientes. #######

    directory = l.split("/")[-1]

    if not os.path.exists(directory):
        os.makedirs(directory)

    print("Guardando informes de: " + directory)

    for p in pdfs:
        file_name = p["href"].split("/")[-1]
        with open(directory+"/"+file_name, "wb") as file:
            # get request
            response = requests.get(base_url + p["href"])
            # write to file
            file.write(response.content)


