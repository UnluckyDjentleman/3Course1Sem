grant create job, manage scheduler to u1_gvs_pdb;
alter system set JOB_QUEUE_PROCESSES = 5;
select count(*) from dba_objects_ae where Object_Type = 'PACKAGE';
--1

select to_char(sysdate, 'DD.MM.YYYY hh:mi:ss') from dual;

create table table_lab_14
(
    a14 number,
    b14 number
);
create table table_lab_14_reversed
(
    a14 number,
    b14 number
);
drop table job_statuses;
create table job_statuses
(
    status        nvarchar2(50),
    error_message nvarchar2(500),
    datetime      date default sysdate
);
insert into table_lab_14 values (1, 1);
insert into table_lab_14 values (2, 1);
insert into table_lab_14 values (4, 2);
insert into table_lab_14 values (8, 3);
insert into table_lab_14 values (16, 5);
insert into table_lab_14 values (32, 8);
insert into table_lab_14 values (64, 13);
insert into table_lab_14 values (128, 21);
insert into table_lab_14 values (256, 34);
commit;

--2
create or replace procedure job_procedures
is
    cursor job_cursors is
    select * from table_lab_14;

    err_message varchar2(500);
begin
    for m in job_cursors
    loop
        insert into table_lab_14_reversed values (m.a14, m.b14);
            delete from table_lab_14 where a14=m.a14;
    end loop;

    insert into job_statuses (status, datetime) values ('SUCCESS', to_timestamp(to_char(sysdate, 'DD.MM.YYYY hh:mi:ss'),'YYYY-MM-DD HH24:MI:SS TZH:TZM'));
    commit;
    exception
      when others then
          err_message := sqlerrm;
          insert into job_statuses (status, error_message) values ('FAILURE', err_message);
          commit;
          raise;
end job_procedures;

select * from job_statuses where status='FAILURE';

delete from job_statuses;
--3
declare job_number user_jobs.job%type;
begin
  dbms_job.submit(job_number, 'BEGIN job_procedures; commit; END;', sysdate, 'sysdate+60/86400');
  commit;
  dbms_output.put_line(job_number);
end;
--4
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;
--5
begin
  dbms_job.run(72);
end;

begin
  dbms_job.remove(5);
end;
--6
begin
dbms_scheduler.create_schedule(
  schedule_name => 'SCH_90',
  start_date=>to_timestamp(TO_CHAR(SYSDATE, 'YYYY-MM-DD') || ' 09:05:00', 'YYYY-MM-DD HH24:MI:SS TZH:TZM'),
  repeat_interval=>NULL,
  comments => '111'
);
end;

select * from user_scheduler_schedules;

begin
dbms_scheduler.create_program(
  program_name => 'PROGRAM_4',
  program_type => 'STORED_PROCEDURE',
  program_action => 'job_procedures',
  number_of_arguments => 0,
  enabled => true,
  comments => 'PROGRAM_1'
);
end;

select * from user_scheduler_programs;


begin
    dbms_scheduler.create_job(
            job_name => 'plsql_joba',
            job_type=>'plsql_block',
            job_action=>'begin job_procedures;commit;end;',
            start_date=>sysdate,
            enabled => true
        );
commit;
end;

select sysdate from dual;

select * from user_scheduler_jobs;

begin
  DBMS_SCHEDULER.DISABLE('JOB_1');
end;

begin
    DBMS_SCHEDULER.RUN_JOB('JOB_1');
end;


begin
  DBMS_SCHEDULER.DROP_JOB( JOB_NAME => 'JOB_1');
end;

select * from table_lab_14;
select * from table_lab_14_reversed;
drop table table_lab_14;
drop table table_lab_14_reversed;