select username from dba_users;


--------------------------------1--------------------------------------
drop tablespace TS_GVS;

create tablespace TS_GVS 
datafile 'TS_GVS.dbf'
size 7M
autoextend on next 5M
maxsize 20M;


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

create role RL_GVSCORE;
grant connect, create session, create any table, create any view, create any procedure, drop any table, drop any view, drop any procedure to RL_GVSCORE;

select * from dba_roles;

drop role RL_GVSCORE;
--------------------------------5--------------------------------------
select PRIVILEGE
from sys.dba_sys_privs
where grantee = 'RL_GVSCORE'
union
select PRIVILEGE 
from dba_role_privs rp join role_sys_privs rsp on (rp.granted_role = rsp.role)
where rp.grantee = 'RL_GVSCORE';

-- all privileges
select * from dba_sys_privs;

-- all roles
select * from dba_roles;
--------------------6---------------------------------------
create profile PF_GVSCORE limit
password_life_time 180
sessions_per_user 3
failed_login_attempts 7
password_lock_time 1
password_reuse_time 10
password_grace_time default
connect_time 180
idle_time 30;

drop profile PF_GVSCORE;
-------------------7-----------------------------------
-- All profiles
select PROFILE, RESOURCE_NAME, LIMIT from dba_profiles order by PROFILE;

-- List of my profile
select PROFILE, RESOURCE_NAME, LIMIT from dba_profiles 
where PROFILE = 'PF_GVSCORE';

-- List of default
select PROFILE, RESOURCE_NAME, LIMIT from dba_profiles 
where PROFILE = 'DEFAULT';

-------------------8------------------------------------

create user GVSCORE identified by 9900
default tablespace TS_GVS quota unlimited on TS_GVS
temporary tablespace TS_GVS_TEMP
profile PF_GVSCORE
account unlock
password expire

grant create session, connect, create any table, create any view, create any procedure, drop any table, drop any view, drop any procedure to GVSCORE;

drop user GVSCORE
------------------9-------------------------------------
--sqlplus in terminal
--Enter user-name: XXXCORE
--Enter pass-word: identified by "*pass-word"
--Then the terminal outputs that pass-word is expired and gives you to write New password...
-----------------10-------------------------------------

--table
create table GVSCORE_MANGAS
(
  TITLE varchar(50),
  AUTHOR varchar(50), 
  RATING number
);

drop table GVSCORE_MANGAS

insert into GVSCORE_MANGAS values ('Berserk', 'Kentaro Miura', 10);
insert into GVSCORE_MANGAS values ('Freesia', 'Jiro Matsumoto', 10);
insert into GVSCORE_MANGAS values ('Ichi the Killer', 'Hideo Yamamoto', 10);
insert into GVSCORE_MANGAS values ('Homunculus', 'Hideo Yamamoto', 10);
insert into GVSCORE_MANGAS values ('GTO', 'Toru Fujisawa', 9);
insert into GVSCORE_MANGAS values ('GTO: Young Years', 'Toru Fujisawa', 8);
select * from GVSCORE_MANGAS;

create view GVSCORE_GURO as 
select TITLE, RATING from GVSCORE_MANGAS
where AUTHOR = 'Hideo Yamamoto' or AUTHOR = 'Jiro Matsumoto';
select * from GVSCORE_GURO;

--drop view GVSCORE_GURO;

-----------------------------------------  TASK 11  ------------------------------------------

create tablespace GVS_QDATA
  datafile 'GVS_QDATA.dbf' 
  size 10M
  offline;
  
select TABLESPACE_NAME, STATUS, CONTENTS from SYS.dba_tablespaces;

alter tablespace GVS_QDATA ONLINE;

alter user GVSCORE quota 2M on GVS_QDATA;

drop tablespace GVS_QDATA;

-- connect GVSCORE

create table GVSCORE_FAVTEAMS
(
  TEAM varchar(50),
  SPORT varchar(50)
) tablespace GVS_QDATA;

insert into GVSCORE_FAVTEAMS values ('Vancouver Canucks', 'Hockey');
insert into GVSCORE_FAVTEAMS values ('San Antonio Spurs', 'Basketball');
insert into GVSCORE_FAVTEAMS values ('Atletico Madrid', 'Football');

select * from GVSCORE_FAVTEAMS;