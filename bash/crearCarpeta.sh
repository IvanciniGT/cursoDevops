# Si la carpeta ya existe
# Si la carpeta se ha creado
# Si la ruta donde habría que crear la carpeta estçá siendo usada pr otra cosa que no es una carpeta

RUTA=$1

if [ -d "$RUTA" ]; then # Comprueba si es un directorio
    exit 0              # Si lo es te piras, TODO OK !!!
elif [ -a "$RUTA" ]; then
    # No era un directorio
    # Devuelve true si la ruta existe
    exit 2              # Tengo algo ahi... que no es un directorio: Fichero, Pipe, Enlace simbolico
else
    # Ni es un directorio , ni hay nada ahi
    # Por lo tanto, que hago? creo el directorio
    mkdir -p $RUTA
        # Si las carpetas intermedias no existen las crea
        # si la carpeta ya existe no hace nada
    exit 1
fi
