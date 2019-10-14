# ci-oracle-client-runner - Dockerfile for Oracle Instant Client
# Based on Oracle template: https://github.com/oracle/docker-images/blob/master/OracleInstantClient/dockerfiles/19/Dockerfile
# Oracle client component packages documented here: https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html

FROM oraclelinux:7-slim

ARG release=19
ARG update=3

# Install Oracle client packages from Oracle Linux yum server:
RUN  yum -y install oracle-release-el7 && yum-config-manager --enable ol7_oracle_instantclient && \
     yum -y install oracle-instantclient${release}.${update}-basic oracle-instantclient${release}.${update}-devel oracle-instantclient${release}.${update}-sqlplus oracle-instantclient${release}.${update}-tools && \
     rm -rf /var/cache/yum

# Path update required for tools package:
ENV PATH=$PATH:/usr/lib/oracle/${release}.${update}/client64/bin

# Additional packages used in scripts:
RUN  yum install -y hostname-3.13-3.el7.x86_64 && \
     rm -rf /var/cache/yum

CMD ["sqlplus", "-v"]
