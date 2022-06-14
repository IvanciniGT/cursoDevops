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

---

# Qué ocurre cuando se carga en Kubernetes/Openshift un POD?

YAML < Los escribirá Kubernetes (en base a una plantilla que suministramos)

1- Se asigna ese pod a un nodo (scheduller)
2- Se establece comunicación con el kubelet
3- El kubelet del nodo pertinente se encarga de solicitar al gestor de nodos (container.d, crio):
    - Descarga la imagen
    - Crea el contenedor(es)
    - Arrancalo(s)

En base a qué criterio(s) se asigna un pod a un nodo?
- A la carga que tenga un nodo en un momento dado ¿? A kubernetes no le importan casi nada.
- Los compromisos que tenga un nodo - REQUESTS
- Reglas de afinidad
- Reglas de toleraciones

---

# Limitación/Asignación de recursos HW a nuestros pods

---

# Asignación de pods a nodos


Nodo 1
    CPU: 90% 4 cores
    RAM: 16 Gbs -> 14,5 Gbs
Nodo 2
    CPU: 10% 4 cores
    RAM: 16 Gbs -> 2 Gbs
    
Hay que soltar un pod que:
    Precisa 2 cores
    Y 5 Gbs de RAM

---
                        REQUESTS                    AVAILABLE                   USAGE
Nodo 1              16 Gbs          8 cores         RAM         CPU           RAM           CPU 
    PodA             4              2               12          6               2           1
    PodB             6              2               6           4               2           2
    PodB(2)          6              2               0           2               2           1
        
Nodo 2               8 Gbs          4 cores
    PodA(2)          4              2               4           2               7           3->2
    PodA(3)          4              2               0           0               4           2

    Con respecto a la CPU... Le cierro el grifo al PodA(2)
    LINUX: Es un SO de tiempo campartido.
                    1 core
    Tarea A         .....     .....               ......
    Tarea B              .....     ...............      .....................
    
    PodA(2) ... por las buenas... Anda... apagate, que te voy a reiniciar para que liberes memoria.
        kill SIGTERM
    PodA(2) ... por las malas... Te apagué, que te voy a reiniciar para que liberes memoria.
        kill SIGKILL
    
    Esto es muy peligroso. Deberíamos tratar de evitar estas situaciones.
    Las buenas prácticas:
        LIMIT RAM = REQUEST RAM
        Hay algún problema con la CPU?, con que  LIMIT CPU != REQUEST CPU? NO... esto no da problemas
            Me pueden dejar la app más lenta
    


Pod A       limits                                  REQUESTs (valores garantizados)
            Máximo que puede llegar a consumir      Mínimo que necesita
    CPU         4                                       2
    RAM         8                                       4

Otro Pod A
Otro Pod A

Pod B       limits                                  REQUESTs (valores garantizados)
            Máximo que puede llegar a consumir      Mínimo que necesita
    CPU         4                                       2
    RAM         6                                       6
    
Otro PodB


Requests o limits:
    memory: 300Mi = 1024x1024 bytes
        Mebibytes
    storage: 10Gi
        Gibibytes
        Kibibyte
        
    1 bit < 8 bits = 1 byte
    
    1Kb = 1000 bytes                        1 kib = 1ki = 1024 bytes
    1Mb = 1000 Kb = 1000000 bytes           1 Mib = 1Mi = 1024 kb
    1Gb = 1000 Mb = 1000000000 bytes        1 Gib = 1Gi = 1024 mb
    
    
    cpu: 1500m
        milicores
        
        Dejame usar el equivalente a 1,5 cores (1 core y medio al 100%)
        
        Core 1
                100%        50%         50%
        Core 2
                 50%        50%         25%
        Core 3              
                            50%         25%
        Core 4
                                        50%
    
La decisión entre escalado horizontal y vertical viene dado por el uso de RAM de pod.

Usos de la RAM por parte de un software: 

- Memoria de trabajo: Datos que se van calculando/obteniendo: VARIABLES
- Cache
- Usos varios: Stack de llamadas, código: POCO. No me preocupa.

Una app 1: Gestion de expedientes: Tramitaciones de una compañía de seguros (Parte)
    Si tienen 16Gbs de RAM
    Nodo1 (50% cache)
    Nodo2 (50% cache)                    BC           EXP-2021-0087 (50 operaciones)
    Nodo3 (50% cache)

    90-80% de la cache está duplicada
    Cuanta RAM tengo disponible para datos reales/trabajo:  3 x 8 = 24 Gbs
    
    Si en lugar de 3 maquinas tuviera 1 con 48 Gbs de RAM:
    Cuanto estaría ocupando su cache? 10Gbs -> 38 Gbs para datos

BBDD < Partes 2018 2019 2020 2021 2022.... 90% - 2022 < PERSISTENCIA

---        
## Afinidades

Tienen que ver con los posibles nodos en los que un pod puede ser desplegado.   DESARROLLADOR
- Montame en un equipo con GPU
- Montame en un equipo con tal arquitectura de microprocesador
- No quiero que me pongan en una maquina donde ya haya otro pod:
    - igual que yo
    - de tal tipo

### Node affinity
    Ponme en nodos que tengan ( que no tengan, que el valor asociado a la ertiqueta sea mayor que...)
                            una etiqueta
                            
    Ponme en un nodo con etiqueta: GPU=3090
    Ponme en un nodo cuya etiqueta velicidad_disco>800
    
### Pod affinity
    Ponme en nodos que contengan pods que tengan una etiqueta


### Pod Antiaffinity
    No me pongas en nodos que contengan pods que tengan una etiqueta





Como desarrollo, o dueño de la app... por qué querria yo establecer limitaciones acerca de donde se debe ejecutar un pod?

Y si mi app require euna GPU, todos los nodos del cluster van a tener GPU?
    Machine Learning, Data Mining, Servicio de detección de caras aeropuerto
    
    50 maquinas en el cluster. Todas llevan gpu ? Quizas 6


---
Dentro de un POD: 
    affinity: 
        podAffinity:    *********
            requiredDuringSchedulingIgnoredDuringExecution:
                - labelSelector:
                    matchExpressions:
                        - key: app
                          operator: NotIn               # In NotIn Exists DoesNotExist Gt Lt ***
                          values: 
                            - nginx
                  topologyKey: kubernetes.io/hostname
- Montame este pod en un nodo que ya tenga un pod con etiqueta app que no sea nginx.
---
Dentro de un POD: 
    affinity:
        podAntiAffinity: *********
            requiredDuringSchedulingIgnoredDuringExecution:
                - labelSelector:
                    matchExpressions:
                        - key: app
                          operator: In               # In NotIn Exists DoesNotExist Gt Lt *****
                          values: 
                            - nginx
                  topologyKey: kubernetes.io/hostname

- Montame este pod en un nodo que no tenga un pod con etiqueta app con valor nginx.

                        AFINIDAD    ANTIAFINIDAD
Nodo 1
                            NO          SI
Nodo 2
    Pod(app=nginx)          NO          NO
Nodo 3
    Pod(app=mysql)          SI          SI
Nodo 4
    Pod(app=nginx)                      NO         
    Pod(app=mysql)          SI          
    

## Taints & Tolerations

Tienen que ver con los posibles pods que pueden ser desplegados en un Nodo.     ADMINISTRADOR

Yo como administrador quiero limitar los pods que se pueden instalar en un nodo...
porque quiero dejar ese nodo para ciertos trabajos.


Nodo 1
    gpu
Nodo 2
    gpu
Nodo 3  
    no-gpu
    
    
Desarrollador: Pod1 (app1) si gpu -> Nodo 1, Nodo 2
Administrador: En el Nodo1, solo se montan ciertos PODS... no cualquiera 

Los administradores pueden poner un tinte (taint) a un nodo
Para que un pod se pueda instalar en ese nodo, el pod debe tener una tolerancia al tinte.

No se usan mucho, más que para:
    - Evacuar los pods de un nodo: Operaciones de mantenimiento del cluster
    