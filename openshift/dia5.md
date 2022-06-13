# Kubernetes

Orquestador de gestores de contenedores, apto para su uso en entornos de producción:
- Escalabilidad
- Alta disponibilidad

Para ello necesitamos montar un cluster. El uso de un cluster de maquinas, aplicaciones(procesos), 
implica el uso de un balanceador de carga.

Para poder ir abriendo o moviendo aplicaciones de una máquina a otra, es necesario también:
Almacenamiento externo accesible por red.

# Objetos / Configuraciones en Kubernetes

## Pod 

Conjunto de contenedores, que:
- Comparten configuración de red (IP)
- Escalan juntos
- Pueden compartir almacenamiento no persistente
- Se despliegan en el mismo host

Los PODs están pensados para ejecutar : Servicios + Demonios

## Plantillas de pod:

### Deployment  **

Plantilla de pod + número de replicas (+petición de volumen persistente)

### StatefulSet **

Plantilla de pod + plantilla de peticiones de volumenes persistentes + número de replicas

Cada pod que se genera (en base a la plantilla de pod suministrada) crea su propia 
petición de volumen persistente (en base a la plantilla de peticion de volumen persistente)

Los pods creados desde un statefulset no comparte volumenes persistentes. Cada uno tiene su propio volumen persistente.
Esto es importante para: Bases de datos + Sistemas de mensajería + Indexadores

### DaemonSet

## Job

Para ejecutar Scrips o comandos: Copia de seguridad de mi BBDD

## Plantillas de Jobs

### CronJob

Plantilla de Job + Cron (Periodicidad)

## Configuraciones de Pods y Jobs

Quién rellena estos objetos/configuraciones/ficheros YAML? 
El adminsitrador

Alguien rellena los Deployments? 
El desarrollador


### ConfigMap

- Variables de entorno: Nombre de la bbdd que voy a crear
- Inyección de archivos: Archivo de configruación de la BBDD

### Secret

- Variables de entorno: Contraseña
- Inyección de archivos: Clave privada / Certificado

---

Al acceder a un cluster, mis despliegues los hago en un:

# Namespace / Project

Es un entorno aislado dentro del cluster:
- Autorización: Quién puede manejarlo / gestionarlo (Usuarios)
    - ServiceAccount
        Jenkins
            Pipelines:
                - Despliega esta app en kubernetes < Cuenta de servicio (ServiceAccount)
    - Role
    - Role-binding
- Limitar recursos HW: LimitRange y ResourceQuota
- Limitar acceso a servicios: NetworkPolicy

---
# Comunicaciones

## Service

### ClusterIP

Entrada en el DNS de kubernetes + IP de balanceo de carga

Servicios internos al cluster

### NodePort

ClusterIP + Redirección de puertos (a partir del 30000) a nivel de host (cada uno de los hosts de mi cluster)

Exposición de servicios.

En un cluster real NO tengo NodePort... que se coma kubernetes la conf. del balanceador externo

### LoadBalancer

NodePort + Configuración de un balanceador de carga externo (que yo tengo que tener instalado a priori)

Solo tendremos 1 en un cluster de producción: IngressController

IngressController: Proxy reverso que permite la entrada a los servicios del cluster desde el exterior

Cómo configuro ese IngressController? Mediante reglas INGRESS

En el caso de trabajar con Openshift, en lugar de Ingress, usamos el objeto: Route

---

# Almacenamiento

## Volumen persistente : Persistent Volume (pv)

Una referencia a un almacenamiento externo.

Quién crea estos objetos (referencias) en kubernetes?
- Administrador del cluster
- Provisionador dinámico de volumenes (Programa instalado por el adminsitardor del cluster)
    update, get, list, watch < pvc
    create, delete , update, get, list < pv

## Peticiones de volumen persistente (pvc)

Una solicitud de un espacio de almacenamiento.

Quién la hace?
- Desarrollo

Qué tipo de datos vienen en una pvc?
- Tamaño de almacenamiento (capacidad)
- Tipo de alamcenamiento:
    - Redundante
    - Rápido
    - Lento
---

# Sistemas de mensajería

Ejemplos: Kafka, ActiveMQ, RabbitMQ, Whatsapp

Qué aporta un sistema de mensajería? Asincronicidad -> Garantizar la entrega del mensaje. 

No necesito tener presentes a interlocutor y receptor en el mismo momento del tiempo para poder realizar la comunicación.

## Ejemplo:

### Pago con tarjeta

Emisor: Programa que corre dentro de un TPV (virtual o físico)
Receptor: Pasarela de pago del banco (programa < servicio web)

¿quiero que esa comunicación sea síncrona o asíncrona? Depende de lo que pague

Mercadona... lleno el carro ... y voy a la caja... y paso mi tarjeta por el tpv...
El tpv: Manda la solicitud de cobro a la pasarela de pago del banco... y espera respuesta.
Si la pasarela del banco no está disponible.... El pago no se hace... y mi carrito se queda en marcadona.
Ni de coña me dejan salir de la tienda sin haber transferido los boniatos a la cuenta del mercadona.
Qué tipo de comunicación: Síncrona

Peaje... Asíncrona... La mayor parte de los peajes no admiten tarjetas prepago.
Por qué esta comunicación es asíncrona.

Tengo 10 servidores de Kafka en paralelo: HA + escalabilidad
Si cada hombrecito(kafka) tiene que guardar TODOS los mensajes.

# A la hora de traajar con kubernetes u openshift, qué usamos?

Archivos de especificación YAML

# Dashboard

- Kubernetes tiene un dashboard oficial, que no se instala por defecto.
- Openshift vienen con su propio dashboard, más avanzado.

Para qué sirven en la práctica: Echar un ojo al estado del cluster. Para nada más.

## cli

- Kubernetes: kubectl
- Openshift: oc

## Necesitamos alguién que ejecute el cli por nosotros: Jenkins, Travis, AzureDevOps

PaquitaPC -> ProxyReverso -> PodWordpress
          ^                ^
          ^               tls: Esto debe ser suministrado por el POD Wordpress (servidor)
         tls: Esto debe ser suministrado por el ProxyReverso
          
Modelos:
    tls             no tls                  Edge
    tlsA            tlsB                    Re-encrypt
                                                A y B: Tengo 2 certificados y conjuntos de clave pública / privada
                    tls                     Passthrou
    no tls          tls.                    X No tiene sentido
        