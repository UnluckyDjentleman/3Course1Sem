--GVS
grant create tablespace, drop tablespace to U1_GVS_PDB;
alter user U1_GVS_PDB quota unlimited on t1;
alter user U1_GVS_PDB quota unlimited on t2;
alter user U1_GVS_PDB quota unlimited on t3;
alter user U1_GVS_PDB quota unlimited on t4;


create tablespace t1
    datafile 't1_u1_gvs_pdb.dbf'
    size 7 m
    autoextend on
    maxsize unlimited
    extent management local;

create tablespace t2
    datafile 't2_u1_gvs_pdb.dbf'
    size 7 m
    autoextend on
    maxsize unlimited
    extent management local;

create tablespace t3
    datafile 't3_u1_gvs_pdb.dbf'
    size 7 m
    autoextend on
    maxsize unlimited
    extent management local;

create tablespace t4
    datafile 't4_u1_gvs_pdb.dbf'
    size 7 m
    autoextend on
    maxsize unlimited
    extent management local;
--1
create table T_RANGE
(
    id      number,
    TIME_ID date
)
partition by range (id)
(
    partition p0 values less than (100) tablespace t1,
    partition p1 values less than (200) tablespace t2,
    partition p2 values less than (300) tablespace t3,
    partition PMAX values less than (maxvalue) tablespace t4
);

begin
    for i in 1..400
    loop
        insert into T_RANGE(id, time_id) values (i, sysdate);
    end loop;
end;

select * from T_RANGE partition(p0);
select * from T_RANGE partition(p1);
select * from T_RANGE partition(p2);
select * from T_RANGE partition(pmax);

--2-5
create table T_INTERVAL
(
    id      number,
    time_id date
)
    partition by range (time_id)
    interval (numtoyminterval(1, 'month'))
(
    partition p0 values less than (to_date('1-12-2010', 'dd-mm-yyyy')) tablespace t1,
    partition p1 values less than (to_date('1-12-2015', 'dd-mm-yyyy')) tablespace t2,
    partition p2 values less than (to_date('1-12-2020', 'dd-mm-yyyy')) tablespace t3
);

insert into T_INTERVAL(id, time_id) values (50, '01-02-2008');
insert into T_INTERVAL(id, time_id) values (100, '01-01-2009');
insert into T_INTERVAL(id, time_id) values (100, '01-01-2007');
insert into T_INTERVAL(id, time_id) values (200, '01-01-2019');
insert into T_INTERVAL(id, time_id) values (300, '01-01-2013');
insert into T_INTERVAL(id, time_id) values (400, '01-01-2017');
insert into T_INTERVAL(id, time_id) values (500, '01-01-2022');
commit;

select * from T_INTERVAL partition (p0);
select * from T_INTERVAL partition (p1);
select * from T_INTERVAL partition (p2);
--
create table T_HASH
(
    str varchar2(50),
    id  number
)
partition by hash (str)
(
    partition k0 tablespace t1,
    partition k1 tablespace t2,
    partition k2 tablespace t3,
    partition k3 tablespace t4
);

insert into T_HASH (str, id) values ('qwerty', 1);
insert into T_HASH (str, id) values ('some string', 2);
insert into T_HASH (str, id) values ('abcdefg', 3);
insert into T_HASH (str, id) values ('bbbbbbbb', 4);
insert into T_HASH (str, id) values ('xx', 7);
insert into T_HASH (str, id) values ('uuuu', 14);
insert into T_HASH (str, id) values ('qwertyqwerty', 32);
commit;

select * from T_HASH partition (k0);
select * from T_HASH partition (k1);
select * from T_HASH partition (k2);
select * from T_HASH partition (k3);
--
create table T_LIST
(
    obj char(3)
)
partition by list(obj)
(
    partition l0 values ('a') tablespace t1,
    partition l1 values ('b') tablespace t2,
    partition l2 values ('c') tablespace t3,
    partition l3 values (default) tablespace t4
);

insert into T_list(obj) values('a');
insert into T_list(obj) values('b');
insert into T_list(obj) values('c');
insert into T_list(obj) values('d');
insert into T_list(obj) values('e');
commit;

select * from T_list partition (l0);
select * from T_list partition (l1);
select * from T_list partition (l2);
select * from T_list partition (l3);
--6
alter table T_RANGE enable row movement;
select * from T_RANGE partition(PMAX);
update T_RANGE set id=2 where id=300;
select * from T_RANGE partition(p0) order by id;

alter table T_INTERVAL enable row movement;
select * from T_INTERVAL partition(p0);
update T_INTERVAL set time_id=to_date('01-02-2017') where id=50;
select * from T_INTERVAL partition(p2);

alter table T_HASH enable row movement;
select * from T_HASH partition(k2);
update T_HASH set str='zxcvbnm' where id=3;
select * from T_HASH partition(k3);

alter table T_LIST enable row movement;
select * from T_LIST partition(l0);
update T_LIST set obj='b' where obj='a';
select * from T_LIST partition(l1);
--7
alter table T_RANGE merge partitions p1, p2 into partition p5 tablespace t4;
select * from T_RANGE partition(p5);
--8
alter table T_RANGE split partition p5 at (200)
into (partition p1 tablespace t1, partition p2 tablespace t2);
select * from T_RANGE partition(p5);
select * from T_RANGE partition(p1);
select * from T_RANGE partition(p2);
--9
create table T_RANGE1
(
    id      number,
    TIME_ID date
);
alter table T_RANGE exchange partition p0 with table T_RANGE1 without validation;
select * from T_RANGE partition (p0);
select * from T_RANGE1;
--
drop table T_RANGE;
drop table T_LIST;
drop table T_HASH;
drop table T_INTERVAL;

drop tablespace t1 including contents and datafiles;
drop tablespace t2 including contents and datafiles;
drop tablespace t3 including contents and datafiles;
drop tablespace t4 including contents and datafiles;