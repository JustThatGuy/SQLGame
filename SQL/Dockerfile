# Start your image with a mssql base image
FROM mcr.microsoft.com/azure-sql-edge:latest

# create directory within SQL container for database files
RUN mkdir -p /opt/mssql-scripts

# copy the database files from host to container
COPY MonsterDB.sql /opt/mssql-scripts

# set environment variables
ENV MSSQL_SA_PASSWORD SQLDevPwd01!
ENV ACCEPT_EULA 1
ENV MSSQL_PID Developer

# Expose port 1433 for accessing from other container
# Expose port externally from docker-compose.yml
EXPOSE 1433

# Run Microsoft SQL Server and initialization script (at the same time)
CMD /bin/bash ./entrypoint.sh

# run initial scripts
RUN ( /opt/mssql/bin/sqlservr & ) | grep -q "Service Broker manager has started" && ( echo "SQLServer started" && sleep 10s ) || ( echo "SQLSERVER failed to start" && exit )/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'SQLDevPwd01' -i /opt/mssql-scripts/MonsterDB.sql