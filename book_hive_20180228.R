#Chapter 1

#Chapter 2

#Chapter 3 Data Types and File Formats

#Chaoter 4 HiveQL:Data Definition

#Hive offers no support for row-level inserts,updates,and deletes.
#Hive doesn't support transactions.
#Hive adds extensions to provide better performance in the context of Hadoop
#and to integrate with custom extensions and even external programs.


#>describe database financials;

#To be clear, hdfs:///user/hive/warehouse/financials.db is equivalent to
#hdfs://master-server/user/hive/warehouse/financials.db, where master-server
#is your master node's DNS name and optional port.


#>Drop database if exists financials cascade;
#By default, Hive won't permit you to drop a database if it contains tables.
#You can either drop the tables first or append the CASCADE keyword to the
#command, which will cause the Hive to drop the tables in the database first


#>alter database financials set dbproperties ('edited-by'='Joe Dba')
#No other metadata about the database can be changed, including its name
#and directory location.
#There is no way to delete or "unset" a DBPROPERTY

#P73
#First, note that you can prefix a database name, mydb in this case, if you've
#not currently working in the target database.

#If you add the option IF NOT EXISTS, Hive will silently ignore the statement
#if the table already exists. This is useful inscripts that should create a
#table the first time they run.

#However, the clause has a gotcha you should know. If the schema specified 
#differs from the schema in the table that already exists, Hive won't warn
#you. If your intention is for this table to have the new schema, you'll have
#to drop the old table, losing your data, and then re-create it. Consider if
#you should use one or more ALTER TABLE statements to change the existing 
#table schema instead.


#Hive automatically adds two table properties: last_modiried_by holds the
#username of the last user to modify the table, and last_modiried_time
#holds the epoch time in seconds of that modification.


#You can also copy the schema(but not the data) of an existing table:
#>create table if not exists mydb.employees2 like mydb.employees;

#>show tables in mydb;
#>show tables 'empl.*';

#>describe extended ybr.ybr_input_nbfqz;
#return : col_name,data_type,comment


#>DESCRIBE FORMATTED ybr.ybr_input_nbfqz;
# Detailed Table Information, Storage Information


# CREATE EXTERNAL TABLE IF NOT EXISTS stocks (
#   exchange STRING,
#   symbol STRING,
#   ymd STRING,
#   price_open FLOAT,
#   price_high FLOAT,
#   price_low FLOAT,
#   price_close FLOAT,
#   volume INT,
#   price_adj_close FLOAT)
# ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
# LOCATION '/data/stocks';

#The EXTERNAL keyword tells Hive this table is external and the LOCATION
#clause is required to tell Hive where it's located.

#Because it's external, Hive does not assume it owns the data.Therefore,
#dropping the table does not delete the data, although the metadata for
#the table will be deleted.

#There are a few other small differences between managed and external tables,
#where some HiveQL constructs are not permitted for external tables.

#However,it's important to note that the differences between managed and
#external tables are smaller than they appear at first.Even for managed 
#tables,you know where they are located, so you can use other tools, hadoop
#dfs commands,etc.,to modify and even delete the files in the directories 
#for managed tables.Hive may technically own these directories and files,
#but it doesn't have full control over them! We said that Hive really has
#no control over the integrity of the files used for storage and whether
#or not their contents are consistent with the table schema.Even managed
#tables don't give us this control.


#57





















