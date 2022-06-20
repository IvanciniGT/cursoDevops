Partiendo de mi proyecto:

Os creais vuestro propio proyecto, copiado del mio :
- la carpeta ansible
- Quiero que creeis una imagen de contenedor con Ansible instalado
- Para probarlo, que pongais un docker-compose, que asegure que podeis trabajar.
- Ejecuteis dentro del contenedor el playbook de nginx, con un inventario local : localhost
- Lo subis a un repo de git que os creeis en github
...


Crear una imagen de contenedor con ANSIBLE      -->  Dockerfile
Crear y correr un contenedor.                   --> docker-compose.yaml
Ejecutar un playbook en el contenedor           --> docker exec ---> ansible-playbook

Ese playbook, como se conecta con nuestro entorno remoto.  --> inventario --> ssh
Para conectar por ssh que necesito? 
- host >>>>>>>>>>>> el host se debe verificar su autenticidad
        -> Una huella - key host
        Cuando nos conectamos la primera vez por ssh, se nos pregunta, estás seguro... 
            ese host no está registrado como host de confianza...
        Al automatizar el proceso, no nos pregunta... Nos dice que ni de coña nos conecta con un entorno no registrado
        ¿ Que necesitamos? Registrarlo: Generar esa huella y darla de alta... donde? 
        En el entorno desde el que queremos conectar por ssh. Cual es? contenedor ansible-test2
        
        Quién nos interesa que lo haga? playbook


- private key <---> public key --> Dentro del entorno remoto (la puso ahi terraform, a través de amazon)
