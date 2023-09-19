# UTF-8 y Unicode: la clave para abrir y exportar archivos CSV en EXCEL



 <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Licencia Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />Esta obra está bajo una <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Licencia Creative Commons Atribución-NoComercial 4.0 Internacional</a>. Atribuya a la Biblioteca Daniel Cosío Villegas, El Colegio de México, 2022.


## Problema 

Suele suceder que al abrir un archivo CSV en Microsoft Excel algunas codificaciones se pierdan. Este problema no se presenta en Google Sheets, LibreOffice u Openoffice. 

Este caso se resuelve desde Microsoft Office Prodessional Plus 2019. Puede que en otras versiones cambien las opciones que se despliegan en los menús. 

![](https://docutopia.tupale.co/uploads/ca0823ea706c6e9e2d86f48a5.JPG)



## ¿Cómo resolverlo?

> Debe importar el archivo desde el programa es decir, NO lo abra dando doble click o click derecho abrir con Excel. Al importarlo desde el programa se establece la codificación correcta y ya se soluciona el problema.

### Pasos

1. Abra Microsoft Excel y cree un documento en blanco
2. En la opción del menú **Datos | Data** seleccione **<obtener datos> <Desde un archivo> <Desde el texto csv>**
    
3. Se despliega una ventana en la que puede previsualizar su archivo. En la opción **<origen del archivo>** se despliegan varias opcione de codificación: árabe, chino, japonés, turco, coreano, etc.  Busque y seleccione Unicode-UTF8 el cuál integra ñ, tildes y signos que usamos en el español.

![](https://docutopia.tupale.co/uploads/ca0823ea706c6e9e2d86f48a6.JPG)

 4. Verifique en la ventana la opción de delimitadores. Al ser un archivo CSV "comma separeted values" se sobre entiende que es un archivo separado por comas. Verifique que este sea el separador y revise los datos en el previsualizador. Una vez esté todo bien proceda a crear el documento. 
    
5. De click a la opción **<cargar>** (botón inferior) y se abrirán los datos en la hoja de cálculo en blanco que abrió al iniciar. Ya no tendrá problemas con las ñ, tildes u otros signos. 
    
    
    
    ![](https://docutopia.tupale.co/uploads/ca0823ea706c6e9e2d86f48a7.JPG)

    
6. Al guardar el archivo verifique que lo guarda como unicode UTF-8 **<Guardar como**>**. En esta versión de excel junto al botón de **<guardar>** hay un menú que dice **Herramientas**. Elija **<opciones web>**. En la ventana que se despliega puede verificar en sus pestañas la **codificación**. Allí debe estar seleccionado por defecto Unicode UTF-8. 
    
¡Ya su archivo CSV se puede visualizar, guardar y trabajar en Excel sin problemas en su formato! 
    

    
