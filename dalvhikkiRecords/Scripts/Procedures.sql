create PROCEDURE USER_REGISTRATION
    (user_name varchar2,user_email varchar2,user_password varchar2,user_role nvarchar2) as 
    begin
        insert into USERS(name,email,password,role) values (user_name,user_email,user_password,user_role);
    end USER_REGISTRATION;
    
--Get procedures

create or replace procedure GetAllBands(cur out sys_refcursor) as
begin
open cur for select band_id, band_name, band_location, band_genre, band_year_of_creation, band_logo from BANDS;
end GetAllBands;

create or replace procedure GetMembersOfBand (id number, cur out sys_refcursor) as
begin
open cur for select member_id, band_id, member_name, member_instrument from BAND_MEMBERS where band_id=id;
end GetMembersOfBand;

create or replace procedure GetSongsOfAlbum (id number, cur out sys_refcursor) as
begin
open cur for select * from Songs where album_id=id;
end GetSongsOfAlbum;

create or replace procedure GetCurrentUser(login varchar2, pass varchar2, cur out sys_refcursor) as
begin
open cur for select * from USERS where name=login and password=pass;
end GetCurrentUser;

create or replace procedure GetNewSongs(cur out sys_refcursor) as
begin
open cur for select * from SONGS where rownum<=6 order by song_release ;
end GetNewSongs;

create or replace procedure GetNewAlbums(cur out sys_refcursor) as
begin
open cur for select * from ALBUMS where rownum<=6 order by release_date;
end GetNewAlbums;

create or replace procedure GetBestSongs(cur out sys_refcursor) as
begin
open cur for select * from SONGS where rownum<=6 order by song_likes_count;
end GetBestSongs;

create or replace procedure GetBestAlbums(cur out sys_refcursor) as
begin
open cur for select * from ALBUMS where rownum<=6 order by album_likes_count;
end GetBestAlbums;

create or replace PROCEDURE GetAlbumById(id number, cur out sys_refcursor) as
begin
open cur for select * from Albums where album_id=id;
end GetAlbumById;

create or replace PROCEDURE GetAlbumByBandId(id number, cur out sys_refcursor) as
begin
open cur for select * from Albums where band_id=id;
end GetAlbumByBandId;

create or replace PROCEDURE GetSongsByAlbumId(id number, cur out sys_refcursor) as
begin
open cur for select * from SONGS where album_id=id;
end GetSongsByAlbumId;

create or replace PROCEDURE GetAllLikedSongsById(id number, cur out sys_refcursor) as
begin
open cur for select * from LIKED_SONGS where user_id=id;
end GetAllLikedSongsById;

create or replace PROCEDURE GetAllLikedAlbumsById(id number, cur out sys_refcursor) as
begin
open cur for select * from LIKED_ALBUMS where user_id=id;
end GetAllLikedAlbumsById;

--Add - Procedures

create or replace procedure AddSong(songname varchar2, bandid number, songrelease date, songfile varchar2) as
begin
insert into SONGS(band_id,song_name,song_release,song_likes_count,song_file) values (bandid, songname, songrelease, 0, songfile);
end AddSong;

create or replace procedure AddAlbum(albumname varchar2, bandid number, albrelease varchar2, albphoto varchar2) as
begin
insert into ALBUMS(album_name,band_id,release_date,album_likes_count, album_photo) values (albumname, bandid, albrelease,0,albphoto);
end AddAlbum;

create or replace procedure AddBand(bandname varchar2, bandlocation varchar2, bandgenre varchar2, yearofcreation number) as
begin
insert into BANDS(band_name, band_location, band_genre, band_year_of_creation) values(bandname, bandlocation, bandgenre, yearofcreation);
end AddBand;

create or replace procedure AddMemberInBand(bandid number, membername varchar2, memberrole varchar2) as
begin
insert into BAND_MEMBERS(band_id, member_name, member_instrument) values(bandid, membername, memberrole);
end AddMemberInBand;

--Update procedures

create or replace procedure UpdateSong(songname varchar2, bandid number, songrelease date, songfile varchar2) as
begin
update SONGS set song_name=songname, song_release=songrelease, song_file=songfile where band_id=bandid;
end UpdateSong;

create or replace procedure UpdateAlbum(albumname varchar2, bandid number, songrelease date, albumphoto varchar2) as
begin
update ALBUMS set album_name=albumname, release_date=songrelease, album_photo=albumphoto where band_id=bandid;
end UpdateAlbum;

create or replace procedure UpdateBand(bandname varchar2, bandid number, bandlocation varchar2, bandgenre varchar2, yearofcreation number) as
begin
update BANDS set band_name=bandname, band_location=bandlocation, band_genre=bandgenre, band_year_of_creation=yearofcreation where band_id=bandid;
end UpdateBand;

create or replace procedure UpdateMemberInBand(memberid number,membername varchar2, memberrole varchar2) as
begin
update BAND_MEMBERS set member_name=membername, member_instrument=memberrole where member_id=memberid;
end UpdateMemberInBand;

--Delete procedures

create or replace procedure DeleteSong (id number) as
begin 
delete from Songs where song_id=id;
end DeleteSong;

create or replace procedure DeleteBand (id number) as
begin
delete from BANDS where band_id=id;
end DeleteBand;

create or replace procedure DeleteMemberOfBand (id number) as
begin
delete from BAND_MEMBERS where member_id=id;
end DeleteMemberOfBand;

create or replace procedure DeleteAlbum (id number) as
begin
delete from ALBUMS where album_id=id;
end DeleteAlbum;

--like/unlike songs/albums
create or replace procedure LikeSong(user_id_ number, song_id_ number, cur out sys_refcursor) as
begin
insert into LIKED_SONGS values(user_id_,song_id_);
open cur for select t.song_id      as music_id,
               t.TRACK_NAME      as music_name,
               genre,
               band,
               song_file
        from song_with_Band_And_Genre t
                 left join SONGS on t.SONG_ID = SONGS.SONG_ID left join USERS on USERS.id=user_id_;
end LikeSong;

create or replace procedure LikeAlbum(user_id_ number, album_id_ number, cur out sys_refcursor) as
begin
insert into LIKED_ALBUMS values(album_id_,user_id_);
open cur for select t.album_id      as alb_id,
               t.ALBUM_NAME      as alb_name,
               genre,
               band
        from album_with_Band_And_Genre t
                 left join ALBUMS on t.ALBUM_ID = ALBUMS.ALBUM_ID  left join USERS on USERS.id=user_id_;
end LikeAlbum;

create or replace procedure UnlikeSong(user_id_ number, song_id_ number, cur out sys_refcursor) as
begin
open cur for select t.song_id      as music_id,
               t.TRACK_NAME      as music_name,
               genre,
               band,
               song_file
        from song_with_Band_And_Genre t
                 left join SONGS on t.SONG_ID = SONGS.SONG_ID left join USERS on USERS.id=user_id_;
delete from LIKED_SONGS where liked_song_id=song_id_ and user_id=user_id_;
end UnlikeSong;

create or replace procedure UnlikeAlbum(user_id_ number, album_id_ number, cur out sys_refcursor) as
begin
open cur for select t.album_id      as alb_id,
               t.ALBUM_NAME      as alb_name,
               genre,
               band
        from album_with_Band_And_Genre t
                 left join ALBUMS on t.ALBUM_ID = ALBUMS.ALBUM_ID left join USERS on USERS.id=user_id_;
delete from LIKED_ALBUMS where liked_album_id=album_id_ and user_id=user_id_;
end UnlikeAlbum;