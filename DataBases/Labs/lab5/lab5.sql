--1
select sum(value) from v$sga;
--2
select * from v$sga;
--3
select component, granule_size, current_size/granule_size as Ratio from v$sga_dynamic_components;
--4
select current_size from v$sga_free_memory;
--5
--in sqlplus
--show parameter sga
--6
select component, min_size, current_size, max_size from v$sga_dynamic_components where component like '%KEEP%'||'%RECYCLE%'||'%DEFAULT buffer cache%';
--7
create table GVS (x int) storage(buffer_pool keep) tablespace users;
insert into GVS values(6);
insert into GVS values(10);
insert into GVS values(2003);
insert into GVS values(16);
insert into GVS values(5);
insert into GVS values(2016);
commit;

select * from dba_segments where segment_name like '%GVS%';

--8
create table GVS1 (x int) cache storage(buffer_pool default) tablespace users;
insert into GVS1 values(6);
insert into GVS1 values(10);
insert into GVS1 values(2003);
insert into GVS1 values(16);
insert into GVS1 values(5);
insert into GVS1 values(2016);
commit;

select * from dba_segments where segment_name like '%GVS1%';

--9
--in sqlplus
--show parameter log_buffer

--10
select (max_size-current_size) as AVAILABLE_SPACE from v$sga_dynamic_components where component='large pool';

--11
select * from v$session where status='ACTIVE';

--12

select * from v$bgprocess;

--13
select sid, name,process, program from v$session s join v$bgprocess using(paddr) where s.status='ACTIVE';

--14
--in sqlplus
--show parameter db_writer_processes;

--15
select name, network_name, pdb from v$services;

--16
--in sqlplus
--show parameter dispatcher;

--17
--idk how to do it on linux, because Docker crushed my OS and I'm lazy to reinstall Oracle.
--but you can check if it works by
--ps -ef|grep tns

--18
--$ORACLE_HOME\network\admin

--19
--look at screen.png
--start, stop, status, services, version, reload, save_config, trace, quit, exit, set, show
--20
--lsnctrl services in sqlplus
