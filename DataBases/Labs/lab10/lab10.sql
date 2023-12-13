--1
alter table TEACHER add BIRTHDAY date;
alter table TEACHER add SALARY number;
--2
update TEACHER
set BIRTHDAY = '12-02-1959'
where TEACHER = '—ÃÀ¬';
update TEACHER
set BIRTHDAY = '30-03-1963'
where TEACHER = '¿ Õ¬◊';
update TEACHER
set BIRTHDAY = '19-04-1973'
where TEACHER = ' À—Õ¬';
update TEACHER
set BIRTHDAY = '16-04-1964'
where TEACHER = '√–ÃÕ';
update TEACHER
set BIRTHDAY = '19-11-1988'
where TEACHER = 'ÀŸÕ ';
update TEACHER
set BIRTHDAY = '05-10-1966'
where TEACHER = '¡– ¬◊';
update TEACHER
set BIRTHDAY = '10-08-1954'
where TEACHER = 'ƒƒ ';
update TEACHER
set BIRTHDAY = '11-09-1969'
where TEACHER = ' ¡À';
update TEACHER
set BIRTHDAY = '01-01-1955'
where TEACHER = '”–¡';
update TEACHER
set BIRTHDAY = '03-06-1975'
where TEACHER = '–ÃÕ ';
update TEACHER
set BIRTHDAY = '10-05-1970'
where TEACHER = 'œ—“¬À¬';
update TEACHER
set BIRTHDAY = '26-10-2023'
where TEACHER = '?';
update TEACHER
set BIRTHDAY = '30-07-1958'
where TEACHER = '√–Õ';
update TEACHER
set BIRTHDAY = '19-10-1977'
where TEACHER = '∆À ';
update TEACHER
set BIRTHDAY = '12-07-1969'
where TEACHER = '¡–“ÿ¬◊';
update TEACHER
set BIRTHDAY = '26-02-1983'
where TEACHER = 'ﬁƒÕ ¬';
update TEACHER
set BIRTHDAY = '13-12-1991'
where TEACHER = '¡–Õ¬— ';
update TEACHER
set BIRTHDAY = '20-01-1988'
where TEACHER = 'Õ¬–¬';
update TEACHER
set BIRTHDAY = '21-12-1969'
where TEACHER = '–¬ ◊';
update TEACHER
set BIRTHDAY = '28-01-1978'
where TEACHER = 'ƒÃƒ ';
update TEACHER
set BIRTHDAY = '10-07-1983'
where TEACHER = 'Ãÿ ¬— ';
update TEACHER
set BIRTHDAY = '08-10-1988'
where TEACHER = 'À¡’';
update TEACHER
set BIRTHDAY = '30-07-1984'
where TEACHER = '«¬√÷¬';
update TEACHER
set BIRTHDAY = '16-04-1964'
where TEACHER = '¡«¡–ƒ¬';
update TEACHER
set BIRTHDAY = '12-05-1945'
where TEACHER = 'œ– œ◊ ';
update TEACHER
set BIRTHDAY = '20-10-1980'
where TEACHER = 'Õ— ¬÷';
update TEACHER
set BIRTHDAY = '21-08-1950'
where TEACHER = 'Ã’¬';
update TEACHER
set BIRTHDAY = '13-08-1996'
where TEACHER = '≈ŸÕ ';
update TEACHER
set BIRTHDAY = '11-11-1948'
where TEACHER = '∆–— ';

update TEACHER
set SALARY = 10500
where TEACHER = '—ÃÀ¬';
update TEACHER
set SALARY = 10500
where TEACHER = '¿ Õ¬◊';
update TEACHER
set SALARY = 9300
where TEACHER = ' À—Õ¬';
update TEACHER
set SALARY = 10500
where TEACHER = '√–ÃÕ';
update TEACHER
set SALARY = 5900
where TEACHER = 'ÀŸÕ ';
update TEACHER
set SALARY = 8700
where TEACHER = '¡– ¬◊';
update TEACHER
set SALARY = 8150
where TEACHER = 'ƒƒ ';
update TEACHER
set SALARY = 9950
where TEACHER = ' ¡À';
update TEACHER
set SALARY = 14600
where TEACHER = '”–¡';
update TEACHER
set SALARY = 11200
where TEACHER = '–ÃÕ ';
update TEACHER
set SALARY = 12500
where TEACHER = 'œ—“¬À¬';
update TEACHER
set SALARY = 0
where TEACHER = '?';
update TEACHER
set SALARY = 1500
where TEACHER = '√–Õ';
update TEACHER
set SALARY = 1400
where TEACHER = '∆À ';
update TEACHER
set SALARY = 9000
where TEACHER = '¡–“ÿ¬◊';
update TEACHER
set SALARY = 875
where TEACHER = 'ﬁƒÕ ¬';
update TEACHER
set SALARY = 970
where TEACHER = '¡–Õ¬— ';
update TEACHER
set SALARY = 780
where TEACHER = 'Õ¬–¬';
update TEACHER
set SALARY = 1150
where TEACHER = '–¬ ◊';
update TEACHER
set SALARY = 805
where TEACHER = 'ƒÃƒ ';
update TEACHER
set SALARY = 905
where TEACHER = 'Ãÿ ¬— ';
update TEACHER
set SALARY = 1200
where TEACHER = 'À¡’';
update TEACHER
set SALARY = 1500
where TEACHER = '«¬√÷¬';
update TEACHER
set SALARY = 905
where TEACHER = '¡«¡–ƒ¬';
update TEACHER
set SALARY = 715
where TEACHER = 'œ– œ◊ ';
update TEACHER
set SALARY = 880
where TEACHER = 'Õ— ¬÷';
update TEACHER
set SALARY = 735
where TEACHER = 'Ã’¬';
update TEACHER
set SALARY = 595
where TEACHER = '≈ŸÕ ';
update TEACHER
set SALARY = 8500
where TEACHER = '∆–— ';
--3
select regexp_substr(teacher_name, '(\S+)', 1, 1) || ' ' ||
       substr(regexp_substr(teacher_name, '(\S+)', 1, 2), 1, 1) || '.' ||
       substr(regexp_substr(teacher_name, '(\S+)', 1, 3), 1, 1) || '.' as ‘»Œ
from teacher;
--4
select * from TEACHER where to_char(birthday, 'd')=1;
--5
create or replace view next_month as
select *
from TEACHER
where TO_CHAR(birthday, 'mm') =
      (select substr(to_char(trunc(last_day(sysdate)) + 1), 4, 2)
       from dual);

select *
from next_month;
--6
create or replace view number_months as
select to_char(birthday, 'Month') ÃÂÒˇˆ,
       count(*)                    ÓÎË˜ÂÒÚ‚Ó
from teacher
group by to_char(birthday, 'Month')
having count(*) >= 1
order by  ÓÎË˜ÂÒÚ‚Ó desc;

select * from number_months;
--7
set serveroutput on;
declare
    cursor teacher_birthday
        return teacher%rowtype is
        select *
        from teacher
        where MOD((TO_CHAR(sysdate, 'yyyy') - TO_CHAR(birthday, 'yyyy') + 1), 10) = 0 or MOD((TO_CHAR(sysdate, 'yyyy') - TO_CHAR(birthday, 'yyyy') + 1), 10) = 5;
    v_teacher  TEACHER%rowtype;
begin
    open teacher_birthday;

    fetch teacher_birthday into v_teacher;

    while (teacher_birthday%found)
        loop
            dbms_output.put_line(v_teacher.teacher || ' ' || v_teacher.teacher_name || ' ' || v_teacher.pulpit || ' ' ||
                                 v_teacher.birthday || ' ' || v_teacher.salary);
            fetch teacher_birthday into v_teacher;
        end loop;

    close teacher_birthday;
end;
--7
declare
    cursor teachers_avg_salary is
        select pulpit, floor(avg(salary)) as AVG_SALARY
        from TEACHER
        group by pulpit;
    cursor faculty_avg_salary is
        select FACULTY, AVG(SALARY)
        from TEACHER
                 join PULPIT P on TEACHER.PULPIT = P.PULPIT
        group by FACULTY;
    cursor faculties_avg_salary is
        select AVG(SALARY)
        from TEACHER;
    m_pulpit  TEACHER.PULPIT%type;
    m_salary  TEACHER.SALARY%type;
    m_faculty PULPIT.FACULTY%type;
begin

    dbms_output.put_line('--------------- œÓ Í‡ÙÂ‰‡Ï -----------------');
    open teachers_avg_salary;
    fetch teachers_avg_salary into m_pulpit, m_salary;

    while (teachers_avg_salary%found)
        loop
            dbms_output.put_line(m_pulpit || ' ' || m_salary);
            fetch teachers_avg_salary into m_pulpit, m_salary;
        end loop;
    close teachers_avg_salary;

    dbms_output.put_line('--------------- œÓ Ù‡ÍÛÎ¸ÚÂÚ‡Ï -----------------');
    open faculty_avg_salary;
    fetch faculty_avg_salary into m_faculty, m_salary;

    while (faculty_avg_salary%found)
        loop
            dbms_output.put_line(m_faculty || ' ' || m_salary);
            fetch faculty_avg_salary into m_faculty, m_salary;
        end loop;
    close faculty_avg_salary;

    dbms_output.put_line('--------------- œÓ ‚ÒÂÏ Ù‡ÍÛÎ¸ÚÂÚ‡Ï -----------------');
    open faculties_avg_salary;
    fetch faculties_avg_salary into m_salary;
    dbms_output.put_line(round(m_salary, 2));
    close faculties_avg_salary;
end;
--8
declare
    type Team is record (
        TeamName varchar2(50),
        TeamSlogan varchar2(100)
        );
    type Player is record (
        PlayerName varchar2(100),
        PlayerNumber number,
        PlayerPosition varchar(20),
        PlayerTeam Team
        );
    team_info Team;
    player_info Player;
begin
    team_info := Team('Seattle Pilots', 'Fly high like soul!');
    player_info := Player('Johnathan Lamby', 21, 'Left Forward', team_info);

    dbms_output.put_line('Team: ' || team_info.TeamName);
    dbms_output.put_line('Slogan: ' || team_info.TeamSlogan);
    dbms_output.put_line('Player: ' || player_info.PlayerName);
    dbms_output.put_line('π: ' || player_info.PlayerNumber);
    dbms_output.put_line('Position: ' || player_info.PlayerPosition);
end;