drop table GVS_t;
drop table GVS_t1;
create table GVS_t(x number(3), s varchar2(50),primary key (x));
INSERT into GVS_t values (12,'Jarome Iginla');
INSERT into GVS_t values (48,'Daniel Briere');
INSERT into GVS_t values (35,'Jean-Sebastian Giguere');
INSERT into GVS_t values (79,'Carter Hart');
commit;
update GVS_t set s='Linus Ullmark' where x=35;
update GVS_t set x=97 where x=79;
commit;
select count(*) from GVS_t where x>50;
delete from GVS_t where x=12;
commit;

select * from GVS_t;

create table GVS_t1(
id number(3),
name varchar2(50),
position varchar2(50),
foreign key(id) references GVS_t(x)
);

insert into GVS_t1 values (48,'Tomas Hertl','Forward');
insert into GVS_t1 values (35,'Thatcher Demko','Goalkeeper');
insert into GVS_t1 values (35,'Linus Ullmark','Goalkeeper');
insert into GVS_t1 values (97,'Connor McDavid','Forward');
insert into GVS_t1 values (35,'Samuel Montembault','Goalkeeper');
insert into GVS_t1 values (97,'Kirill Kaprizov','Forward');
insert into GVS_t1 values (35,'Darcy Kuemper','Goalkeeper');
insert into GVS_t1 values (97,'Andre Karjalainen','Defenceman');
insert into GVS_t1 values (48,'Alex Chiasson','Forward');
insert into GVS_t1 values (48,'Jordan Martinook','Forward');
insert into GVS_t1 values (48,'Matt Grzelcyk','Defenceman');

select t0.x, t1.name from GVS_t t0 join GVS_t1 t1 on t0.s!=t1.name order by t1.id;
select t0.x, t1.name from GVS_t t0 left join GVS_t1 t1 on t0.s!=t1.name where t0.x=48 order by t1.name;
select t0.x, t1.name from GVS_t t0 right join GVS_t1 t1 on t0.s=t1.name where (t0.x>30 and t0.x<50) order by t1.name




