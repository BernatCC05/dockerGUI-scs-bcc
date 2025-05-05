# Base: Ubuntu 24.04
FROM ubuntu:24.04

# Actualitzem el sistema i instal·lem paquets bàsics.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    xfce4 xfce4-goodies tightvncserver \
    openssh-server wget curl python3 python3-pip \
    software-properties-common dbus-x11 sudo \
    apt-transport-https gpg

# Crear usuari vncuser amb contrasenya vncuser
RUN useradd -m -s /bin/bash vncuser && echo "vncuser:vncuser" | chpasswd && \
    usermod -aG sudo vncuser

# Instal·lar VS Code (repositori oficial de Microsoft)
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt-get update && apt-get install -y code && \
    rm -f microsoft.gpg

# Després modifiquem l'Exec del fitxer .desktop
RUN sed -i 's|^Exec=.*|Exec=code --no-sandbox \&|' /usr/share/applications/code.desktop

# Configuració del VNC Server
USER vncuser
RUN mkdir -p /home/vncuser/.vnc && \
    echo "vncuser" | vncpasswd -f > /home/vncuser/.vnc/passwd && \
    chmod 600 /home/vncuser/.vnc/passwd && \
    echo '#!/bin/bash\nstartxfce4 &' > /home/vncuser/.vnc/xstartup && \
    chmod +x /home/vncuser/.vnc/xstartup

# Ports: 5901 (VNC), 22 (SSH)
EXPOSE 5901 22

# Torna a root per configurar el servei SSH
USER root
RUN mkdir /var/run/sshd

# Script d'inici
CMD /usr/sbin/sshd && sudo -u vncuser vncserver :1 -geometry 1280x800 -depth 24 && tail -f /dev/null
