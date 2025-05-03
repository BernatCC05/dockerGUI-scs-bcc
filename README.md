# Docker Ubuntu 24.04 GUI (XFCE + VNC + VSCode + Python + SSH)

# Comandes per crear la imatge

#/bin/bash
docker build -t docker-gui-scs-bcc .

# Comanda per crear el contenidor a partir de la imatge
sudo docker run -d -p 5901:5901 -p 2222:22 --name docker_gui_container docker-gui-scs-bcc
