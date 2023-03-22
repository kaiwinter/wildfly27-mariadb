FROM quay.io/wildfly/wildfly:27.0.1.Final-jdk19

USER root

RUN curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | bash
RUN yum update -y
RUN yum install epel-release -y
RUN yum install hostname net-tools pwgen wget -y

RUN \
    yum install -y MariaDB-server && \
    yum clean all && \
    rm -rf /var/lib/mysql/*

RUN mkdir -p /opt/jboss/wildfly/modules/system/layers/base/org/mariadb/mariadb-java-client/main
RUN wget https://repo1.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/2.7.4/mariadb-java-client-2.7.4.jar -O /opt/jboss/wildfly/modules/system/layers/base/org/mariadb/mariadb-java-client/main/mariadb-java-client-2.7.4.jar

COPY container-files/wildfly/standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml
COPY container-files/wildfly/module.xml /opt/jboss/wildfly/modules/system/layers/base/org/mariadb/mariadb-java-client/main/

RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#007 --silent

COPY container-files/mariadb /
COPY container-files/wildfly/run-wildfly.sh /

EXPOSE 3306 8080 9990 8787
WORKDIR "/"
ENV MARIADB_PASS 'admin'
RUN chmod +x /run-maria.sh
RUN chmod +x /run-wildfly.sh
ENTRYPOINT ./run-maria.sh && ./run-wildfly.sh
