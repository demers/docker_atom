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

# Installation de Atom
#RUN cd /tmp \
    #&& wget https://atom.io/download/deb -O atom.deb \
    #&& dpkg -i atom.deb

RUN apt install -y xauth libxss1

RUN add-apt-repository -y ppa:webupd8team/atom \
    && apt update \
    && apt install -y atom

#RUN apm install atom-autocomplete-php \
    #&& apm install auto-update-packages \
    #&& apm install autocomplete-modules \
    #&& apm install autocomplete-nunjucks \
    #&& apm install color-picker \
    #&& apm install config-import-export \
    #&& apm install custom-title \
    #&& apm install docblockr \
    #&& apm install editor-stats \
    #&& apm install editorconfig \
    #&& apm install emmet \
    #&& apm install file-icons \
    #&& apm install git-plus \
    #&& apm install highlight-line \
    #&& apm install highlight-selected \
    #&& apm install improved-chester-atom-syntax \
    #&& apm install language-babel \
    #&& apm install language-nunjucks \
    #&& apm install linter \
    #&& apm install linter-eslint \
    #&& apm install merge-conflicts \
    #&& apm install monokai \
    #&& apm install opened-files \
    #&& apm install pigments \
    #&& apm install project-manager \
    #&& apm install project-quick-open \
    #&& apm install react \
    #&& apm install simple-drag-drop-text \
    #&& apm install sort-lines \
    #&& apm install tabs-to-spaces \
    #&& apm install tree-view-autoresize \
    #&& apm install tree-view-git-status \
    #&& apm install vim-mode-plus \
    #&& apm install wakati

# Prochaine étape:
# https://scotch.io/bar-talk/best-of-atom-features-plugins-acting-like-sublime-text

WORKDIR ${WORKDIRECTORY}

RUN cd ${WORKDIRECTORY} \
    && mkdir work \
    && chown -R $USERNAME:$PASSWORD work

# Standard SSH port
EXPOSE 22

# Start SSHD server...
CMD ["/usr/sbin/sshd", "-D"]

