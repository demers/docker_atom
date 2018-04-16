FROM ubuntu:17.10

MAINTAINER FND <fndemers@gmail.com>

ENV PROJECTNAME=ATOM

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
RUN /usr/bin/ssh-keygen -A

# Add user to the image
RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/${USERNAME} --gecos "User" ${USERNAME}
# Set password for the Ubuntu user (you may want to alter this).
RUN echo "$USERNAME:$PASSWORD" | chpasswd

RUN apt-get clean && apt-get -y update && apt-get install -y locales && locale-gen fr_CA.UTF-8
ENV TZ=America/Toronto
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt install -y fish

# Installation X11.
RUN apt install -y xauth libxss1

# Installation PHP
RUN apt install -y php

# Installation de Atom
RUN add-apt-repository -y ppa:webupd8team/atom \
    && apt update \
    && apt install -y atom

RUN echo "export PS1=\"\\e[0;31m $PROJECTNAME\\e[m \$PS1\"" >> ${WORKDIRECTORY}/.bash_profile

# Installation des plugins de
# https://scotch.io/bar-talk/best-of-atom-features-plugins-acting-like-sublime-text
# sauf pour vim-mode qui est remplacé par vim-mode-plus
ADD plugins.bash ${WORKDIRECTORY}
RUN chmod u+x ${WORKDIRECTORY}/plugins.bash
RUN chown $USERNAME ${WORKDIRECTORY}/plugins.bash
RUN echo "if [ -f plugins.bash ]; then" >> ${WORKDIRECTORY}/.bash_profile
RUN echo "./plugins.bash" >> ${WORKDIRECTORY}/.bash_profile
RUN echo "fi" >> ${WORKDIRECTORY}/.bash_profile

# Installation Python 3
RUN apt install -y git python3 python3-pip python3-mock python3-tk
# Mise à jour PIP
RUN pip3 install --upgrade pip
RUN pip3 install flake8
RUN pip3 install flake8-docstrings
RUN pip3 install pylint
ENV PYTHONIOENCODING=utf-8

WORKDIR ${WORKDIRECTORY}

RUN echo "export PYTHONPATH=." >> ${WORKDIRECTORY}/.bash_profile

RUN git clone https://github.com/pyenv/pyenv.git ${WORKDIRECTORY}/.pyenv
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ${WORKDIRECTORY}/.bash_profile
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ${WORKDIRECTORY}/.bash_profile
RUN echo 'eval "$(pyenv init -)"' >> ${WORKDIRECTORY}/.bash_profile

RUN cd ${WORKDIRECTORY} \
    && mkdir -p work \
    && chown -R $USERNAME work

# Standard SSH port
EXPOSE 22

# Start SSHD server...
CMD ["/usr/sbin/sshd", "-D"]

