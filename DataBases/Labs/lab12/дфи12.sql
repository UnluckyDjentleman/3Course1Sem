grant create trigger, drop any trigger to u1_gvs_pdb;
set serveroutput on;
--1
create table Students(
id number generated always as identity primary key,
courseid int check(courseid>=1 and courseid<=4),
groupid int,
name nvarchar2(50)
);

--2

insert into Students(courseid,groupid,name) values(1,3,'Jan Novak');
insert into Students(courseid,groupid,name) values(1,5,'Eva Novakova');
insert into Students(courseid,groupid,name) values(2,3,'John Doe');
insert into Students(courseid,groupid,name) values(2,1,'Jane Doe');
insert into Students(courseid,groupid,name) values(3,6,'Anna Malli');
insert into Students(courseid,groupid,name) values(3,8,'Ville Virtanen');
insert into Students(courseid,groupid,name) values(4,9,'Fulan AlFulani');
insert into Students(courseid,groupid,name) values(4,2,'Fulanah AlFulaniyyah');
insert into Students(courseid,groupid,name) values(4,7,'Jon Jonsson');
insert into Students(courseid,groupid,name) values(4,10,'Jona Jonsdottor');

select * from STUDENTS;

--3
create or replace trigger INSERTBEFORE
before insert
on Students
begin
dbms_output.put_line('Inserted');
end;

create or replace trigger UPDATEBEFORE
before update
on Students
begin
dbms_output.put_line('Updated');
end;

create or replace trigger DELETEBEFORE
before delete
on Students
begin
dbms_output.put_line('Deleted');
end;

insert into Students(courseid,groupid,name) values (3,2,'Anna Ivanova');
update students set groupid=4, name='xd xd' where id=12;
delete from Students where id=5;
select * from students;
--4
create or replace trigger INSERTBEFOREROW
before insert
on Students
for each row
begin
dbms_output.put_line('ROWTR:Inserted');
end;

create or replace trigger UPDATEBEFOREROW
before update
on Students
for each row
begin
dbms_output.put_line('ROWTR:Updated');
end;

create or replace trigger DELETEBEFOREROW
before delete
on Students
for each row
begin
dbms_output.put_line('ROWTR:Deleted');
end;

--5
create or replace trigger TRIGGER_DML
    before insert or update or delete
    on Students
begin
    if INSERTING then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_DML_BEFORE_INSERT');
    ELSIF UPDATING then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_DML_BEFORE_UPDATE');
    ELSIF DELETING then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_DML_BEFORE_DELETE');
    end if;
end;
--6
create or replace trigger INSERT_TR_AFTER_STATEMENT
    after insert
    on Students
begin
    DBMS_OUTPUT.PUT_LINE('INSERT_TR_AFTER_STATEMENT');
end;

create or replace trigger UPDATE_TR_AFTER_STATEMENT
    after update
    on Students
begin
    DBMS_OUTPUT.PUT_LINE('UPDATE_TR_AFTER_STATEMENT');
end;

create or replace trigger DELETE_TR_AFTER_STATEMENT
    after delete
    on Students
begin
    DBMS_OUTPUT.PUT_LINE('DELETE_TR_AFTER_STATEMENT');
end;
--7
create or replace trigger INSERT_TR_AFTER_STATEMENTROW
    after insert
    on Students
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('INSERT_TR_AFTER_STATEMENT');
end;

create or replace trigger UPDATE_TR_AFTER_STATEMENTROW
    after update
    on Students
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('UPDATE_TR_AFTER_STATEMENT');
end;

create or replace trigger DELETE_TR_AFTER_STATEMENTROW
    after delete
    on Students
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('DELETE_TR_AFTER_STATEMENT');
end;
--8
create table AUDITS
(
    OperationDate date,
    OperationType varchar2(50),
    TriggerName   varchar2(50),
    Data          varchar2(40)
);
--9
create or replace trigger TRIGGER_BEFORE_AUDIT
    before insert or update or delete
    on Students
    for each row
begin
    if inserting then
         DBMS_OUTPUT.PUT_LINE('TRIGGER_BEFORE_AUDIT - INSERT' );
         insert into AUDITS values (
                                    sysdate,
                                    'insert',
                                    'TRIGGER_BEFORE_AUDIT',
                                    :new.courseid || ' ' || :new.groupid || ' ' ||:new.name
                                   );
    elsif updating then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_BEFORE_AUDIT - UPDATE' );
        insert into AUDITS values (
                                    sysdate,
                                    'update',
                                    'TRIGGER_BEFORE_AUDIT',
                                     :new.courseid || ' ' || :new.groupid || ' ' ||:new.name || ' -> ' || :old.courseid || ' ' || :old.groupid || ' ' ||:old.name
                                   );
    elsif deleting then
         DBMS_OUTPUT.PUT_LINE('TRIGGER_BEFORE_AUDIT - DELETE' );
         insert into AUDITS values (
                                    sysdate,
                                    'delete',
                                    'TRIGGER_BEFORE_AUDIT',
                                    :old.courseid || ' ' || :old.groupid || ' ' ||:old.name
                                   );
    end if;
end;

create or replace trigger TRIGGER_AFTER_AUDIT
    after insert or update or delete
    on Students
    for each row
begin
    if inserting then
         DBMS_OUTPUT.PUT_LINE('TRIGGER_AFTER_AUDIT - INSERT' );
         insert into AUDITS values (
                                    sysdate,
                                    'insert',
                                    'TRIGGER_AFTER_AUDIT',
                                    :new.courseid || ' ' || :new.groupid || ' ' ||:new.name
                                   );
    elsif updating then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_AFTER_AUDIT - UPDATE' );
        insert into AUDITS values (
                                    sysdate,
                                    'update',
                                    'TRIGGER_AFTER_AUDIT',
                                     :old.courseid || ' ' || :old.groupid || ' ' ||:old.name || ' -> ' || :new.courseid || ' ' || :new.groupid || ' ' ||:new.name
                                   );
    elsif deleting then
         DBMS_OUTPUT.PUT_LINE('TRIGGER_AFTER_AUDIT - DELETE' );
         insert into AUDITS values (
                                    sysdate,
                                    'delete',
                                    'TRIGGER_AFTER_AUDIT',
                                    :old.courseid || ' ' || :old.groupid || ' ' ||:old.name
                                   );
    end if;
end;

select * from AUDITS;
--10
create table Task_Table
(
    a int primary key,
    b varchar(30)
);
drop table TASK_TABLE;

--drop trigger TRIGGER_PREVENT_TABLE_DROP
create or replace trigger TRIGGER_PREVENT_TABLE_DROP
    before drop
    on U1_GVS_PDB.schema
begin
    if DICTIONARY_OBJ_NAME = 'TASK_TABLE'
    then
        RAISE_APPLICATION_ERROR(-20000, 'You can not drop table TASK_TABLE.');
    end if;
end;

insert into Students(courseid,groupid,name) values (11,11,'f');

--11
drop table AUDITS;

--12
--drop view TASK_TABLE_VIEW;
create view TASK_TABLE_VIEW
as select * from TASK_TABLE;

create or replace trigger TRIGGER_INSTEAD_OF_INSERT
    instead of insert
    on TASK_TABLE_VIEW
begin
    if INSERTING then
        DBMS_OUTPUT.PUT_LINE('TRIGGER_INSTEAD_OF_INSERT');
        insert into TASK_TABLE values (100, 'www');
    end if;
end TRIGGER_INSTEAD_OF_INSERT;

select * from TASK_TABLE_VIEW;
insert into TASK_TABLE_VIEW values (133, 'eee');