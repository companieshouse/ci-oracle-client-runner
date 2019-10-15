# ci-oracle-client-runner - Dockerfile for Oracle Instant Client

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
RUN  yum install -y hostname-3.13 && \
     rm -rf /var/cache/yum

CMD ["sqlplus", "-v"]
