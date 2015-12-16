FROM centos:centos6

RUN yum install -y openldap openldap-servers openldap-clients

RUN cp /usr/share/openldap-servers/slapd.conf.obsolete /etc/openldap/slapd.conf
RUN cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
RUN mv /etc/openldap/slapd.d{,.bak}

RUN mkdir /etc/openldap/cacerts

RUN slapd -f /etc/openldap/slapd.conf -h ldap://389

EXPOSE 389

COPY user_data.ldif /tmp

RUN /usr/bin/ldapadd -x -W -D "cn=Manager,dc=my-domain,dc=com" -f /tmp/user_data.ldif