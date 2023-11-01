--1
select * from v$bgprocess;
--2
select sid, process, name, description, program
from v$session s join v$bgprocess using (paddr)
where s.status = 'ACTIVE';
--3
show parameter db_writer_processes;
--4
select USERNAME, SID, STATUS, SERVER, MACHINE, PROGRAM from v$session order by USERNAME, SID;
--5
select USERNAME, SID, STATUS, SERVER from v$session order by USERNAME, SID;
--6
select NAME, NETWORK_NAME, PDB from v$services;
--7
alter session set container=cdb$root;
alter system set max_dispatchers=10;
show parameter dispatcher;
--8
--idk how to do it on linux, because Docker crushed my OS and I'm lazy to reinstall Oracle.
--but you can check if it works by
--ps -ef|grep tns
--for Windows
--services.msc -> OracleOraDB12Home1TNSListener
--9
select USERNAME, sid, PADDR, PROCESS, SERVER, STATUS, PROGRAM from v$session where USERNAME is not null;
select ADDR, SPID, PNAME from v$process order by ADDR;
--10
--$ORACLE_HOME\newtwork\admin
--11
--start, stop, status, services, version, reload, save_config, trace, quit, exit, set, show
--12
--lsnrctl services;