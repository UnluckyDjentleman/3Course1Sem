BEGIN
    FOR i IN 1 .. 100000
        LOOP
            insert into users VALUES ('User' || i,'user'||i||'@gmail.com','qwe'||i, 'user');
        END LOOP;
END;