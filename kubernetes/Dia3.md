# Kubernetes

## Creamos objetos de distinto tipo

Asi es como configuramos kubernetes. Esto se hace mediante ficheros YAML.
También se pueden crear algunos objetos mediante linea de comandos...
   NO SE HACE.
   
## Pod

Conjunto de contenedores que:
- Comparten red
- Pueden compartir almacenamiento
- Se despliegan en el mismo host
- Escalan juntos
 
Qué pasa con los contenedores de un pod? qué pueden ejecutar?
- Servicios 
- Demonios
- Y ya!

Porque si quiero ejecuatr un script o un comando, que necesito?
Dentro de un pod, crear InitContainers. Esos si pueden ejecutar scripts / comandos... 
De hecho es lo único que pueden ejecutar

## Plantillas de Pod

### Deployment

Plantilla de pod + número de replicas

### StatefulSet

Plantilla de pod + Plantilla de peticion de volumenes persistentes + número de replicas

### DaemonSet - que lo usamos poco

Plantilla de Pod (Kubernetes despliega un pod en cada host)

## Jobs

Son conjuntos de contenedores que ejecutan scripts / comandos

## CronJob

Plantilla de Job + cron (periodicidad)

## Secrets y Configmaps

- Seguridad
- Flexibilidad
- Mantenibilidad

Para cada puerto que abramos en una IP dentro del cluster...
Es decir, para cada servicio que ofrezca en el cluster, que necesito:

## Service

### ClusterIP

- Entrada en el DNS de Kubernetes
- IP de balanceo de carga
- Configuración autoamtizada de ese balanceo de carga

### NodePort

ClusterIP + Redirección de puertos de los hosts (con puertos mayores que el 30000) a IP de balanceo de carga del servicio
No creo ni uno en real... Por qué? Que se encarge Kubernetes de configurar el balanceador externo

### LoadBalancer

NodePort + configuración automática de un balanceador de carga externo
Tendré solo 1: El servicio del IngressController: Proxy reverso que es la única puerta de entrada al cluster

## Ingress
    
Regla de acceso en el proxy reverso IngressController
Es una forma estandarizada de configurar proxies reversos... Da igual el proxy reverso que se esté utilizando. 
Todos se configuran con la misma sintaxis: nginx, envoy, haproxy, apache

## Volumenes persistentes
## Peticiones de Volumenes persistentes




                                        Red de mi empresa 
Cluster                                         |
|                                               |
|    Maquina 1 ---------------------------------|- PaquitaPC
|           30080 -> Balanceador de carga       |   http://app1.miempresa.es
|                       del IngressController   |   http://app2.miempresa.es
|------  App web 2                              |
|    Maquina 2 ---------------------------------|
|------  App web 1                              |- Balanceador de carga -> IP de uno de mis nodos... en un puerto > 30000
|    Maquina N ---------------------------------|
|------  IngressController - Nginx              |- DNS
            Ingress: app1.miempresa.es ->       |    app1.miempresa.es -> IP balanceador externo
                     balanceador interno.            app2.miempresa.es -> IP balanceador externo
                        del app1
            Ingress: app2.miempresa.es -> balanceador interno de la app2



netFilter : Esto es un programa (Módulo) que existe en el kernel de Linux

Firewall de una maquina linux:
    iptables -> netFilter
    
## Istio

App monoliticas -> Arquitecturas de servicios/microservicios

Sistema cuya funcionalidad se consigue mediante la comunicación de montonoes de servicios

Service mess -> Service mesh

Man in the middle < Esto se usa normalmente con fines maliginciosismos
Nosotros lo usamos a buenas


Pod                                     Pod
    tomcat                                  mariadb
        servicio web
        V^ localhost                          ^V
    proxy(envoy). --------https--------->   proxy (envoy)

http(s)
- Man in the middle
- Suplantación de identidad

Claves publica/privada
Certificado - Entidad Certificadora de Confianza



Deployment                               -> ReplicaSet
Plantilla + numero de replcias              Programa dentro de Kubernetes que se encarga de asegurarnos que en todo momento
                                            el numero de replicas que tengo = numero de replicas que deseo
Statefulset


---

# Volumenes en Kubernetes

Qué es un volumen? Un sitio donde puedo dejar datos / ficheros

En Kubernetes tenemos 2 tipos de volumenes:
- No persistentes
    Comunicación entre contenedores
    Tipos:
        Sistema de archivos del Host (equivalente a lo que habeis heho en docker)
        En memoria RAM -> Incremento brutal del rendimiento
- Persistentes
    Persistencia de datos
        A diferencia de docker, en kubernetes trabajamos en un entorno de HA.
        Lo que requiere de volumenes externos, accesibles por RED.

Quién crea los archivos de manifiesto YAML? 
    Desarrollo... todos? No.
    Deployment? Desarrollo
    StatefulSet, CronJob, Ingress, Service
    ConfigMap|Secrets... quién los crea?
        Quien configura la contraseña de la base de datos del entorno de producción?
            Administración de sistemas
    
    Aquí tenemos 2 gorros: Desarrollo (clientes que quieren desplegar sus apps)
                           Administración del cluster
    
    Desarrollo:
        MariaDB - Statefulset
            Necesito un volumen persistente: < Peticiones de Volumenes persistentes
                Una determinada cantidad de espacio de almacenamiento
                Lo quiero rapidito
                          lentito
                          Redundante
            ¿Tengo idea de donde se van a guardar los datos en realidad? No, ni idea
                AWS EC2, Cabina de almacenamiento
    
    Administrador
        Tiene que configurar dentro del cluster de kubernetes el soporte real de ese volumen...
        Kubernetes: 
            En AWS EBS-> Volumen con 200Gb disponible... Las credenciales para acceder son estas
    
# PVC Persistent Volume Claim - Desarrollo
# PV  Persistent Volume       - Administración

## ResourceQuota
## LimitRanges


Statefulset   >    Plantilla de Pod  >  Pods --------------------------------> PV23   --------> AWS o cabina | ceph
Deployment         los pods que se                                              ^                    200 Gbs
                    creen desde esta                                            |                    rapiditos y redundantes
                    plantila deben usar                                         |
                    el volumen asociado                                         |
                    a la peticion de volumn 17                                  |
                                                                                |
Peticion de volumen 17                                                          |
PVC ------------------------------------ Kubernetes------------------------------
    100 Gbs
    rapiditos y redundantes
            
            

                        
Plantilla Pod 17.   POD 82534.     >    PVC 23.   <>    PV 65.      > Aws


A la hora de crear los PV, teenmos 2 opciones:
- Los administradores crean un montón de PVs y los configuran en Kubernetes (Pool de PVs)..... No solemos trabajar asi
- Los administardores pueden instalar y configurar dentro del cluster un provisionador dinamico de volumenes persistentes.


Cuando monto un cluster de Kubernetes:
    On Premisses... Yo pongo las máquinas y la instalación y configuración
    Cloud

# Openshift 

Es una distribución de Kubernetes
Con algunos añadidos de Redhat
    + dashboard
    + cli
    + crds

# Redhat Inc.

En favor del software Opensource
No cobra licencias por sus productos. Cobra subscripciones + soporte

RHEL                                <       Fedora
JBoss                               <       Wildfly
Redhat Ceph                         <       Ceph
Openshift Container Platform        <       Openshift origin OKD
Redhat OpenStack
Ansible
Ansible Tower 

# Namespace Kubernetes = Project Openshift

Es un entorno aislado lógico dentro del cluster
 - Multiples clientes
 - Multiples proyectos
 - Multiples entornos

namespace: appX
namespace: entorno-desarrollo
namespace: entorno-desarrollo-appX

Cuando creemos usuarios, éstos tendrán acceso solo a ciertos namespaces
Limitar los recursos hardware que se asocian a un namespace.



## Affinities | Taints | Tolerations

Esto tiene que ver con el nodo en el que se va a ajecutar el pod.