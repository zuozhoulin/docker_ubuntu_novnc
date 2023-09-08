# ubuntu-desktop + ros + novnc
# Ubuntu 16.04 ， kinetic-desktop-full
# Ubuntu 18.04 ， melodic-desktop-full
# Ubuntu 20.04 ， noetic-desktop-full
# Ubuntu 22.04 ， iron-desktop-full

FROM osrf/ros:iron-desktop-full

# Environment 
ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/root  \
    SHELL=/bin/bash \
    TZ=Asia/Shanghai

######################################################################################
# change source, install essential packages for lxde & novnc & tools  
######################################################################################
COPY install /tmp

# 改成国内源某些版本会出问题，如依赖冲突，默认使用官方源
#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
#    && cp /tmp/config/sources.list  /etc/apt   \ 
#    && sed -i s/focal/$(lsb_release -sc)/  /etc/apt/sources.list \
#    && mkdir -p ~/.pip \
#    && cp /tmp/config/pip.conf ~/.pip 


# built-in packages
RUN apt-get update -q --fix-missing \
    && apt-get install -y --no-install-recommends software-properties-common  \
         curl apache2-utils apt-utils bash-completion \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
         supervisor nginx sudo net-tools zenity xz-utils 

# lxde & novnc & tini
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /bin/tini 
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
       lxde novnc xvfb x11vnc dbus-x11 x11-utils \
       gnome-themes-standard  ttf-wqy-zenhei \
       gtk2-engines-murrine  gtk2-engines-pixbuf gtk2-engines-murrine \
       alsa-utils mesa-utils libgl1-mesa-dri  \
    && chmod +x /bin/tini


# some tools
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        wget zip unzip bzip2 \
        git vim gedit htop terminator firefox 

######################################################################################
# develop dependencies 
######################################################################################

# compile tools & python & tini  
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
       build-essential ninja-build make cmake autoconf automake libtool \
       gcc g++ python3-pip python3-dev python3-tk \
    && ln -s /usr/bin/python3 /usr/local/bin/python \
    && ln -s /usr/bin/pip3 /usr/local/bin/pip 


# add other ... 




######################################################################################
# clean all & config & do somethiong else
######################################################################################

COPY rootfs /
WORKDIR /root

RUN apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -r /tmp/* \
    && echo "source /etc/bash_completion"  >  ~/.bashrc
  

EXPOSE 6080 11311


HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1:6079/api/health
ENTRYPOINT ["/entrypoint.sh"]
