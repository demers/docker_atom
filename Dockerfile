FROM ubuntu:17.10

MAINTAINER FND <fndemers@gmail.com>

# Access SSH login
ENV USERNAME=ubuntu
ENV PASSWORD=ubuntu


ENV WORKDIRECTORY /home/ubuntu

RUN apt-get update

RUN apt-get install -y vim-nox curl git software-properties-common

# Install a basic SSH server
RUN apt install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Add user to the image
RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/${USERNAME} --gecos "User" ${USERNAME}
# Set password for the Ubuntu user (you may want to alter this).
RUN echo "$USERNAME:$PASSWORD" | chpasswd

# Installation X11.
RUN apt install -y xauth libxss1

# Installation de Atom
RUN add-apt-repository -y ppa:webupd8team/atom \
    && apt update \
    && apt install -y atom

# Installation des plugins de
# https://scotch.io/bar-talk/best-of-atom-features-plugins-acting-like-sublime-text
# sauf pour vim-mode qui est remplacé par vim-mode-plus
ADD plugins.bash ${WORKDIRECTORY}
RUN chmod u+x ${WORKDIRECTORY}/plugins.bash
RUN chown $USERNAME ${WORKDIRECTORY}/plugins.bash
RUN echo "if [ -f plugins.bash ]; then" >> ${WORKDIRECTORY}/.bash_profile
RUN echo "./plugins.bash" >> ${WORKDIRECTORY}/.bash_profile
RUN echo "fi" >> ${WORKDIRECTORY}/.bash_profile

WORKDIR ${WORKDIRECTORY}

RUN cd ${WORKDIRECTORY} \
    && mkdir work \
    && chown -R $USERNAME work

# Standard SSH port
EXPOSE 22

# Start SSHD server...
CMD ["/usr/sbin/sshd", "-D"]

