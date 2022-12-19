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
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_SESSION_TOKEN

RUN aws s3 cp s3://resources.ch.gov.uk/jdk-8u152-linux-x64.rpm /tmp/ && \
    aws s3 cp s3://resources.ch.gov.uk/apache-ant-${ANT_VERSION}-bin.zip /tmp/ && \
    unzip /tmp/apache-ant-${ANT_VERSION}-bin.zip -d /usr/share/ && \
    ln -s /usr/share/apache-ant-${ANT_VERSION}/bin/ant /usr/bin/ant

RUN aws s3 cp s3://resources.ch.gov.uk/ivy-2.3.0.jar /usr/share/apache-ant-${ANT_VERSION}/lib && \
    aws s3 cp s3://resources.ch.gov.uk/packages/sonar/sonarqube-ant-task-2.7.0.1612.jar /usr/share/apache-ant-${ANT_VERSION}/lib

ENV JAVA_HOME=/usr/java/default
RUN yum install -y /tmp/jdk-8u152-linux-x64.rpm && \
    unzip /tmp/apache-ant-${ANT_VERSION}-bin.zip && \
    rm /tmp/jdk-8u152-linux-x64.rpm && \
    rm /tmp/apache-ant-${ANT_VERSION}-bin.zip && \
    yum clean all

RUN  yum -y install oracle-instantclient-release-el7 && \
     yum -y install oracle-instantclient-basic oracle-instantclient-tools oracle-instantclient-devel oracle-instantclient-sqlplus && \
     yum clean all

# Uncomment if the tools package is added
ENV PATH=$PATH:/usr/lib/oracle/21/client64/bin

RUN echo "Europe/London" > /etc/timezone
