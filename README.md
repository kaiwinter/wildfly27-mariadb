# wildfly27-mariadb
Docker image with Wildfly 27 and MariaDB

Based on [wildfly/wildfly:27.0.1.Final-jdk19](https://quay.io/repository/wildfly/wildfly) and [million12/mariadb](https://hub.docker.com/r/million12/mariadb/)

- Starts a MariaDB database and creates a root user: `admin/admin`
- Starts Wildfly 27 (JDK19) and adds an admin user for the management console: `admin/Admin#007`
- Configures Wildfly to use MariaDB