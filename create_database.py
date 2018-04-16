
database_name="bardes"
database_user="bardes"

psql bardes bardes -h db.dptinfo.ens-cachan.fr

#add to ~/.pgpass file :
#db.dptinfo.ens-cachan.fr:[port]:database_name:database_user:[password]

#chmod 0600 ~/.pgpass
