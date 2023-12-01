--u1_gvspdb/gvspdb!!!
--1
begin
    null;
end;
--2
begin
    dbms_output.put_line('Hello World');
end;
--3
declare
    x number(3):=10;
    y number(3):=0;
    z number(10,2);
    begin
        z:=x/y;
        dbms_output.put_line('z='||z);
    exception
        when others
            then dbms_output.put_line(sqlcode || ': error = ' || sqlerrm);
    end;
--4
declare
    x number(3) := 3;
    y number(3) := 0;
    z number(10, 2);
begin
    dbms_output.put_line('x = ' || x || ', y = ' || y);
    begin
        z := x / y;
        dbms_output.put_line('z = ' || z);
    exception
        when others
            then dbms_output.put_line('error = ' || sqlerrm);
    end;
end;
--5
--alter system set plsql_warnings='ENABLE:INFORMATIONAL';
--show parameter plsql_warnings;
--for sys as sysdba
select name, value
from v$parameter
where name = 'plsql_warnings';
--6
select keyword
from v$reserved_words
where length = 1;
--7
select keyword
from v$reserved_words
where length > 1
order by keyword;
--8
select name, value
from v$parameter
where name like 'plsql%';
--9
declare
    t10     number(3)      := 5;
    t11     number(3)      := 208;
    sum_var number(10, 2);
    dwr     number(10, 2);
    t12     number(10, 2)  := 2.11;
    t13     number(10, -3) := 222999.45;
    t14     binary_float   := 123456789.123456789;
    t15     binary_double  := 123456789.123456789;
    t16     number(38, 10) := 12345E+10;
    t17     boolean        := true;
begin
    sum_var := t10 + t11;
    dwr := mod(t10, t11);

    dbms_output.put_line('t10 = ' || t10);
    dbms_output.put_line('t11 = ' || t11);
    dbms_output.put_line('remainder = ' || dwr);
    dbms_output.put_line('sum = ' || sum_var);
    dbms_output.put_line('fixed = ' || t12);
    dbms_output.put_line('rounded = ' || t13);
    dbms_output.put_line('binary float = ' || t14);
    dbms_output.put_line('binary double = ' || t15);
    dbms_output.put_line('E+10 = ' || t16);
    if t17
    then
        dbms_output.put_line('bool = ' || 'true');
    end if;
end;
--10
declare
    nm constant number       := 892;
    vc constant varchar2(9) := 'Vladislav';
    c           char(5)      := 'Ch';
begin
    c := 'Nchar';
    dbms_output.put_line(nm);
    dbms_output.put_line(vc);
    dbms_output.put_line(c);
exception
    when others
        then dbms_output.put_line('error = ' || sqlerrm);
end;
--11
declare
    pulp teacher.teacher%type;
begin
    pulp := 'ПИ';
    dbms_output.put_line(pulp);
end;
--12
declare
    faculty_res faculty%rowtype;
begin
    faculty_res.faculty := 'ИТ';
    faculty_res.faculty_name := 'Факультет информационных технологий';
    dbms_output.put_line(faculty_res.faculty || ' - ' || faculty_res.faculty_name);
end;
--13
declare
    x pls_integer := 22;
begin
    if x < 10 then
        dbms_output.put_line('x < 10');
    elsif x > 10 then
        dbms_output.put_line('x > 10');
    else
        dbms_output.put_line('x = 10');
    end if;
end;
--14
declare
    x pls_integer := 26;
begin
    case
        when x between 10 and 20 then dbms_output.put_line('10 <= x <= 20');
        when x between 21 and 40 then dbms_output.put_line('21 <= x <= 40');
        else dbms_output.put_line('else block');
        end case;
end;
--15
declare
    x pls_integer := 0;
begin
    dbms_output.put_line('LOOP: ');
    loop
        x := x + 3;
        dbms_output.put_line(x);
        exit when x >= 12;
    end loop;
end;
--16
declare
    x pls_integer := 15;
begin
    dbms_output.put_line('WHILE: ');
    while (x > 0)
        loop
            dbms_output.put_line(x);
            x := x - 1;
        end loop;
end;
--17
begin
    dbms_output.put_line('FOR: ');
    for k in 1..5
        loop
            dbms_output.put_line(k);
        end loop;
end;
