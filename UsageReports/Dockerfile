FROM container-registry.oracle.com/os/oraclelinux:7-slim
MAINTAINER Martín Gutiérrez <martin.gutierrez@oracle.com>

RUN yum install -y oracle-release-el7
RUN yum list oracle-instantclient*
RUN yum install -y oracle-instantclient19.6-basic.x86_64 oracle-instantclient19.6-sqlplus.x86_64
RUN yum install -y python3 git
RUN pip3 install oci oci-cli cx_oracle requests
RUN pip3 install --upgrade oci cx_oracle
RUN find /usr/lib/oracle/19.6/client64
ENV TNS_ADMIN=/app/config \
    TZ="America/Santiago" \
    PATH=$PATH:/usr/lib/oracle/19.6/client64/bin \
    LD_LIBRARY_PATH=/usr/lib/oracle/19.6/client64/lib

COPY UsageReports/ UsageReports/
WORKDIR UsageReports
COPY runCreateAndLoadDataToAPEXapp.sh .
RUN uname -a

CMD [ "bash", "runCreateAndLoadDataToAPEXapp.sh" ]
