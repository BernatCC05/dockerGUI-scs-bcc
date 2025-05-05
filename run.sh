#!/bin/bash

IMAGE_NAME=docker-scs-bcc
CONTAINER_NAME=container-docker-scs-bcc

# Comprova si la imatge existeix
docker image inspect $IMAGE_NAME > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "[INFO] La imatge no existeix. Es crea..."
  docker build -t $IMAGE_NAME .
else
  echo "[INFO] La imatge $IMAGE_NAME ja existeix. No es torna a crear."
fi

# Comprova si el contenidor ja existeix
docker ps -a --format '{{.Names}}' | grep -w $CONTAINER_NAME > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "[INFO] El contenidor ja existeix. S'atura i s'elimina..."
  docker stop $CONTAINER_NAME
  docker rm $CONTAINER_NAME
fi

# Executa el contenidor amb els ports necessaris (exemple amb VNC, SSH)
# Modifica els ports segons calgui
# Port VNC (5901)
# Port SSH redirigit (2222)
docker run -d -p 5901:5901 -p 2222:22 --name $CONTAINER_NAME $IMAGE_NAME
