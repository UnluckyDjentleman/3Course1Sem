alter session set "_ORACLE_SCRIPT"=true;
--alter session set container=freepdb1;
--alter session set container=cdb$root;

show con_name;

commit;

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

grant connect,create session to guest;
grant create session to guest;
grant execute on GetAllSongs to guest;
grant execute on GetAllBands to guest;
grant execute on GetAllAlbums to guest;
grant execute on GetNewSongs to guest;
grant execute on GetBandNameByBandId to guest;
grant execute on GetBandByBandId to guest;
grant execute on GetNewAlbums to guest;
grant execute on GetMembersOfBand to guest;
grant execute on USER_REGISTRATION to guest;
grant execute on GetBestSongs to guest;
grant execute on GetBestAlbums to guest;
grant execute on GetAlbumById to guest;
grant execute on GetAlbumByBandId to guest;
grant execute on GetSongsByAlbumId to guest;
grant execute on GetUserByNameAndPassword to guest;
grant execute on  FullTextSearchBandsByFuzzy to guest;
grant execute on  FullTextSearchBands to guest;
grant execute on  FullTextSearchAlbumsByFuzzy to guest;
grant execute on  FullTextSearchSongsByFuzzy to guest;
grant execute on  FullTextSearchSongs to guest;
grant execute on  FullTextSearchAlbums to guest;

create user admin identified by asdfg
default tablespace dalvhikkiRecords
temporary tablespace temp
quota unlimited on dalvhikkiRecords;

grant connect to admin;
grant create session to admin;
grant execute on GetAllSongs to admin;
grant execute on GetAllBands to admin;
grant execute on GetAllAlbums to admin;
grant execute on GetMembersOfBand to admin;
grant execute on GetMemberOfBand to admin;
grant execute on GetNewSongs to admin;
grant execute on GetNewAlbums to admin;
grant execute on GetBestSongs to admin;
grant execute on GetBestAlbums to admin;
grant execute on GetBandNameByBandId to admin;
grant execute on GetSongBySongId to admin;
grant execute on GetBandByBandId to admin;
grant execute on UpdateSong to admin;
grant execute on UpdateAlbum to admin;
grant execute on UpdateBand to admin;
grant execute on UpdateMemberInBand to admin;
grant execute on AddSong to admin;
grant execute on AddAlbum to admin;
grant execute on AddBand to admin;
grant execute on AddMemberInBand to admin;
grant execute on DeleteSong to admin;
grant execute on DeleteAlbum to admin;
grant execute on DeleteBand to admin;
grant execute on DeleteMemberOfBand to admin;
grant execute on getUserRoleByUserId to admin;
grant execute on GetAlbumById to admin;
grant execute on GetAlbumByBandId to admin;
grant execute on GetSongsByAlbumId to admin;
grant execute on GetCurrentUser to admin;
grant execute on GetUserByNameAndPassword to admin;
grant execute on  FullTextSearchBandsByFuzzy to admin;
grant execute on  FullTextSearchBands to admin;
grant execute on  FullTextSearchAlbumsByFuzzy to admin;
grant execute on  FullTextSearchSongsByFuzzy to admin;
grant execute on  FullTextSearchSongs to admin;
grant execute on  FullTextSearchAlbums to admin;
grant execute on  XmlImport to admin;
grant execute on  XmlExport to admin;

commit;

create user authorized_user identified by zxcvb
default tablespace dalvhikkiRecords
temporary tablespace temp
quota unlimited on dalvhikkiRecords;

grant connect to authorized_user;
grant create session to authorized_user;
grant execute on GetLikedSongBySongIdAndUserId to authorized_user;
grant execute on GetAllSongs to authorized_user;
grant execute on GetAllBands to authorized_user;
grant execute on GetAllAlbums to authorized_user;
grant execute on GetMembersOfBand to authorized_user;
grant execute on GetNewSongs to authorized_user;
grant execute on GetNewAlbums to authorized_user;
grant execute on GetBestSongs to authorized_user;
grant execute on GetBestAlbums to authorized_user;
grant execute on GetBandNameByBandId to authorized_user;
grant execute on GetAllLikedSongsById to authorized_user;
grant execute on GetAllLikedAlbumsById to authorized_user;
grant execute on GetBandByBandId to authorized_user;
grant execute on LikeSong to authorized_user;
grant execute on LikeAlbum to authorized_user;
grant execute on GetAlbumById to authorized_user;
grant execute on GetAlbumByBandId to authorized_user;
grant execute on GetSongsByAlbumId to authorized_user;
grant execute on GetCurrentUser to authorized_user;
grant execute on GetUserByNameAndPassword to authorized_user;

commit;

--tables
create table USERS(
id number generated always as identity primary key,
name varchar2(30) not null,
email varchar2(30) not null,
password varchar2(32) not null,
role nvarchar2(20) not null check(role in ('user','admin'))
);

alter table USERS add constraint unique_user unique(id,name,email,password);

create table BANDS(
band_id number generated always as identity primary key,
band_name varchar2(50) not null,
band_location varchar2(50) not null,
band_genre varchar2(50) not null,
band_year_of_creation number not null check (band_year_of_creation>=1900 and band_year_of_creation<=2023),
band_logo varchar2(1000) not null
);

alter table BANDS add constraint unique_band unique(band_id, band_name, band_logo);

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

alter table SONGS add constraint unique_song unique(song_id, song_file);

create table ALBUMS(
album_id number generated always as identity primary key,
album_name varchar2(50) not null,
band_id number not null,
release_date date,
album_likes_count number,
album_photo varchar2(1000) not null,
constraint fk_album_band_id foreign key(band_id) references BANDS(band_id)
);

alter table ALBUMS add constraint unique_album unique(album_id, album_photo);

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
delete from liked_songs;
--Triggers&Indexes
create or replace trigger like_the_song
after insert on LIKED_SONGS
for each row
begin
    update songs set song_likes_count = song_likes_count + 1 where song_id = :new.liked_song_id;
end;

create or replace trigger like_the_album
after insert on LIKED_ALBUMS
for each row
begin
    update albums set album_likes_count = album_likes_count + 1 where album_id = :new.liked_album_id;
end;

CREATE OR REPLACE TRIGGER DeleteBandsTrigger
AFTER DELETE ON Bands
FOR EACH ROW
BEGIN
    DELETE FROM Albums WHERE band_id = :old.band_id;
    DELETE FROM Songs WHERE band_id = :old.band_id;
    DELETE FROM BAND_MEMBERS where band_id=:old.band_id;
END;

CREATE OR REPLACE TRIGGER DeleteUsersTrigger
AFTER DELETE ON USERS
FOR EACH ROW
BEGIN
    DELETE FROM Liked_Songs WHERE user_id = :old.id;
    Delete from Liked_albums where user_id = :old.id;
END;

drop trigger DeleteAlbumsTrigger;

CREATE OR REPLACE TRIGGER DeleteSongsTrigger
AFTER DELETE ON Albums
FOR EACH ROW
BEGIN
    DELETE FROM Songs WHERE album_id = :old.album_id;
    DELETE FROM LIKED_ALBUMS where liked_album_id=:old.album_id;
END;

CREATE OR REPLACE TRIGGER DeleteSongTrigger
AFTER DELETE ON Songs
FOR EACH ROW
BEGIN
    DELETE FROM LIKED_SONGS WHERE liked_song_id = :old.song_id;
END;

create or replace trigger like_the_album
after insert on LIKED_ALBUMS
for each row
begin
    update albums set album_likes_count = album_likes_count + 1 where album_id = :new.liked_album_id;
end;

create index USERS_INDEX on USERS(NAME);
drop index USERS_INDEX;