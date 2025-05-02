FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    xfce4 xfce4-goodies tightvncserver \
    python3 python3-pip \
    openssh-server wget curl \
    sudo dbus-x11 \
    && apt clean

# Instal·lar VSCode
RUN curl -fsSL https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 -o vscode.deb \
    && apt install -y ./vscode.deb \
    && rm vscode.deb

# Crear usuari per accedir-hi
RUN useradd -m dockeruser && echo "dockeruser:dockerpass" | chpasswd && adduser dockeruser sudo

# Configuració de SSH
RUN mkdir /var/run/sshd

# Configuració VNC per usuari dockeruser
USER dockeruser
RUN mkdir -p /home/dockeruser/.vnc \
    && echo "dockerpass" | vncpasswd -f > /home/dockeruser/.vnc/passwd \
    && chmod 600 /home/dockeruser/.vnc/passwd

RUN echo '#!/bin/bash\nstartxfce4 &' > /home/dockeruser/.vnc/xstartup && chmod +x /home/dockeruser/.vnc/xstartup

USER root
EXPOSE 5901 22

CMD ["/bin/bash", "-c", "/usr/bin/vncserver :1 -geometry 1280x800 -depth 24 && /usr/sbin/sshd -D"]
