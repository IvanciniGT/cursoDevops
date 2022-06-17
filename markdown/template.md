Esto es una frase que estoy escribiendo.
Esto es otra frase, pero del mismo párrafo.

Esto por contra, sería una frase de otro párrafo.\
Esta es una frase del mismo párrafo, pero que empieza en línea nueva, para ello acabo la frase anterior con 2 espacios en blanco o una contrabarra.

# Titulo principal

## Subtitulo

### Sub sub titulo

###### Sub sub sub sub sub sub titulo ########################

Puedo crear hasta 6 niveles de titulo

Hay una sintaxis alternativa (cutre, pasamos de ella) para los títulos:

Titulo principal
===

Subtitulo
--------------------------------------------------------------

Esta sintaxis permite definir solo 2 niveles de título. Para usarla hemos de poner al menos 3 = o -.

Saltos de sección

---

===

En markdown tenemos muchos sabores

## Listas

### Listas numeradas

1. Item 1
2. Item 2
3. Item. 3
4. Este item tiene varios parrafos.
 
   Si la escribo aquí, se une a la anterior
5. Incluso podemos tener sublistas
    1) subitem 1 
    1) subitem 2
    1) subitem 3
    1) subitem 4
    1) subitem 5

### Listas no numeradas

+ Item 1
+ Item 2
+ Item 3

Otra lista

- Item 1
- Item 2
- Item. 3
- Este item tiene varios parrafos.
 
   Si la escribo aquí, se une a la anterior
- Incluso podemos tener sublistas
    * subitem 1 
    * subitem 2
    * subitem 3
    * subitem 4
    * subitem 5

## Enlaces:

http://www.google.com

<http://www.google.com>

Esta es la forma guay: [Este es el texto del enlace](http://www.google.es)

## Imágenes:

![Texto alternativo](https://www.feelcats.com/wp-content/uploads/2019/03/gatitos.jpg)

## Estilos de texto

## Enfasis -> Cursiva

En un texto si pongo *alrededor de unas palabras* esas se representan como enfatizadas.

## Enfasis -> Resaltado

En un texto si pongo **alrededor de unas palabras** esas se representan como negrita.

## Enfasis y resaltado

En un texto si pongo ***alrededor de unas palabras*** esas se representan como enfatizadas.

## Tachado

Para tachar algo, lo ~~encerramos~~ entre virgulillas

## Codigo

Para resaltar una palabra o varias como código, la encerramos entre `contracomillas`.

si quiero poner mucho código:

```
Y aqui escribo codigo
Mucho codigo
Hola'Soy yo'
```

Esta sintaxis admite lenguajes informáticos

```java
// Your First Program

class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!"); 
    }
}
```

## Tablas

| Variable | Tipo de datos de la variable       | Descripción    |
| -------- | ---------: | :-------------------------------: |
| ports    | list(maps) | Sirve para dar los puertos que hay que abrir |
| ports    | list(maps) | Super variable |
| ports    | list(maps) | Otra super variable |