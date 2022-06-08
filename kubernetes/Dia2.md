# Kubernetes

Orquestador de Contenedores
Orquestador de Gestores de contenedores

Kubernetes controla los gestores de contenedores (docker... crio... podman...) 
que tenga instalados en un conjunto de máquinas...
Además, me ofrece funcionalidad (balanceo, almacenamiento) para conseguir un entorno con:
- alta disponibilidad
- escalabilidad

------------------------------------------------------

A kubernetes le vamos dando instrucciones acerca de como configurar nuestro entorno de producción.
Esas configuraciones se las damos mediante archivos YAML.

# Qué tipos de cosas puedo configurar en kubernetes?

## POD

Un pod es un conjunto de contenedores que?
- Comparten configuración de red... y por tanto IP.... 
  y pueden hablar entre si utilizando la palabrita: localhost
- Se despliegan en el mismo host
- Escalan conjuntamente
- Pueden compartir almacenamiento

App web:
    Servidor web
        -> log accesos
        -> log errores
    Filebeat
    Base de datos


Cómo los monto en kubernetes? 
    Cúantos contenedores quiero? 3
        REGLA DE ORO... a recordar: SIEMPRE PONGO CADA SOFTWARE EN UN CONTENEDOR
            C1: Filebeat
            C2: Servidor web - nginx
            C3: Base datos
    Cómo los distribuyo en pods? Cuántos pods creo y que pongo en cada uno?
        POD 1: 
            C1: Filebeat
            C2: Servidor web - nginx
        POD 2: 
            C3: Base datos

Un pod lo creo mediante un fiuchero YAML.

¿Cuantos pods configuramos dentro de kubernetes? CERO : NINGUNO
    Yo no voy a crear ni un solo pod en kubernetes... 
    Puedo? claro.. lo hare? a riesgo de que me corten las uñas muy cortas y me las metan en limón
    
    Quién va a crear pods? Kubernetes

¿Que creamos nosotros? Plantillas de Pods

## Deployment

plantilla de pod + Número de replicas... Kubernetes: BUSCATE LA VIDA!!!!

## StatefulSet

plantilla de pod + plantilla de peticion de volumenes persistente + Número de replicas

## DaemonSet

plantilla de pod < No digo ni numero de replicas... por qué? 
Kubernetes me monta un pod según la plantilla en cada nodo del cluster

## Secret / ConfigMaps
- Suministrar valores a las variables de entorno de los contenedores de los pods
- Inyectar ficheros a los contenedores de los pods

## JOBs 

Un Job es como un pod... cuyos contenedores ejecutan scripts o comandos

¿Cuantos Jobs creeis que vamos a definir en Kubernetes? NINGUNO

Vamos a definir plantillas de Jobs...

# CronJob

Plantilla de Job + Periodicidad

## Service

### Servicio de tipo ClusterIP.. el por defecto... Solo sirve para comunicaciones internas en el cluster

    Nombre de DNS + IP -> Balanceo de carga + Configurar el balanceador 
    para que apunte a los pods que hay detrás ofreciendo el servicio

### Servicio de tipo NodePort

    Es un servicio ClusterIP + Redirección de puertos en los hosts (TODOS)
        Puertos por encima del 30000 

### Servicio de tipo LoadBalancer

    Es un servicio NodePort + Configuración automática del Balanceador de carga externo
    en el caso de una instalación on premisses, debo instalar un Balanceado compatible con Kubernetes
    El proyecto oficial de kubernetes para este balanceador externo se llama:  MetalLB

## Ingress

Es una regla de entrada (virtual host de apache) en nuestro proxy reverso (ingress-controller).
---

## Volumenes persistentes
## Peticiones de Volumenes persistentes

## Network Policy

---

Crear un deployment con un determinado numero de replicias de una app
    nginx - 2 replicas
    mariadb - 1 replica

---

Cluster de Kubernetes:


|(red de mi empresa)
|
||(red virtual que necesita kubernetes)
||=192.168.1.1- Maquina 1
||            :32080 -> app-web:8080 (equivalente a la redirección de docker)
||                   Pod1-nginx
||------------------ 10.10.0.101:80
||                      BBDD que usa la app: bbdd.app.es:3306
||
||=192.168.1.2- Maquina 2
||            :32080 -> app-web:8080 (equivalente a la redirección de docker)
||                   Pod2-nginx
||------------------ 10.10.0.102:80
||                      BBDD que usa la app: bbdd.app.es:3306
||
||=192.168.1.3- Maquina 3 
||            :32080 -> app-web:8080 (equivalente a la redirección de docker)
||                   Pod1-mariab
||------------------ 10.10.0.100:3306 - Caja 44
||                   Pod1-proxyreverso - nginx < Este proxy reverso es el UNICO SERVICIO QUE VOY A EXPORTAR HACIA FUERA
||------------------ 10.10.0.110:80 
||                          miapp.produccion.es -> app-web:8080 < Ingress
||
||=192.168.1.4- Maquina 4
||            :32080 -> app-web:8080 (equivalente a la redirección de docker)
||                   Pod1-mariab(otro, igual... pero otro) - Caja 37
||------------------ 10.10.0.105:3306
||
||=192.168.1.5- Maquina N
||            :32080 -> app-web:8080 (equivalente a la redirección de docker)
||                   Pod DNS            bbdd.app.es -> 10.10.1.100 - Planta 1
||------------------ 10.10.0.200        CAJAS
||                                      app-web-> 10.10.1.101 (servicio de balanceo de nginx)            
|   
|
|-192.168.1.100- Balanceador de carga : 80. Los Cloud Publicos: AWS, Azure, GCP
|               Me "regalan" (previo paso por caja) este balancdeador de carga
|           http://192.168.1.1:32080
|           http://192.168.1.2:32080
|           http://192.168.1.3:32080
|           http://192.168.1.4:32080
|           http://192.168.1.5:32080
|
|-Servidor de DNS 
|   miapp.produccion.es -> 192.168.1.100 Este ya me lo curro yo.. kubernetes no hace nada de esto
|
|-192.168.1.244- Ordena-Paquita
|       Puede acceder ya paquita al nginx...? SI... con que datos?
|           http://miapp.produccion.es:80
|       Esto está bien? Estoy a gustito? NO:
|           - Estoy usando una IP...Eso no me mola
|           - El puerto está raro...

Balanceador de carga mariadb - Tiene su propia IP en la red Virtual: 10.10.1.100
    Cuando reciba una petición en el puerto 8306 - 10.10.0.100:3306
                                                 - 10.10.0.105:3306

Balanceador de carga nginx - Tiene su propia IP en la red Virtual: 10.10.1.101
    Cuando reciba una petición en el puerto 8080 - 10.10.0.101:80
                                                 - 10.10.0.102:80



Cuando trabajo en cluster, necesito un balanceador de carga:
Un programa que al recibir una petición la pasa alguien que la atienda... elegido de un pool









De una red virtual que crea kubernetes.... Igual a la de docker? Ni parecida: VLAN

Control-plane: Kubernetes
    El control plane se instala en los masterS... 
    Ni de coña en un cluster de producción voy a tener un solo master
    El conjunto de todos los programa que conforman Kubernetes:
        - api-server
        - kube-proxy
        - etcd              -- BBDD de kubernetes
        - coreDNS           -- un servidor de DNS
        - kube-scheduller
        - kube-manager
        
        
Pregunta 1:
    Para que sirven los servicios:
        ClusterIP:      Comunicaciones internas dentro del cluster. Servicios internos al cluster
        NodePort:       Exponer servicios del cluster al exterior
        LoadBalancer:   Exponer servicios del cluster al exterior
                        + configuración automática del balanceador externo

Pregunta 2:
    Que porcentaje de servicios de cada tipo pensais que tendrmos en un cluster real de producción:
        ClusterIP:          60%   33%                   TODOS menos 1
        NodePort:           30%   33%                   0              
                                                    Pa' que? Que se coma Kubernetes el marrón 
                                                    de configurar el balanceador externo.. 
                                                    Yo paso!
        LoadBalancer:       10%   33%                   1
                            
                           
    red empresa                     Internet    red de un fulano
 -----------------[Proxy]---------XXXXXXXXXXX---------------------
Maquina 1         reverso                            FulanitoPC
 App1 Web                                              Petri
 
                  haproxy       |
                  apache httpd   > IngressController 
                  nginx         |
                  
En mi cluster de Kubernetes necesito un INGRESS CONTROLLER, que básicamente es un proxy reverso
que se lleva los palos.
Necesitaré configurar (dar reglas) ese proxy reverso... para que la gente pueda acceder a mi app1
o a la app2, o a la app3.
    Necesito que cuando al proxy reverso se le ataque usando un determinado nombre:
        Se redirija aquello al balanceador de carga interno que ofrece un servicio: nginx


Apache httpd:
    VirtualHost
    
DNS:
sitio1 > 8.10.9.12
sitio2 > 8.10.9.12
    
http://sitio1:80/libros/libro1.html   
http://sitio2:80/libros/libro1.html   

sitio1:
    http://app1:3609/(LO QUE TE PONGAN)  Proxy reverso

sitio2:
    /var/html/app2 = DOCUMENT ROOT
    /var/html/app2/libros/libro1.html

---

Paquita... que estoy en la red de la empresa.... 
y quiero acceder a una app web que está dentro de un cluster de kubernetes

1- Qué pongo en el navegador?
    http://miapp.produccion.es  ->  Se resuelve este nombre a través de un DNS externo al cluster
                                    Ese nombre da lugar a una IP -> 
2- Balanceador de carga externo al cluster
    Mandamos a paquita a uno de los nodos del cluster, a través de su IP publica
3- Acabo de llegar a uno de los nodo cluster
    La llevamos al balanceador de carga interno del servicio INGRESS-CONTROLLER
                   Service NodePort|LoadBalancer(que tamb monta el adm. del cluster)
4- Estoy en el balanceador de carga interno del servicio INGRESS CONTROLLER
    La llevamos al POD del ingress-controller (proxy reverso) | Deployment (lo ha hecho el adm del cluster)
5- Estoy dentro del proxy reverso...
    Según la regla INGRESS se la lleva a un balanceador de carga interno del servicio de la app
             Ingress                        Service
6- Estoy dentro del balanceador de carrga interno de la app
    La llevamos al POD de la app < Deployment | StatefulSet
    
    
    
Programación: Paradigmas de programación
    Imperativo
    Procedural
    Funcional
    Orientado a objetos
    ------------
    Declarativo
    
        Imperativo: Pon la silla debajo de la ventana. Script 
        Declarativo: La silla debe estar debajo de la ventana ****
                        Kubernetes | Ansible
                        
                        En esa maquina tiene que estar nginx version 1.21.1
                        
                        Instala en esa maquina nginx version 1.21.1
                        Y si ya está instalado? Entonces no < condicional: IF
                        Y si hay una versión más vieja, la quitas primero
                        Bueno... que si hay una más nueva también la quitas