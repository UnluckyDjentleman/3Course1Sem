BEGIN
    FOR i IN 1 .. 100000
        LOOP
            insert into users(name, email, password, role) VALUES ('User' || i,'user'||i||'@gmail.com','qwe'||i, 'user');
        END LOOP;
END;

select * from USERS where name='User1';
delete from USERS;