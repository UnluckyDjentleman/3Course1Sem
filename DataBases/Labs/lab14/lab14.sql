grant create job, manage scheduler to u1_gvs_pdb;
alter system set JOB_QUEUE_PROCESSES = 5;
select count(*) from dba_objects_ae where Object_Type = 'PACKAGE';
--1
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
    end loop;

    delete from table_lab_14;
    insert into job_statuses (status, datetime) values ('SUCCESS', sysdate);
    commit;
    exception
      when others then
          err_message := sqlerrm;
          insert into job_statuses (status, error_message) values ('FAILURE', err_message);
          commit;
          raise;
end job_procedures;

select * from job_statuses;

--3
declare job_number user_jobs.job%type;
begin
  dbms_job.submit(job_number, 'BEGIN job_procedures(); END;', sysdate, 'sysdate + 7');
  commit;
  dbms_output.put_line(job_number);
end;
--4
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;
--5
begin
  dbms_job.run(5);
end;

begin
  dbms_job.remove(5);
end;
--6
begin
dbms_scheduler.create_schedule(
  schedule_name => 'SCH_1',
  start_date => sysdate,
  repeat_interval => 'FREQ=WEEKLY',
  comments => 'SCH_1 WEEKLY starts now'
);
end;

select * from user_scheduler_schedules;

begin
dbms_scheduler.create_program(
  program_name => 'PROGRAM_1',
  program_type => 'STORED_PROCEDURE',
  program_action => 'job_procedure',
  number_of_arguments => 0,
  enabled => true,
  comments => 'PROGRAM_1'
);
end;

select * from user_scheduler_programs;


begin
    dbms_scheduler.create_job(
            job_name => 'JOB_1',
            program_name => 'PROGRAM_1',
            schedule_name => 'SCH_1',
            enabled => true
        );
end;

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