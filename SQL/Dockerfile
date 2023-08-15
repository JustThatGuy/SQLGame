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