#!/usr/bin/python

#####################################
# Craig J. Earley
# Hardware Interface Project
# Earlham College
# 2016-01-24

# python script to move information
# from sqlite3 database to postgres database
#
#####################################

import psycopg2, sqlite3
import sys, getopt
import argparse
import subprocess 

from time import strftime
from datetime import datetime

def main():
	# initialization and database connections
	pgdb = "host='localhost' dbname='myDBName' user='myUser' password='myPassword'"
	sqlitedb = "/path/to/my/db.sdb"
	
	sqliteconn = sqlite3.connect(sqlitedb)
	pgconn = psycopg2.connect(pgdb)
	sqlitecur = sqliteconn.cursor()
	pgcur = pgconn.cursor()
	
	# move a row
	for row in sqlitecur.execute('SELECT * FROM table ORDER BY orderCriterion DESC LIMIT 1'):

		pgcur.execute("INSERT INTO newTable VALUES (%s, %s)", (row[0],row[1]))

	# close connections to databases
	sqliteconn.commit()
	sqlitecur.close()
	sqliteconn.close()
	
	pgconn.commit()
	pgcur.close()
	pgconn.close()

if __name__ == "__main__":
	main()

sys.exit(); 
