FROM centos:centos7
MAINTAINER Liran

# -----------------------------------------------------------------------------
# Install MySQL
# -----------------------------------------------------------------------------
RUN { \
		echo '[mysql57-community]'; \
		echo 'name=MySQL 5.7 Community Server'; \
		echo 'baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/'; \
		echo 'gpgcheck=1'; \
		echo 'enabled=1'; \
		echo 'gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql'; \
	} > /etc/yum.repos.d/mysql-community.repo \
	&& rpm --import \
		https://repo.mysql.com/RPM-GPG-KEY-mysql  \
	&& yum -y install \
		--setopt=tsflags=nodocs \
		--disableplugin=fastestmirror \
		mysql-community-server-5.7.23-1.el7 \
		psmisc-22.20-15.el7 \
	#&& yum versionlock add \
	#	mysql* \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all

EXPOSE 3306

# -----------------------------------------------------------------------------
# Set default environment variables
# -----------------------------------------------------------------------------
ENV MYSQL_AUTOSTART_MYSQLD_BOOTSTRAP=true \
	MYSQL_AUTOSTART_MYSQLD_WRAPPER=true \
	MYSQL_ROOT_PASSWORD="<password>" \
	MYSQL_ROOT_PASSWORD_HASHED=false \
	MYSQL_SUBNET="127.0.0.1" \
	MYSQL_USER="" \
	MYSQL_USER_DATABASE="" \
	MYSQL_USER_PASSWORD="" \
	MYSQL_USER_PASSWORD_HASHED=false \
	SSH_AUTOSTART_SSHD=false \
	SSH_AUTOSTART_SSHD_BOOTSTRAP=false

