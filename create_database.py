
database_name="bardes"
database_user="bardes"

psql --host=db.dptinfo.ens-cachan.fr --dbname=database_name -f create_table.sql

#add to ~/.pgpass file :
#db.dptinfo.ens-cachan.fr:[port]:database_name:database_user:[password]

#chmod 0600 ~/.pgpass
