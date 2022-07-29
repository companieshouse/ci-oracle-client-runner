FROM oraclelinux:8

RUN yum update -y && \
    yum install -y \
    epel-release \
    zip \
    unzip \
    git \
    make && \
    rm -rf /var/cache/yum

RUN  dnf -y install oracle-instantclient-release-el8 && \
     dnf -y install oracle-instantclient-basic oracle-instantclient-tools oracle-instantclient-devel oracle-instantclient-sqlplus && \
     rm -rf /var/cache/dnf

# Uncomment if the tools package is added
ENV PATH=$PATH:/usr/lib/oracle/21/client64/bin

RUN echo "Europe/London" > /etc/timezone
