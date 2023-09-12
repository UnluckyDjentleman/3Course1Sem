select username from dba_users;


--------------------------------1--------------------------------------
drop tablespace TS_GVS;

create tablespace TS_GVS 
datafile 'TS_GVS.dbf'
size 7M
autoextend on next 5M
maxsize 20M
extent management local;


--------------------------------2--------------------------------------
create temporary tablespace TS_GVS_TEMP
tempfile 'TS_GVS_TEMP.dbf'
size 5M
autoextend on next 3M
maxsize 30M;

drop tablespace TS_GVS_TEMP;

--------------------------------3--------------------------------------
--all files
select * from dba_data_files;

--all tablespaces
select * from dba_tablespaces;

--------------------------------4--------------------------------------



