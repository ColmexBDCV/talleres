import csv

from urllib.request import urlopen

from urllib.error import HTTPError

from urllib.error import URLError

from bs4 import BeautifulSoup

#funcion que elimina los espacios multiples hasta dejar solo uno
def multi_whitespace_to_one(text):
    while '  ' in text:
        text = text.replace('  ', ' ')
    return text
    
#combinacion de metodos para el manejo de excepciones (errores)
try:
    #intenta abrir la URL a "rascar"
    html = urlopen("http://sandbox.colmex.mx/~rcuellar/webscraping/dialnet.html")

except HTTPError as e:

    print(e)

except URLError:

    print("Server down or incorrect domain")

else:
    #parse el contenido HTML a una estructura que puede manipularse en python
    page = BeautifulSoup(html.read(), "html5lib")

    #filtra todas las etiquetas IMG que tengan el atributo title' con el contenido "Acceso abierto"
    tags = page.findAll("img", {"title": ["Acceso abierto"]})
        
    datos = []

    #itera cada etiqueta filtradas
    for tag in tags:
        d = {}
        
        #se carga en la variable t el padre y abuelo del IMG correspondiente
        t= tag.parent.parent
        
        #busca el contenido de la etiqueta A y lo limpia
        d['titulo'] = multi_whitespace_to_one(t.a.text.replace("\n",""))
        
        #obtiene el valor del atributo HREF (hipervinculo)
        d['link'] = t.a['href']
        
        #busca la etiqueta P que contenga el atributo 'class' con el valor "autores" y lo limpia
        d['autores'] = multi_whitespace_to_one(t.find("p",class_="autores").text.replace("\n",""))
        
        #busca la etiqueta P que contenga el atributo 'class' con el valor "autores" y extrae el valor del parametro 'title' de la etiqueta acronym
        d['institucion'] = t.find("p",class_="autores").acronym['title']
        
         #busca la etiqueta P que contenga el atributo 'class' con el valor "fechaLectura"
        d['year'] = t.find("p",class_="fechaLectura").text
        
        #agregqa el diccionario creado a la lista
        datos.append(d)

#guarda en una variable los indices de la primera lista        
keys = datos[0].keys()

#crea un csv para almacenar la estructura creada.
with open('tesis_dialnet.csv', 'w') as output_file:
    dict_writer = csv.DictWriter(output_file, keys)
    dict_writer.writeheader()
    dict_writer.writerows(datos)
        