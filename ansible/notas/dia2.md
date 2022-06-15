# Ansible

## Ansible project < Ansible engine

Realizar aprovisionamiento de infraestructura: Configuraciones, Instalaciones... en entornos remotos.

Ejecutar Playbooks contra un Inventario

## Ansible AWX     < Ansible Tower

- Orquestar playbooks
      Ejecuta el playbook 1
        Despues el 2
            Si falla el 3
            Si no falla el 4
- Programar en el tiempo la ejecución de playbooks < Jenkins


## Ansible Galaxy

Repositorio de Roles de ansible

---

# Playbook

Fichero YAML:

```yaml

- hosts:
  
  vars:
  gather_facts:
  
  pre_tasks:  [tareas]
  tasks:      [tareas]
  post_tasks: [tareas]
  handlers:   [tareas]
```

Tarea:

Estados:
- OK
- CHANGED
- SKIPPED
- FAILED

```yaml

name: 
modulo: debug, apt, yum, shell, ... + 1000 modulos
notify: Activa un handler cuando la tarea acaba con estado CHANGED
changed_when:    Expresión lógica
failed_when:     Expresión lógica. 
                 Por defecto, una tarea se considera fallida si acaba con un 
                 codigo de salida distinto de cero.
when:            Ejecutar o no una tarea basada en una condición
register:        Guardar los datos de salida de una tarea en una variable 
vars:

```

Cuando usamos un register, el resultado de la tarea se guarda en una variable.
Cada módulo tiene sus propios datos de salida.
Pero independientemente del tipo de modulo utilizado, siempre podemos preguntar:
--------------------------------------------------------------------------------

- register_tarea is failed
- register_tarea is succeded
- register_tarea is skipped
- register_tarea is changed

Adicionalmente, sobre cualquier variable podemos preguntar:

- mivariable is defined
- mivariable is undefined