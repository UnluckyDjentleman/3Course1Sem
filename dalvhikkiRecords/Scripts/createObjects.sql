alter session set "_ORACLE_SCRIPT"=true;
alter session set container=freepdb1;
alter session set container=cdb$root;

show con_name;

create tablespace dalvhikkiRecords
datafile 'dalvhikkiRecords.dbf'
size 100m
autoextend on next 100m
maxsize unlimited
extent management local
segment space management auto;

drop tablespace dalvhikkiRecords including CONTENTS and DATAFILES;

create user developer
identified by qwert
default tablespace dalvhikkiRecords
temporary tablespace temp
quota unlimited on dalvhikkiRecords;

grant all privileges to developer;
grant create session to developer;
grant create user to developer;

--Users
create user guest identified by qwerty
default tablespace dalvhikkiRecords
temporary tablespace temp
quota unlimited on dalvhikkiRecords;

grant execute on GetAllSongs to guest;
grant execute on GetAllBands to guest;
grant execute on GetAllAlbums to guest;
grant execute on GetNewSongs to guest;
grant execute on GetNewAlbums to guest;
grant execute on GetMemberOfBand to guest;
grant execute on USER_REGISTRATION to guest;

create user admin identified by asdfg
default tablespace dalvhikkiRecords
temporary tablespace temp
quota unlimited on dalvhikkiRecords;

grant execute on GetAllSongs to admin;
grant execute on GetAllBands to admin;
grant execute on GetAllAlbums to admin;
grant execute on GetMemberOfBand to admin;
grant execute on GetNewSongs to admin;
grant execute on GetNewAlbums to admin;
grant execute on UpdateSong to admin;
grant execute on UpdateAlbum to admin;
grant execute on UpdateBand to admin;
grant execute on UpdateMemberOfBand to admin;
grant execute on AddSong to admin;
grant execute on AddAlbum to admin;
grant execute on AddBand to admin;
grant execute on AddMemberOfBand to admin;
grant execute on DeleteSong to admin;
grant execute on DeleteAlbum to admin;
grant execute on DeleteBand to admin;
grant execute on DeleteMemeberOfBand to admin;

create user authorized_user identified by zxcvb
default tablespace dalvhikkiRecords
temporary tablespace temp
quota unlimited on dalvhikkiRecords;

grant execute on GetAllSongs to authorized_user;
grant execute on GetAllBands to authorized_user;
grant execute on GetAllAlbums to authorized_user;
grant execute on GetMemberOfBand to authorized_user;
grant execute on GetNewSongs to guest;
grant execute on GetNewAlbums to guest;
grant execute on LikeSong to authorized_user;
grant execute on LikeAlbum to authorized_user;
grant execute on UnlikeSong to authorized_user;
grant execute on UnlikeAlbum to authorized_user;


--tables
create table USERS(
id number generated always as identity primary key,
name varchar2(30) not null,
email varchar2(30) not null,
password varchar2(32) not null,
role nvarchar2(20) not null check(role='admin' or role='user')
);
create table BANDS(
band_id number generated always as identity primary key,
band_name varchar2(50) not null,
band_location varchar2(50) not null,
band_genre varchar2(50) not null,
band_year_of_creation number not null check (band_year_of_creation>=1900 and band_year_of_creation<=2023),
band_logo varchar2(1000) not null
);
create table SONGS(
song_id number generated always as identity primary key,
band_id number not null,
album_id number not null,
song_name varchar2(50) not null,
song_release date not null,
song_likes_count number,
song_file varchar2(1000) not null,
constraint fk_band_id foreign key(band_id) references BANDS(band_id),
constraint fk_album_id foreign key(album_id) references ALBUMS(album_id)
);
create table ALBUMS(
album_id number generated always as identity primary key,
album_name varchar2(50) not null,
band_id number not null,
release_date date,
album_likes_count number,
album_photo varchar2(1000) not null,
constraint fk_album_band_id foreign key(band_id) references BANDS(band_id)
);
create table BAND_MEMBERS(
member_id number generated always as identity,
band_id number not null,
member_name varchar2(50) not null,
member_instrument varchar2(20) not null,
constraint fk_member_band_id foreign key(band_id) references BANDS(band_id)
);
create table LIKED_SONGS(
user_id number not null,
liked_song_id number not null,
constraint fk_user_id foreign key(user_id) references USERS(id),
constraint fk_song_id foreign key(liked_song_id) references SONGS(song_id)
);
create table LIKED_ALBUMS(
user_id number not null,
liked_album_id number not null,
constraint fk_user_liked_album_id foreign key(user_id) references USERS(id),
constraint fk_album_user_id foreign key(liked_album_id) references ALBUMS(album_id)
);

drop table USERS;
drop table BANDS;
drop table SONGS;
drop table ALBUMS;
drop table BAND_MEMBERS;
drop table LIKED_SONGS;
drop table LIKED_ALBUMS;
--Triggers&Indexes
create or replace trigger like_the_song
after insert on LIKED_SONGS
for each row
begin
    update songs set song_likes_count = song_likes_count + 1 where song_id = :new.liked_song_id;
end;


create or replace trigger unlike_the_song
after delete on LIKED_SONGS
for each row
begin
    update songs set song_likes_count = song_likes_count - 1 where song_id = :old.liked_song_id;
end;


create or replace trigger like_the_album
after insert on LIKED_ALBUMS
for each row
begin
    update albums set album_likes_count = album_likes_count + 1 where album_id = :new.liked_album_id;
end;


create or replace trigger unlike_the_album
after delete on LIKED_ALBUMS
for each row
begin
    update albums set album_likes_count = album_likes_count - 1 where album_id = :old.liked_album_id;
end;

create index USERS_INDEX on USERS(NAME);