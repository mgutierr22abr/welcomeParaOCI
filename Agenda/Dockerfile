FROM container-registry.oracle.com/os/oraclelinux:7-slim
MAINTAINER Martín Gutiérrez <martin.gutierrez@oracle.com>

RUN yum install -y python3 cronie ps
RUN pip3 install oci oci-cli cx_oracle requests
RUN pip3 install --upgrade oci cx_oracle
ENV TZ="America/Santiago"
RUN mkdir /agenda ; echo "Version oci-cli $(oci --version)" > /agenda/version.log
WORKDIR /agenda
COPY Agenda/*.sh /agenda/

CMD [ "bash", "corre.sh" ]
