FROM oraclelinux:7

RUN yum update -y && \
    yum install -y \
    python3 \
    python3-pip \
    zip \
    unzip \
    git \
    make && \
    yum clean all

COPY resources/requirements.txt /requirements.txt
RUN python3 -m pip install --no-cache-dir -r /requirements.txt

ARG ANT_VERSION="1.9.13"

ENV JAVA_HOME=/usr/java/default

COPY packages/ /tmp/packages/
RUN yum install -y /tmp/packages/jdk-8u152-linux-x64.rpm && \
    unzip /tmp/packages/apache-ant-${ANT_VERSION}-bin.zip -d /usr/share/ && \
    ln -s /usr/share/apache-ant-${ANT_VERSION}/bin/ant /usr/bin/ant && \
    cp /tmp/packages/ivy-2.3.0.jar \
       /tmp/packages/sonarqube-ant-task-2.7.0.1612.jar \
       /usr/share/apache-ant-${ANT_VERSION}/lib/ && \
    rm -rf /tmp/packages && \
    yum clean all

RUN  yum -y install oracle-instantclient-release-el7 && \
     yum -y install oracle-instantclient-basic oracle-instantclient-tools oracle-instantclient-devel oracle-instantclient-sqlplus && \
     yum clean all

# Uncomment if the tools package is added
ENV PATH=$PATH:/usr/lib/oracle/21/client64/bin

RUN echo "Europe/London" > /etc/timezone
