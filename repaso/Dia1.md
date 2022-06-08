# Dev->ops

Cultura de la AUTOMATIZACION de todo lo que hay entre Desarrollo y Operación.

# Metodologias Agiles de desarrollo de software

Scrum, Xtreme Programming...

Se basan en el concepto de ITERACION...
Le vamos a entregar al cliente el producto de forma incremental.
    Entrega 1 ... 10% de la funcionalidad ... pero 100% funcional. 2 semanas - 2 meses
    Entrega 2 ... 15% de la funcionalidad ... pero 100% funcional.
    ...
    Entrega 4 ... 25% de la funcionalidad ... pero 100% funcional.
    ...
    Entrega n ... 100% de la funcionalidad ... pero 100% funcional.

Trabajos:
- Plan                  No es automatizable
- Desarrollo            Poco automatizable.... Fichero con código... images... css 
- Empaquetado           Si es automatizable
    - JAVA:             maven , gradle, sbt
    - MICROSOFT:        msbuild
    - JS:               npm
    - Todoterreno:      ant
    ---------------------------------------------------------------> Hacer desarrollo ágil
- Pruebas               
    - Diseño de la prueba       No son automatizables... TESTERs ---> Programa
        - Pruebas dinámicas   
            - Pruebas funcionales
                - Pruebas unitarias
                    - JUNIT, TestNG, MSTest
                    - SoapUI
                    - Posman
                - Pruebas de integración
                - Pruebas de sistema
                    - Selenium
                    - Appium
                - Pruebas de aceptación
            - Pruebas no funcionales
                - Pruebas de carga
                    - JMeter
                    - Loadrunner
                - Pruebas de estres
                - Pruebas de UI
                - Pruebas de UX
        - Pruebas estáticas: Que no requieren ejecutar el código... Solo leerlo
            - Sonarqube: Analisis de calidad de código
    - Ejecución de la prueba            Esto es lo que automatizamos
    ----------------------------------------------------------------------------> Integración continua
        Donde instalo?  Entorno de pre/integración
            Existe? Quizás ni existe... lo normal es que no exista a dia de hoy.
            Ese entorno hay que crearlo:
                Terraform: Adquirir un entorno físico en un cloud
                Vagrant:   Generar máquinas virtuales
                Ansible, Puppet, Chef: Provisionar un entorno
                Kubernetes: Suelto contenedores *****
- Distribución
    Quiero entregar en mano el softeware a mi cliente final, de forma que pueda usarlo...   
        Web
        Nexus
        Artifactory
        Registry de imagenes de contenedor
    ----------------------------------------------------------------------------> Entrega continua
- Instalación
                Terraform: Adquirir un entorno físico en un cloud
                Vagrant:   Generar máquinas virtuales
                Ansible, Puppet, Chef: Provisionar un entorno
                Kubernetes: Suelto contenedores
    ----------------------------------------------------------------------------> Despliegue continuo
- Operación
- Monitorización

## Entornos

- Entorno de desarrollo
- Entorno de preproducción < Integración
- Entorno de producción

DEVOPS
------------------------
- Continuous integration:
  Quiero siempre (continuamente) la última versión que tengan los desarrolladores 
  en el entorno de Integración, sometida a pruebas automatizadas

- Continuous delivery
- Continuous deployment


JENKINS, AzureDevops, TravisCI, Github CI/CD, Gitlab CI/CD, Bamboo
Servidores de Automatización, Servidores de CI/CD

Sistema de control de código fuente: 
SCM: git 
        github
        gitlab
        bitbucket
     csv
     subversion (svn)
     mercurial
     
# Qué es un devops?
  El que junta todas las piezas
  
  
  
# Contenedores

## Qué es un contenedor?

Un entorno aislado donde ejecutar procesos solamente dentro de un SO LINUX.

Aislado??? en cuanto a qué?
    - Un contenedor (ese entorno) tiene su propia configuración de red -> su propia dirección IP
    - Un contenedor tiene su propio sistema de archivos, independiente del host
    - Un contenedor tiene limitación de acceso a los recursos Hardware de la máquina (Memoria, disco, ancho de banda de red, cpu)
    - Un contenedor tiene sus propias variables de entorno

Windows puedo correr un contenedor: SI... pero con truco, igual que en MacOS.
Tanto en windows, como el MacOS, cuando instalamos DOCKER for Windows, docker for MAC, que que ocurre es que 
dentro de nuestra computadora se crea una máquina virtual que levanta un kernel de Linux, 
sobre el que se ejecutan los contenedores.

Un contenedor es solo una forma alternativa de ejecutar un software dentro de un SO Linux.

## Metodos de instalación y ejecución de software:

### Método más tradicional: INSTALACION A PELO!!!

    App1  +  App2  +  App3          Problemas: 
    -----------------------             - Incompatibilidades en configuraciones/librerias
              SO                        - Si un app (app1) se vuelve loca(tiene un bug) y pone la CPU 100% (RAM... disco...)
    -----------------------                 - El resto de apps se fastidian... se caen.. no hay CPU... pa' nadie
            HIERRO                      - Seguridad: Un app puede acceder a los ficheros (datos) de otro app ->  :( VIRUS

### Método 2: Uso de Máquinas virtuales

       App1     |       App2  +  App3                 Esto resuleve los problemas de las instalaciones tradicionales...
    ----------------------------------------------         
        SO 1    |          SO 2
    ----------------------------------------------    Pero.. esto viene con sus propios problemas:      
        MV 1    |          MV 2                             - Esto es mucho más complejo-> 
    ----------------------------------------------              - Configuración / mantemiento más complejo
    Hipervisor: HyperV, VirtualBox, VMWare                      - Merma de recursos
    ----------------------------------------------              - Empeoramiento del rendimiento
              SO                    
    ----------------------------------------------         
            HIERRO                  

### Método 3: Contenedores

       P1       |       P2 + P3
    ----------------------------------------------  
        C 1     |        C 2                     
    ----------------------------------------------  
     Gestor de contenedores: 
    LXC, LMCTFY,  Docker, ContainerD, Podman, CRIO
    ----------------------------------------------  
              SO Linux                 
    ----------------------------------------------         
               HIERRO                  


Imaginad que quiero instalar office en mi máquina (física o virtual)... qué necesito?
- Descargar el office??? NO... qué descargo? Un instalador de office -> Script
    - C:\ARCHIVOS DE PROGRAMA\OFFICE -> ZIP y los la mando por email... 
                y la descomprimís en el mismo sitio de vuestra computadora... funciona?

Cómo instalo un software en un contenedor?
A través de una Imagen de contenedor... Qué es?
- Un triste fichero comprimido (tar) que incluye un programa YA INSTALADO y CONFIGURADO por alguien.

De donde sacamos las imágenes de contenedor? Las sacamos de un registry de repositorios de imágenes de contenedor.
    DockerHub
    quay.io     Registry de repos de imagenes de contenedor de REDHAT
    


# Estas semanas tenemos por delante:

Openshift ->
Ansible   -> Redhat


# Tipos de Software

- Sistema Operativo
- Drivers
- Aplicación            Un software que:
                           - se ejecuta en primer plano
                           - de forma indefinida en el tiempo
                           - está pensado interactuar con un humano... es el que le da ordenes
---------------------------------------------------------------------------------------------------VVV
- Demonios              Un software que:
                           - se ejecuta en segundo plano
                           - de forma indefinida en el tiempo
                           - no están pensado para interactuar con un humano:
                            - o bien no interactuan con nadie... van a su bola -> demonio
                            - o bien están pensados para interactuar con otros programas:
- Servicios             Un demonio pensado para interactuar con otros programas:
                            Servicio de impresión, web, bbdd
- Script                Un software que:
                           - se ejecuta en primer o segundo plano
                           - de forma finita en el tiempo
                           - No está pensado para interactuar con nadie... ejecuta una serie de tareas y acaba
- Comando               Un software que hace una tarea puntual sin hablar con nadie

Dentro de un contenedor ejecutamos:
    Servidores: 
        Correo
        Web
        BBDD
    Demonios
    Scripts < Pipeline Jenkins
    Comandos: Ansible

Aplicación WEB: 
    Se ejecuta en un servidor.... Y quien es quien interactura con el servicio/aplicación... Un navegador de internet

Humano -> Navegador de internet --> Aplicación web (servicio)

## Cuantos procesos puedo ejecutar en un contenedor? MONTONONES !!! los que quiera... limitado por los recursos

# Qué es UNIX®?

El conjunto de estos estándares:
    POSIX
    SUS
Cada empresa fabricante de Hardware suele crear su propio SO para sus máquinas concretas...
Y muchas optan por seguir estos estándares.
    ORACLE: Solaris (sun microsystems)
    HP:     HP-UX
    IBM:    AIX
    APPLE:  MacOS

# Qué era UNIX®?

Un sistema operativo que sale en los laboratorios Bell de AT&T.
MULTICS < 75$ > UNICS > UNIX... +400 versiones de UNIX


Hubo gente que quiso hacer un SO que siguiera esos estándares... pero gratuito.. 
y por ende sin pagar ni un pavo por la certificación:
- 386BSD : CAGADA
- GNU:     Movimiento del software libre.
           GNU is NOT UNIX

            Cargador de arranque
            Nucleo - Kernel ********
            Shell - Interacuar con el kernel
                Linea de comandos - cmd, powershell.  bash
                UI                - fluentdesign.     gnome
            bloc de notas               gedit
            juegos                      chess
            administrador de programas
            administrador de archivos
            Compiladores: make, gcc
- Linus Torwals: Linux: Kernel de SO que SUPUESTAMENTE cumple con la spec UNIX.
    GNU/Linux-> Se ofrece en distros, distribuciones, o sabores. 75% codigo es de GNU, y el 25% de Linus
        Debian -> Ubuntu
        Redhat -> RHEL , CentOS, Oracle Unbreakeble linux, Fedora
        Suse

Hubo gente que cogio el nucleo de Linux y no uso las librerias de GNU... y pusieron las suyas propias:
    GOOGLE -> ANDROID

## Docker

Posiblemente la herramienta más utilizada para trabajar con contenedores...
Solo tiene un pequeñito problema... NO SIRVE PARA ENTORNOS DE PRODUCCION... No está pensada para ello.
Está pensado para ser ejecutado (y controalr) los contenedores de UNA MAQUINA.
En un entorno de producción necesito otro tipo de herramienta:
    Gestor de gestores de contenedores
    Orquestador de Contenedores
        KUBERNETES
            Maquina 1 - Docker, CRIO, containerD. CATAPLOF !!!
                MariaDB - BBDD... que a lo largo del tiempo... irá guardando datos.
            Maquina 2 - Docker, CRIO, containerD
                MariaDB.... pero que pasa con los datos?
            Maquina 3 - Docker, CRIO, containerD
            ....
            Maquina N  - Docker, CRIO, containerD
        NECESITAMOS volumenes de almacenameinto externos accesibles por red.

Distribuciones de kubernetes:
- Minikube
- K8S
- Vanilla: K3S
- Openshift: Redhat


### Qué características tiene/requiere un entorno de producción que no tienen otros entornos?

- Alta disponibilidad: 
    Intentar asegurar que la app está en funcionamiento el tiempo contractualmente estipulado.
    La app debe funcionar un 90% del tiempo  ----  RUINA ... 36 dias al año la app sin funcionar            | €
    La app debe funcionar un 99% del tiempo  ----  BUENO ... 3.6 dias al año la app sin funcionar           | €€
            Pa' la peluquería de abajo me vale...                                                           | --- Replicación
    La app debe funcionar un 99,9% del tiempo  ----  BIEN ... 8 horas al año la app sin funcionar           | €€€€€€
    La app debe funcionar un 99,99% del tiempo  ----  QUE TE CAGAS ... minutos al año la app sin funcionar  | €€€€€€€€€€€€

- Escalabilidad
    Capacidad de adaptacion del entorno (infraestructura) a las necesidades de cada momento (que pueden aumentar o disminuir)   
    Escalamiento horizontal

Montar Clusters: Tener las cosas (maquinas, almacenamiento, programas, instalaciones, configuraciones) replicadas.
    Cluster Activo/Pasivo
    Cluster Activo/Activo: donde tengo muchas máquinas ofreciendo un mismo servicio
        Maquina 1 - App1    <   
        Maquina 2 - App1.   <
        Maquina 3 - App1    <             Balanceador de Carga <<<<                 clientes
        ....                                HAProxy, Proxy-reverso: Apache, NGINX
        Maquina N - App1.   <


## Modelos de evolución de uso de una app

### Modelo 1: App departamental
    dia 1.... 100 usuarios
    dia 100.   98 usuarios
    dia 1000. 104 usuarios

### Modelo 2: App Facebook
    dia 1.... 100 usuarios
    dia 100.  1000 usuarios
    dia 1000. 100000 usuarios

### Modelo 3: App INTERNET.... quien me resuelve estos escenarios: CLOUD: Alquilar entornos bajo demanda
    dia n.    100 usuarios
    dia n+1.  100000 usuarios           Black friday
    dia n+2.  300 usuarios
    dia n+3.  3000000 usuarios          Ciber Monday            




~~Como una máquina virtual pero mucho más pequeña.~~
~~Utiliza binarios del sistema donde ejecuto el contenedor.~~
Pueden ser efimeros. A efectos prácticos lo son y mucho.



Docker
Kubernetes
Openshift







NGINX

docker image pull
docker container create 

docker start
docker stop

docker run -d
    docker pull
    docker container create
    docker start 
    docker attach
    
$ docker container create --name mi-nginx nginx:latest


nic: Tarjeta de red física 
interfaz de red: Conexión lógica a una red 


loopback- 127.0.0.0/16.   Qué es esta red? Una red virtual que permite que 
                          procesos que están dentro de mi computadora hablen entre si
                          Formas de comunicar procesos:
                            sockets: Puertos de una red
                            uso de una zona de memoria compartida
                            a través de ficheros
                            pipes
    127.0.0.1 - localhost 
    There is no plece like 127.0.0.1 -> home

ethernet: red física

172.17.0.1/16
172.17.2.117

172.17.0.2



------------------------------------------------------------------ red amazon
| 172.31.2.231:8888 ------               | 172.31.5.113
OrdenaIvan               |           OrdenaLeo
    | 172.17.0.1         |
    |                    |
    |- Contenedor nginx  |
    |  172.17.0.2:80   <<|
    |
    | red docker
    
    
    
Cuando descargo una imagen de contenedor, qué ocurre?
Es un tar con carpetas... se descarga y se descomprime


HOST
/
/etc
/bin
/var
    /lib
        /docker 
            /containers 
                /mi-nginx.     ******** 
                    CAMBIOS
            /images
                ... se descomprime la imagen del contenedor
                    /nginx.    ********
                        /etc
                        /bin
                        /lib
                        /var
                        /home
                        /root
                        /opt
/home
/root
/opt

ls /

El Sistema de archivos de un contenedor se monta mediante la superposicion de capas:

CAPA N: Volumen.   -> Mapeao entre una carpeta del host y una carpeta del contenedor    
                        contenedor: /misdatos    ---->   host: /home/ubuntu/misdatos
CAPA 1: Contenedor -> /var/lib/docker/containers/mi-nginx
CAPA 0: Imagen ->     /var/lib/docker/images/nginx



Docker Inc.
- docker = docker-engine
    - demonio / servidor    dockerd > container.d > runc
                              ^^^
    - cliente               docker
- docker desktop for windows
- docker desktop for mac
- docker-compose. Es otro cliente de dockerd
- docker swarm ******

