create or replace PROCEDURE USER_REGISTRATION
    (user_name varchar2,user_email varchar2,user_password varchar2,user_role nvarchar2,cur out sys_refcursor) is
    usernames number;
    useremails number;
    begin
    select count(*) into usernames from USERS where name=user_name;
    select count(*) into useremails from USERS where name=user_email;
        if usernames>0 then
            raise_application_error(-20001,'Person with such name already exists');
        elsif useremails>0 then
            raise_application_error(-20001,'User with such email already exists');
        else
            insert into USERS(name,email,password,role) values (user_name,user_email,user_password,user_role);
        end if;
        open cur for select * from USERS where name=user_name;
end USER_REGISTRATION;
   
drop procedure USER_REGISTRATION;   
--Get procedures
create or replace procedure getUserRoleByUserId(user_id_ number, cur out sys_refcursor) as
begin
open cur for select role from USERS where id=user_id_;
end getUserRoleByUserId;

create or replace procedure GetAllSongs(cur out sys_refcursor) as
begin
open cur for select * from SONGS;
end GetAllSongs;

create or replace procedure GetAllAlbums(cur out sys_refcursor) as
begin
open cur for select * from ALBUMS;
end GetAllAlbums;

create or replace procedure GetUserByNameAndPassword(nameOfUser varchar2, passwordOfUser varchar2, cur out sys_refcursor) as
begin
open cur for select * from USERS where name=nameOfUser and password=passwordOfUser;
end GetUserByNameAndPassword;

create or replace procedure GetUserById(idUser number, cur out sys_refcursor) as
begin
open cur for select * from USERS where id=idUser;
end GetUserById;

create or replace procedure GetAllBands(cur out sys_refcursor) 
as
begin
open cur for select * from BANDS;
end GetAllBands;

select * from Bands;

create or replace procedure GetMembersOfBand (id number, cur out sys_refcursor) as
begin
open cur for select member_id, band_id, member_name, member_instrument from BAND_MEMBERS where band_id=id;
end GetMembersOfBand;

create or replace procedure GetMemberOfBand (bandid number, memberid number, cur out sys_refcursor) as
begin
open cur for select member_id, band_id, member_name, member_instrument from BAND_MEMBERS where band_id=bandid and member_id=memberid;
end GetMemberOfBand;

create or replace procedure GetSongsOfAlbum (id number, cur out sys_refcursor) as
begin
open cur for select * from Songs where album_id=id;
end GetSongsOfAlbum;

create or replace procedure GetCurrentUser(login varchar2, pass varchar2, cur out sys_refcursor) as
begin
open cur for select * from USERS where name=login and password=pass;
end GetCurrentUser;

commit;

create or replace procedure GetNewSongs(cur out sys_refcursor) as
begin
open cur for select * from SONGS where rownum<=6 order by song_release desc;
end GetNewSongs;

create or replace procedure GetNewAlbums(cur out sys_refcursor) as
begin
open cur for select * from ALBUMS where rownum<=6 order by release_date desc;
end GetNewAlbums;

create or replace procedure GetBestSongs(cur out sys_refcursor) as
begin
open cur for select * from SONGS where rownum<=6 order by song_likes_count desc;
end GetBestSongs;

create or replace procedure GetBestAlbums(cur out sys_refcursor) as
begin
open cur for select * from ALBUMS where rownum<=6 order by album_likes_count desc;
end GetBestAlbums;

create or replace procedure GetBandNameByBandId(bandid number,cur out sys_refcursor) as
begin
open cur for select * from Bands where band_id=bandid;
end GetBandNameByBandId;

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

create or replace PROCEDURE GetAllLikedSongsById(userId number, cur out sys_refcursor) as
begin
open cur for select * from SONGS join LIKED_SONGS on SONGS.song_id=LIKED_SONGS.liked_song_id join USERS on USERS.id=LIKED_SONGS.user_id where LIKED_SONGS.user_id=userId;
end GetAllLikedSongsById;

commit;

create or replace PROCEDURE GetLikedSongBySongIdAndUserId(userId number, songId number, cur out sys_refcursor) as
begin
open cur for select * from LIKED_SONGS where user_id=userId and liked_song_id=songId;
end GetLikedSongBySongIdAndUserId;

create or replace PROCEDURE GetAllLikedAlbumsById(userId number, cur out sys_refcursor) as
begin
open cur for select * from ALBUMS join LIKED_ALBUMS on ALBUMS.album_id=LIKED_ALBUMS.liked_album_id join USERS on USERS.id=LIKED_ALBUMS.user_id where LIKED_ALBUMS.user_id=userId;
end GetAllLikedAlbumsById;



create or replace PROCEDURE GetBandByBandId(id number, cur out sys_refcursor) as
begin
open cur for select * from BANDS where band_id=id;
end GetBandByBandId;

create or replace PROCEDURE GetSongBySongId(id number, cur out sys_refcursor) as
begin
open cur for select * from SONGS where song_id=id;
end GetSongBySongId;

--Add - Procedures

create or replace procedure AddSong(albumid number, songname varchar2, bandid number, songrelease date, songfile varchar2) as
begin
insert into SONGS(band_id,album_id,song_name,song_release,song_likes_count,song_file) values (bandid,albumid, songname, songrelease, 0, songfile);
dbms_output.put_line('Added new song in album with id: '||albumid||' by the band with id '||bandid);
exception
    when others then
        raise_application_error(-20001,'Cannot add song because of wrong data');
end AddSong;

create or replace procedure AddAlbum(albumname varchar2, bandid number, albrelease date, albphoto varchar2) as
begin
insert into ALBUMS(album_name,band_id,release_date,album_likes_count, album_photo) values (albumname, bandid, albrelease,0,albphoto);
dbms_output.put_line('Added new album by band with id: '||bandid);
exception
    when others then
        raise_application_error(-20001,'Cannot add album because of wrong data');
end AddAlbum;

create or replace procedure AddBand(bandname varchar2, bandlocation varchar2, bandgenre varchar2, yearofcreation number,bandlogo varchar2) as
begin
insert into BANDS(band_name, band_location, band_genre, band_year_of_creation, band_logo) values(bandname, bandlocation, bandgenre, yearofcreation, bandlogo);
dbms_output.put_line('Added new band: '||bandname);
exception
        when others
            then raise_application_error(-20001,'Cannot add band because of wrong data');
end AddBand;

create or replace procedure AddMemberInBand(bandid number, membername varchar2, memberrole varchar2) as
begin
insert into BAND_MEMBERS(band_id, member_name, member_instrument) values(bandid, membername, memberrole);
dbms_output.put_line('Added'||membername||' in the band with id: '||bandid);
exception
    when others then
        raise_application_error(-20001,'Cannot add member in the band because of wrong data');
end AddMemberInBand;

--Update procedures

create or replace procedure UpdateSong(id number, songname varchar2, songfile varchar2) as
begin
update SONGS set song_name=songname, song_file=songfile where song_id=id;
dbms_output.put_line('Updated song with id'||id);
exception
    when others then
        raise_application_error(-20001,'Cannot update song! Please check data');
end UpdateSong;

create or replace procedure UpdateAlbum(albumname varchar2, albumid number, albumphoto varchar2) as
begin
update ALBUMS set album_name=albumname, album_photo=albumphoto where album_id=albumid;
dbms_output.put_line('Updated album with id '||albumid);
exception
    when others then
        raise_application_error(-20001,'Cannot update band! Please check data');
end UpdateAlbum;

create or replace procedure UpdateBand(bandname varchar2, bandid number, bandlocation varchar2, bandgenre varchar2, yearofcreation number, bandlogo varchar2) as
begin
update BANDS set band_name=bandname, band_location=bandlocation, band_genre=bandgenre, band_year_of_creation=yearofcreation, band_logo=bandlogo where band_id=bandid;
dbms_output.put_line('Updated band with id'||bandid);
exception
    when others then
        raise_application_error(-20001,'Cannot update band! Please check data');
end UpdateBand;

create or replace procedure UpdateMemberInBand(memberid number,membername varchar2, memberrole varchar2) as
begin
update BAND_MEMBERS set member_name=membername, member_instrument=memberrole where member_id=memberid;
dbms_output.put_line('Updated band member with id'||memberid);
exception
    when others then
        raise_application_error(-20001,'Cannot update band! Please check data');
end UpdateMemberInBand;

--Delete procedures

create or replace procedure DeleteSong (id number) as
begin 
delete from Songs where song_id=id;
dbms_output.put_line('Song '||id||' was removed');
exception
    when others then
        raise_application_error(-20001,'Cannot delete song');
end DeleteSong;

create or replace procedure DeleteBand (id number) as
begin
delete from BANDS where band_id=id;
dbms_output.put_line('Band '||id||' was removed');
exception
    when others then
        raise_application_error(-20001,'Cannot delete band');
end DeleteBand;

create or replace procedure DeleteMemberOfBand (id number) as
begin
delete from BAND_MEMBERS where member_id=id;
dbms_output.put_line('Band member'||id||' was removed');
exception
    when others then
        raise_application_error(-20001,'Cannot delete band member');
end DeleteMemberOfBand;

create or replace procedure DeleteAlbum (id number) as
begin
delete from ALBUMS where album_id=id;
dbms_output.put_line('Album '||id||' was removed');
exception
    when others then
        raise_application_error(-20001,'Cannot delete album');
end DeleteAlbum;

--like/unlike songs/albums
create or replace procedure LikeSong(user_id_ number, song_id_ number) as
begin
insert into LIKED_SONGS values(user_id_,song_id_);
dbms_output.put_line('User with id '||user_id_||' liked the song with id '||song_id_);
exception
    when others then
        raise_application_error(-20001,'Oops... There is nothing we can do');
end LikeSong;

create or replace procedure LikeAlbum(user_id_ number, album_id_ number) as
begin
insert into LIKED_ALBUMS values(user_id_,album_id_);
dbms_output.put_line('User with id '||user_id_||' liked the album with id '||album_id_);
exception
    when others then
        raise_application_error(-20001,'Oops... There is nothing we can do');
end LikeAlbum;

--Function
create or replace function GETCOUNTOFSONGSONLABEL return number is
rc number(6);
begin
    select count(*) into rc from SONGS;
    return rc;
end GETCOUNTOFSONGSONLABEL;
