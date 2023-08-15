# Wait to be sure that SQL Server came up
sleep 20

# Run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P SQLDevPwd01! -d master -i MonsterDB.sql