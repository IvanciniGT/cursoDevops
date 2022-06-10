Cluster  Kubernetes | Openshift

    Dashboard   
    Cli:    kubectl | oc
    
Cluster tiene una dirección IP

## Objetos de Kubernetes

Namespace
Node
PV  PersistentVolume 
ServiceAccount
Role
RoleBinding
ClusterRole


Deployment, Replicaset, Statefulset, Daemonset
    Pods
        Secrets y Configmaps
        PVC Persistent Volume Claim
CronJobs
    Jobs
Service svc, Route , Ingress


### kubectl

$ kubectl VERBO TIPO_OBJETO <OTROS ARUMENTOS QUE SE REQUIERAN>

Argumentos : 
    -n, --namespace
    --all-namespaces
    
Verbos
    get
    describe         requiere un nombre de objeto
    delete
    exec
    logs
    scale
    
    
# Despliegue de Wordpress

StatefulSet MariaDB:
    Pod 1
        C1: MariaDB
            Volumen de Almacenamiento -> PVC 1
    Secret

Deployment Wordpress:
    Pod 2
        C2: Apache, nginx + Wordpress (php)
            Volumen de Almacenamiento -> PVC 2

Servicios:
    BBDD    ClusterIP
    Apache  ClusterIP

Ingress/Route

---

Pod Mariadb                             Balanceador                 Wordpress 1...4
Pod Mariadb

Pod Wordpress Apache + App              Balanceador                 Cliente A sube un fichero (imagen)
    Vol X
Pod Wordpress Apache + App                                          Cliente B
    Vol X
Pod Wordpress Apache + App. POF !
    Vol X
Pod Wordpress Apache + App
    Vol X

¿Cada pod, tiene su propio volumen de almacenamiento, o es compartido?
    Wordpress - Todos los wordpress usan el mismo volumen de almacenamiento
    BBDD- MariaDB - Cada MariaDB usa su propio volumen de almacenamiento

Pod MariaDB 1   A
    Vol 1
Pod MariaDB 2   A   C
    Vol 2
Pod MariaDB 3       B
    Vol 3
Pod MariaDB 4       B.  PUFFF !!!!
    Vol 4
Pod MariaDB 5       C
    Vol 5

LEVANTAR EL 4!!!!

BBDD Principal          <       BBDD Replicación.        +  BBDD Replicacion
                                                                    ^^
                                                                    BI
                                                                    
Fichero SO
10 personas a tocar el fichero a la vez > 
Primero: puede generar conflictos
Segundo: va a generar un cuello de botella. IO

Cada persona grabe un fichero distinto en una misma carpeta 


1 sola
A
B
C

1 primaria -> replicas
A                   A
B                   B
C                   C?

cluster -> cada componente tiene una parte de la infrmación no todo.
    
    Nodo 1      Nodo 2      Nodo 3.        < Balanceador de carga
    A           A
                B           B
    C                       C
    D           D
    
    
    CPU    RAM    100000  10
    
Oracle 35 horas.... 650 Volumenes 
    
    
Cluster ES
Data
Ingest
Coordination


Maquina 1
    MariaDB1
Maquina 2

Maquina 3
    MariaDB2

Maquina 4


Afinidad de Pods Requeridas / Preferidas
    Afinidad a nivel de Pod
    Afinidad a nivel de Nodo
    Antiafinidad a nivel de Pod