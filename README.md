# Enunciado del problema

## Objetivo:
_Implementar una aplicación para generar contratos automáticamente, a partir de plantillas._

## Frontend
_Interfaz en QML._

## Backend 
_App en C++. Gestiona archivos y completa datos en las plantillas._

## A tener en cuenta
_Realizar un diseño pulido, con responsabilidades bien definidas, y sin solapamientos._

### _Serán necesarias, como mínimo, tres partes:_
- _Una que cargue la plantilla desde el almacenamiento._
- _Una que genere el PDF una vez completados los campos._
- _La interfaz._

> **Tip**
>
> Puede hacerse uso del módulo QtQuick.Dialogs, en el que se encuentra el elemento FileDialog, que nos permite obtener la ruta absoluta de un archivo.<br>
>
> https://doc.qt.io/qt-5/qml-qtquick-dialogs-filedialog.html

> **Tip**
>
> _Se pueden reutilizar elementos usados en otros proyectos, como CampoInput (o equivalente), o Boton. Para esto, puede importarse directamente desde la carpeta donde se encuentra el elemento (en otro proyecto) o se puede hacer una nueva versión en la carpeta local._


## Entrega
_El código debe subirse antes del lunes 21 de noviembre a las 23:59, al Classroom de GitHub._
