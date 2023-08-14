# Start your image with a mssql base image
FROM microsoft/mssql-server-linux:2023-latest

# create directory within SQL container for database files
RUN mkdir -p /opt/mssql-scripts

# copy the database files from host to container
COPY MonsterDB.sql /opt/mssql-scripts

# set environment variables
ENV MSSQL_SA_PASSWORD=SQLDevPwd01!
ENV ACCEPT_EULA=Y

# run initial scripts
RUN ( /opt/mssql/bin/sqlservr & ) | grep -q "Service Broker manager has started" && ( echo "SQLServer started" && sleep 10s ) || ( echo "SQLSERVER failed to start" && exit )/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'SQLDevPwd01' -i /opt/mssql-scripts/MonsterDB.sql