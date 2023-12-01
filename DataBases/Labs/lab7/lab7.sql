--1
grant connect, create table, create view, create sequence, create cluster,
create synonym, create public synonym, create materialized view TO U1_GVS_PDB;

grant drop any cluster to U1_GVS_PDB;
--2
create sequence U1_GVS_PDB.s1
start with 1000
increment by 10
nominvalue
nomaxvalue
nocycle
nocache
noorder;

select U1_GVS_PDB.s1.nextval, U1_GVS_PDB.s1.currval from dual;
--3
create sequence U1_GVS_PDB.s2
start with 10
increment by 10
maxvalue 100
nocycle;

select U1_GVS_PDB.s2.nextval, U1_GVS_PDB.s2.currval from dual;
drop sequence U1_GVS_PDB.s2;
--4
create sequence U1_GVS_PDB.s3
start with 10
increment by -10
minvalue -100
maxvalue 10
nocycle
order;

select U1_GVS_PDB.s3.nextval, U1_GVS_PDB.s3.currval from dual;
drop sequence U1_GVS_PDB.s3;
--5
create sequence U1_GVS_PDB.s4
start with 1
increment by 1
maxvalue 10
cycle
cache 5
noorder;

select U1_GVS_PDB.s4.nextval, U1_GVS_PDB.s4.currval from dual;
drop sequence U1_GVS_PDB.s4;

--6
select * from all_sequences where sequence_owner='U1_GVS_PDB';

--7
create table T1(
N1 number(20),
N2 number(20),
N3 number(20),
N4 number(20)
)storage (buffer_pool keep);

drop table T1;
begin
    for i in 1..7 loop
        insert into T1(N1,N2,N3,N4) values
        (
            U1_GVS_PDB.s1.nextval, U1_GVS_PDB.s2.nextval,
            U1_GVS_PDB.s3.nextval, U1_GVS_PDB.s4.nextval
        );
    end loop;
end;

select * from T1;
--8
create cluster U1_GVS_PDB.ABC
(
    X number(10),
    V varchar2(12)
)
tablespace GVS_PDB_SYS_TS
hash is X hashkeys 200;
--9/11 
create table A(
XA number(10),
VA varchar2(12),
idk varchar2(200)
)
cluster U1_GVS_PDB.ABC(XA,VA);

create table B(
XB number(10),
VB varchar2(12),
idk varchar2(200)
)
cluster U1_GVS_PDB.ABC(XB,VB);

create table C(
XC number(10),
VC varchar2(12),
idk varchar2(200)
)
cluster U1_GVS_PDB.ABC(XC,VC);

--12
select * from DBA_SEGMENTS
where SEGMENT_TYPE = 'CLUSTER'
order by SEGMENT_NAME;

select * from USER_TABLES 
where CLUSTER_NAME = 'ABC' 
order by TABLE_NAME;
--13
create synonym C_TABLE_SYNONYM for C;
select * from C_TABLE_SYNONYM;
drop synonym C_TABLE_SYNONYM;
--14
create public synonym B_TABLE_SYNONYM for B;
select * from B_TABLE_SYNONYM;
drop synonym B_TABLE_SYNONYM;
--15
create table RED(ID number(10) primary key);
create table WHITE(ID number(10), foreign key (ID) references RED(ID));

begin
    for i in 1..20 loop
        insert into RED(ID) values (U1_GVS_PDB.S1.NEXTVAL);
        insert into WHITE(ID) values (U1_GVS_PDB.S1.CURRVAL);
    end loop;
end;

select * from RED;
select * from WHITE;


drop table RED;
drop table WHITE;
create or replace view RED_WHITE_IDS
as select RED.ID CUST_ID, WHITE.ID PROD_ID
from RED join WHITE
on RED.ID = WHITE.ID;

select COUNT(*) from RED_WHITE_IDS;
drop view RED_WHITE_IDS
--16
select NAME, VALUE from V$PARAMETER where name like '%rewrite%';

create materialized view MATERIAL_CUST_AND_PRODS_IDS
build immediate
refresh force on demand
start with sysdate
next sysdate + numtodsinterval (1, 'MINUTE')
as select RED.ID CUST_ID, WHITE.ID PROD_ID
from RED join WHITE 
on RED.ID = WHITE.ID;


drop materialized view MATERIAL_CUST_AND_PRODS_IDS;
insert into RED(ID) values(1500);
insert into White(ID) values(1500);
select Count(*) from MATERIAL_CUST_AND_PRODS_IDS;
commit;

drop cluster u1_gvs_pdb.abc including tables;