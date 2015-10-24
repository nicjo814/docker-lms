FROM phusion/baseimage

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV HOME="/root"
ENV TERM=xterm
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

COPY init/20adduser.sh /etc/my_init.d/20adduser.sh
COPY services/lms.sh /etc/service/lms/run

RUN echo "deb http://debian.slimdevices.com stable main" >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
        logitechmediaserver && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/log/supervisor && \
    useradd -u 911 -U -s /bin/false abc && \
    usermod -G users abc && \
    mkdir -p /config && \
    chmod +x /etc/my_init.d/20adduser.sh && \
    chmod +x /etc/service/lms/run

VOLUME /config
EXPOSE 3483 9000 9090

CMD ["/sbin/my_init"]
