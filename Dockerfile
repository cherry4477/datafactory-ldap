FROM centos:centos6

RUN yum install -y openldap openldap-servers openldap-clients

ADD user_data.ldif /
ADD start_ldap.sh /
ADD slapd.conf /
RUN chmod u+x start_ldap.sh

RUN mv /etc/openldap/slapd.conf /etc/openldap/slapd.conf.bk
RUN cp /slapd.conf /etc/openldap/slapd.conf
RUN cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
RUN mv /etc/openldap/slapd.d{,.bak}

RUN mkdir /etc/openldap/cacerts

EXPOSE 389

EXPOSE 22

CMD ./start_ldap.sh