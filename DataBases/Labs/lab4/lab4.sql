--all files
select * from dba_data_files;
select * from dba_temp_files;
--2
create tablespace GVS_QDATA
  datafile 'GVS_QDATA_2.dbf' 
  size 10m
  offline;
  


select TABLESPACE_NAME, STATUS, CONTENTS from SYS.dba_tablespaces;

alter tablespace GVS_QDATA ONLINE;

alter user gvscore quota 2M on GVS_QDATA;

drop tablespace GVS_QDATA including CONTENTS and DATAFILES;

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


--3
select * from dba_segments where tablespace_name='GVS_QDATA';
--4
drop table GVSCORE_FAVTEAMS;
select * from dba_segments where tablespace_name='GVS_QDATA';
--5
flashback table GVSCORE_FAVTEAMS to before drop;
select * from dba_segments where tablespace_name='GVS_QDATA';
--6
begin
  for x in 0..10000
  LOOP
    insert into GVSCORE_FAVTEAMS values('xd', 'xd');
  end loop;
end;
select count(*) from GVSCORE_FAVTEAMS;
--7
select segment_name, segment_type, tablespace_name, extents from USER_SEGMENTS where SEGMENT_NAME='GVSCORE_FAVTEAMS';
--8
drop tablespace GVS_QDATA including CONTENTS and DATAFILES;
--9
select * from V$LOG order by GROUP#;
--10
select * from V$LOGFILE order by GROUP#;
--11
--it cannot be executed from pdb, so
--you should connect to cdb$root
alter session set container=cdb$root;
alter system switch logfile;
select * from V$LOG order by GROUP#;
--0.004s
--12
alter database add logfile group 6 '/opt/oracle/oradata/FREE/redo06.log' size 50m blocksize 512;
alter database add logfile member '/opt/oracle/oradata/FREE/redo06_1.log' to group 6;
alter database add logfile member '/opt/oracle/oradata/FREE/redo06_2.log' to group 6;

select * from V$LOG order by GROUP#;

select * from V$LOGFILE order by GROUP#;
--13
alter database drop logfile member '/opt/oracle/oradata/FREE/redo06_2.log';
alter database drop logfile member '/opt/oracle/oradata/FREE/redo06_1.log';
alter database drop logfile group 6;

select * from V$LOG order by GROUP#;

select * from V$LOGFILE order by GROUP#;
--14
--LOG_MODE=NOARCHIVELOG, ARCHIVER=STOPPED
select DBID, NAME, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from v$instance;

--15
select * from v$archived_log;

--16
--sqlplus / as sysdba P.S. input in terminal: "unset TWO_TASK" before this
--shutdown immediate; (it's not a trap xd)
--startup mount;
--alter database archivelog;
--alter database open;
--17
alter session set container=cdb$root;
alter system switch logfile;
select max(sequence#) from v$archived_log;
select * from v$archived_log;
select * from v$log;
--18
--sqlplus / as sysdba P.S. input in terminal: "unset TWO_TASK" before this
--shutdown immediate; (it's not a trap xd)
--startup mount;
--alter database noarchivelog;
--alter database open;
--19
select * from v$controlfile;
--20
--sqlplus
--show parameter control_files;
--21
--sqlplus
--show parameter spfile;
--22
create pfile='/opt/oracle/product/23c/dbhomeFree/dbs/GVS_PFILE.ora' from spfile;
--23
show parameter password;
--24
show parameter background_dump_dest;
--25
--/opt/oracle/diag/rdbms/free/FREE/alert
--26
--lol we've already dropped it lol
--but we also should delete reserved logfiles with group 1,2,3...