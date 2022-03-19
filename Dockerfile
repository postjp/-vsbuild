FROM archlinux:base-devel

COPY ["PKGBUILD","vscodium.desktop","/"]
RUN pacman -Syu --noconfirm && \
    pacman-db-upgrade && \
    pacman -Scc --noconfirm && \
    pacman -Syu --noconfirm  gtk3 && \
    pacman -Syu --noconfirm  cairo && \
    pacman -Syu --noconfirm  libxtst && \
    pacman -Syu --noconfirm  fontconfig  && \
    pacman -Syu --noconfirm   alsa-lib   && \
    pacman -Syu --noconfirm  nss && \
    pacman -Syu --noconfirm  libnotify && \
    pacman -Syu --noconfirm  python   && \
    pacman -Syu --noconfirm  libxss && \
    pacman -Syu --noconfirm  libxkbfile && \
    pacman -Syu --noconfirm  git && \
    pacman -Syu --noconfirm  git-lfs && \
    pacman -Syu --noconfirm  make && \
    pacman -Syu --noconfirm  yarn && \
    pacman -Syu --noconfirm  jq && \
    pacman -Syu --noconfirm  libxdmcp 
    
RUN pacman -Syu --noconfirm  gulp  


# setup user build
RUN useradd -m build -s /bin/zsh && \ 
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER build
WORKDIR /home/build

RUN git clone https://github.com/postjp/nvm.git  && \
    cd nvm && \ 
    makepkg --noconfirm -rsi --install  && \
    cd && \
    cp /PKGBUILD /home/build/   && \
    cp /vscodium.desktop /home/build/  
RUN makepkg --noconfirm -rs

