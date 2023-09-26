-------------------------1------------------
select * from dba_pdbs;
------------------------2-------------------
select * from V$INSTANCE;
-----------------------3--------------------
select * from v$option;
-----------------------4--------------------
--if you use oracle oracle database 23c and dbca doesn't work then
--from sqlplus connect as sysdba
--alter session set container=cdb$root!!!!!!!!!!
--write a code from screen.png
--good luck!
-----------------------5--------------------
--look at screen1.png or
select * from dba_pdbs;
----------------------6---------------------
--oracle swears that database isn't opened, so enter in sqlplus
-- alter pluggable database GVSPDB open;
alter session set container=GVSPDB;
--Tablespace
create tablespace GVS_PDB_SYS_TS
  datafile 'GVS_PDB_SYS_TS.dbf' 
  size 10M
  autoextend on next 5M
  maxsize 50M;
  
create temporary tablespace GVS_PDB_SYS_TS_TEMP
  tempfile 'GVS_PDB_SYS_TS_TEMP.dbf'
  size 5M
  autoextend on next 2M
  maxsize 40M;

select * from dba_tablespaces where TABLESPACE_NAME like '%GVS%';


-- Role
create role GVS_PDB_SYS_RL;

grant connect, create session, create any table, drop any table, create any view, 
drop any view, create any procedure, drop any procedure to GVS_PDB_SYS_RL;

select * from dba_roles where ROLE like '%RL%';


-- Profile
create profile GVS_PDB_SYS_PROFILE limit
  password_life_time 365
  sessions_per_user 10
  failed_login_attempts 5
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default;


-- User
create user U1_GVS_PDB identified by 8800
  default tablespace GVS_PDB_SYS_TS 
  quota unlimited on GVS_PDB_SYS_TS
  temporary tablespace GVS_PDB_SYS_TS_TEMP
  profile GVS_PDB_SYS_PROFILE;

grant connect, create session, alter session, create any table, drop any table, create any view, 
drop any view, create any procedure, drop any procedure to U1_GVS_PDB; 
grant SYSDBA to U1_GVS_PDB;

select * from dba_users where USERNAME like '%GVS%';
-----------------------7------------------------------
create table GVS_table(
id int,
name varchar(50),
nation varchar(30),
motorcycleColor varchar(30),
finishTime interval day to second
);
insert into GVS_table values(1,'Enzo Fellini', 'Italy', 'Red', numtodsinterval( 250.6, 'second' )),
(2,'Francois Channel', 'France', 'Blue', numtodsinterval( 250.8, 'second' )),
(3,'Alex Holmes', 'United Kingdom', 'Green', numtodsinterval( 251, 'second' )),
(4,'Sam Hornett', 'Australia', 'Yellow', numtodsinterval( 251.3, 'second' )),
(5,'Kirk Mount', 'USA', 'White', numtodsinterval( 250.67, 'second' )),
(6,'Julian Lindemann', 'Germany', 'Black', numtodsinterval( 250.4, 'second' )),
(7,'Rembrandt Sneijder', 'Netherlands', 'Orange', numtodsinterval( 251.04, 'second' )),
(8,'Akira Kojima', 'Japan', 'Pink', numtodsinterval( 250.65, 'second' ));

select * from GVS_table order by finishTime;
-------------------------------8-----------------------------------------------
select * from dba_tablespaces;
select * from dba_data_files;
select * from dba_roles;
select * from dba_sys_privs;
select * from dba_users;
-----------------------------9-------------------------------------------------
--in sqlplus enter
--conn as sysdba
--alter session set container=cdb$root!!!!!!!!!!
--enter code from screen2.png
----------------------------10-------------------------------------------------
-- connect as sysdba
-- create session to c##YYY;
-- it's just temporary note. Result will describe later here)
----------------------------11-------------------------------------------------
--change connection to u1_gvs_pdb
select * from v$session;
----------------------------13-------------------------------------------------
--in sqlplus enter
--conn as sysdba
--alter session set container=cdb$root!!!!!!!!!!
--drop pluggable database GVSPDB
--drop user c##gvs
--then drop all connections for this user