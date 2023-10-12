--all files
select * from dba_data_files;
select * from dba_temp_files;
--2
create tablespace GVS_QDATA
  datafile 'GVS_QDATA.dbf' 
  size 10M
  offline;
  
select TABLESPACE_NAME, STATUS, CONTENTS from SYS.dba_tablespaces;

alter tablespace GVS_QDATA ONLINE;

alter user GVSCORE quota 2M on GVS_QDATA;

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
alter system switch logfile;
select * from V$LOG order by GROUP#;
--0.004s
--12
alter database add logfile group 4 '/opt/oracle/oradata/FREE/redo04.log' size 50m blocksize 512;
alter database add logfile member '/opt/oracle/oradata/FREE/redo04_1.log' to group 4;
alter database add logfile member '/opt/oracle/oradata/FREE/redo04_2.log' to group 4;

select * from V$LOG order by GROUP#;

select * from V$LOGFILE order by GROUP#;
--13
alter database drop logfile member '/opt/oracle/oradata/FREE/redo04_2.log';
alter database drop logfile member '/opt/oracle/oradata/FREE/redo04_1.log';
alter database drop logfile group 4;

select * from V$LOG order by GROUP#;

select * from V$LOGFILE order by GROUP#;
--14
--LOG_MODE=NOARCHIVELOG, ARCHIVER=STOPPED
select DBID, NAME, LOG_MODE from V$DATABASE;
select INSTANCE_NAME, ARCHIVER, ACTIVE_STATE from v$instance;

--15
--It should be empty
select * from v$archived_log;

--16
--conn /as sysdba
--alter session set container=cdb$root; (it's a trap)
--shutdown immediate; (it's a trap)
--startup mount;
--alter database archivelog;
--alter database open;
--17
