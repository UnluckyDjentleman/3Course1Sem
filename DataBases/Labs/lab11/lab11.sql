set serveroutput on;
--1
create or replace procedure u1_gvs_pdb.getTeachers(PCODE teacher.pulpit%type)
is
cursor getTeacher is select teacher,teacher_name,pulpit from teacher where pulpit=pcode;
in_teacher teacher.teacher%type;
name_teacher teacher.teacher_name%type;
pulp_teacher teacher.pulpit%type;
begin
    open getTeacher;
    fetch getTeacher into in_teacher, name_teacher, pulp_teacher;
    while (getTeacher%found)
        loop
            dbms_output.put_line(in_teacher||' '||name_teacher||' '||pulp_teacher);
            fetch getTeacher into in_teacher, name_teacher, pulp_teacher;
        end loop;
    close getTeacher;
end getTeachers;

begin
getTeachers('»—Ë“');
end;
--2
create or replace function U1_gvs_PDB.GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE)
return number
is
    result_num number;
begin
    select count(TEACHER) into result_num from TEACHER where PULPIT=PCODE;
    return result_num;
end GET_NUM_TEACHERS;

begin
DBMS_OUTPUT.PUT_LINE(get_num_teachers('»—Ë“'));
end;
--3
create or replace procedure U1_gvs_PDB.GET_TEACHERS_BY_FACULTY (FCODE FACULTY.FACULTY%TYPE)
    is
    cursor GetTeachersByFaculty is
        select TEACHER, TEACHER_NAME, P.PULPIT
        from TEACHER inner join PULPIT P on P.PULPIT = TEACHER.PULPIT
        where FACULTY = FCODE;

    m_teacher      TEACHER.TEACHER%TYPE;
    m_teacher_name TEACHER.TEACHER_NAME%TYPE;
    m_pulpit       TEACHER.PULPIT%TYPE;
begin
    open GetTeachersByFaculty;
    fetch GetTeachersByFaculty into m_teacher, m_teacher_name, m_pulpit;

    while (GetTeachersByFaculty%found)
    loop
        DBMS_OUTPUT.PUT_LINE(m_teacher || ' ' || m_teacher_name || ' ' || m_pulpit);
        fetch GetTeachersByFaculty into m_teacher, m_teacher_name, m_pulpit;
    end loop;

    close GetTeachersByFaculty;

end GET_TEACHERS_BY_FACULTY;

begin
    GET_TEACHERS_BY_FACULTY('À’‘');
end;

create or replace procedure U1_gvs_PDB.GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
is
    cursor GetSubjects is
    select * from SUBJECT where PULPIT=PCODE;

    m_subject SUBJECT.SUBJECT%type;
    m_subject_name SUBJECT.SUBJECT_NAME%type;
    m_pulpit SUBJECT.PULPIT%type;
begin
    open GetSubjects;
    fetch GetSubjects into m_subject, m_subject_name, m_pulpit;

    while (GetSubjects%found)
    loop
        DBMS_OUTPUT.PUT_LINE(m_subject || ' ' || m_subject_name || ' ' || m_pulpit);
        fetch GetSubjects into m_subject, m_subject_name, m_pulpit;
    end loop;
    close GetSubjects;

end GET_SUBJECTS;

begin
    GET_SUBJECTS('œŒË—Œ»');
end;
--4
create or replace function U1_GVS_PDB.FGET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
return number
is
    result_num number;
begin
    select count(TEACHER) into result_num from TEACHER
                          where TEACHER.PULPIT in (select PULPIT from PULPIT where FACULTY=FCODE);
    return result_num;
end FGET_NUM_TEACHERS;

begin
dbms_output.put_line(FGET_NUM_TEACHERS('’“Ë“'));
end;

create or replace function U1_GVS_PDB.GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) return number
is
    result_num number;
begin
    select count(SUBJECT) into result_num from SUBJECT where PULPIT=PCODE;
    return result_num;
end GET_NUM_SUBJECTS;

begin
dbms_output.put_line(GET_NUM_SUBJECTS('»—Ë“'));
end;
--5
create or replace package TEACHERS as
  --FCODE FACULTY.FACULTY%type;
  --PCODE SUBJECT.PULPIT%type;
  procedure GETTEACHERS(FCODE FACULTY.FACULTY%type);
  procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%type);
  function FGET_NUM_TEACHERS(FCODE FACULTY.FACULTY%type) return number;
  function GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%type) return number;
end TEACHERS;

create or replace package body TEACHERS
is
    procedure GETTEACHERS(FCODE FACULTY.FACULTY%TYPE)
        is
        cursor GetTeachersByFaculty is
            select TEACHER, TEACHER_NAME, P.PULPIT
            from TEACHER
                     inner join PULPIT P on P.PULPIT = TEACHER.PULPIT
            where FACULTY = FCODE;
        m_teacher      TEACHER.TEACHER%TYPE;
        m_teacher_name TEACHER.TEACHER_NAME%TYPE;
        m_pulpit       TEACHER.PULPIT%TYPE;
    begin
        open GetTeachersByFaculty;
        fetch GetTeachersByFaculty into m_teacher, m_teacher_name, m_pulpit;

        while (GetTeachersByFaculty%found)
            loop
                DBMS_OUTPUT.PUT_LINE(m_teacher || ' ' || m_teacher_name || ' ' || m_pulpit);
                fetch GetTeachersByFaculty into m_teacher, m_teacher_name, m_pulpit;
            end loop;

        close GetTeachersByFaculty;

    end GETTEACHERS;
    procedure GET_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE)
        is
        cursor GetSubjects is
            select *
            from SUBJECT
            where PULPIT = PCODE;
        m_subject      SUBJECT.SUBJECT%type;
        m_subject_name SUBJECT.SUBJECT_NAME%type;
        m_pulpit       SUBJECT.PULPIT%type;
    begin
        open GetSubjects;
        fetch GetSubjects into m_subject, m_subject_name, m_pulpit;

        while (GetSubjects%found)
            loop
                DBMS_OUTPUT.PUT_LINE(m_subject || ' ' || m_subject_name || ' ' || m_pulpit);
                fetch GetSubjects into m_subject, m_subject_name, m_pulpit;
            end loop;
        close GetSubjects;

    end GET_SUBJECTS;
    function FGET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE)
        return number
        is
        result_num number;
    begin
        select count(TEACHER)
        into result_num
        from TEACHER
        where TEACHER.PULPIT in (select PULPIT from PULPIT where FACULTY = FCODE);
        return result_num;
    end FGET_NUM_TEACHERS;
    function GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) return number
        is
        result_num number;
    begin
        select count(SUBJECT) into result_num from SUBJECT where PULPIT = PCODE;
        return result_num;
    end GET_NUM_SUBJECTS;
begin
    null;
end TEACHERS;
--6
begin
  DBMS_OUTPUT.PUT_LINE('Number of faculty teachers: ' || TEACHERS.FGET_NUM_TEACHERS('»ƒËœ'));
  DBMS_OUTPUT.PUT_LINE('Number of subject on pulpit: ' || TEACHERS.GET_NUM_SUBJECTS('»—Ë“'));
  DBMS_OUTPUT.PUT_LINE('------------------------');
  TEACHERS.GETTEACHERS('»ƒËœ');
  DBMS_OUTPUT.PUT_LINE('------------------------');
  TEACHERS.GET_SUBJECTS('»—Ë“');
end;