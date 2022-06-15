# Ansible

## Ecosistema ansible

### Ansible Project > Ansible Engine

Crear y ejecutar playbooks

Ansible es una herramienta de:
- gestión de configuraciones
- aprovisionamiento 
- implementación de aplicaciones.

Automatizar el ESTADO de mi infraestructura.

### Ansible AWX > Ansible Tower

Orquestador web de playbooks

### Ansible galaxy

Repo de roles de ansible

## Otras herramientas equivalentes: Puppet, Chef


## Playbook de Ansible

Definir un conjunto de estados / tareas que quiero conseguir en un conjunto de entornos

Es el equivalente a un script.

El lenguaje que usaremos será YAML.

Estos playbooks los querremos ejecutar / aplicar sobre un montón de computadores (entornos remotos)

# Ficheros de inventario

El conjunto de entornos remotos donde ejecutaremos unos playbooks reibe el nombre de INVENTARIO

# Nodo de control

Entorno en el que tenemos instalado ANSIBLE

Desde este entorno ejecutamos los playbooks contra otros entornos.

DEBE SER UN NODO LINUX

# Nosos gestionados

Entornos a los que aplicamos playbooks.

Ansible no requiere ningún software propio en los nodos gestionados.

Ansible, ejecutandose en el nodo de control, se contectará a los nodos gestionados, mediante:
- ssh (Unix/Linux)
- wrm (Windows)

Ansible requiere que los nodos gestionados tengan instalado python

# Módulo de Ansible:

Un programa dentro de ansible que se encarga de ejecutar una tarea concreta o conseguir un estado concreto.

cualquier cosa que quiera hacer con Ansible la realizo a través de un módulo.
Literalmente en Ansible tenemos miles de modulos.

---

# ejemplo 1

Me llega un servidor nuevo físico
- SO
- Configurarlo
- Usuarios, claves
- Red
- Instalar básicos
- Instalar otros programas

Scripts.     .sh
    Problemas al usar scripts:
    - El script de windows funciona en linux? o al revés? NO
    - Paradigma (Lenguaje): Imperativos
    
---

Lenguaje declarativo:
    Servidor1:
        Usuarios: Ivan
        Grupos: Administradores
        Contraseña: password

SCRIPT: Lenguaje imperativo
    SI no hay un usuario ivan:
        Crea usuario: Ivan
    SI no está asignado ivan al grupo de administradores:
        Asigna el usuario Ivan al Grupo: Administradores
    Si ivan está asignado a otros grupos, quitalos
    
    Pon como contraseña: password


---

IDEMPOTENCIA: Independientemente del estado inicial, al ejecutar un playbook,
              siempre debemos alcanzar el mismo estado

# Estados en los que puede acabar una tarea
- ok:           La tarea ha acabado sin problemas
- changed:      La tarea ha provocado un cambio en el entorno
- unreachable
- failed:       La tarea ha terminado con error
- skipped:      La tarea se ha saltado por no cumplirse las condiciones 
-               necesarias para su ejecución
- rescued
- ignored:      La tarea acaba con error, pero el error se ignora

---
SELinux - modulo instala al nivel del kernel de Linux
Viene de serie con Redhat Enterprise Linux