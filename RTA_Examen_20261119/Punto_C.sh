#!/bin/bash
# PUNTO C - Docker
# Cornejo

cd "$HOME/UTN-FRA_SO_Examenes/202406/docker/"

# build de la imagen
sudo docker build -t web1-cornejo .

# PASO MANUAL para pushear:
# sudo docker login
# sudo docker tag web1-cornejo macornejo/web1-cornejo:latest
# sudo docker push macornejo/web1-cornejo:latest

# creo el run.sh
echo '#!/bin/bash' > run.sh
echo 'sudo docker run -d -p 8080:80 web1-cornejo' >> run.sh
chmod +x run.sh

# levanto el contenedor
sudo docker run -d -p 8080:80 web1-cornejo

# verifico
echo ""
sudo docker ps
sleep 2
curl -s localhost:8080

echo "punto C listo"
