sudo apt install docker-compose -y

mkdir -p /home/ubuntu/environment/datos/jenkins
chmod 777 /home/ubuntu/environment/datos/jenkins
chmod 777 /home/ubuntu/environment/datos

cd /home/ubuntu/environment/curso/docker-compose
docker-compose -f jenkins.yaml up