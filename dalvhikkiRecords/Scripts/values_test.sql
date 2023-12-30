declare 
    l_cur sys_refcursor;
begin
developer.USER_REGISTRATION('User1','eee@gmail.com','1111','admin',l_cur);
commit;
end;

declare 
    l_cur sys_refcursor;
begin
developer.USER_REGISTRATION('Userooo','eee@gmail.com','1111','user',l_cur);
commit;
end;


select * from ALBUMS join LIKED_ALBUMS on ALBUMS.album_id=LIKED_ALBUMS.liked_album_id join USERS on USERS.id=LIKED_ALBUMS.user_id where LIKED_ALBUMS.user_id=2;
select * from SONGS join LIKED_SONGS on SONGS.song_id=LIKED_SONGS.liked_song_id join USERS on USERS.id=LIKED_SONGS.user_id where LIKED_SONGS.user_id=2;
select * from USERS where name='User1';

select * from developer.SONGS;

declare 
    l_cur sys_refcursor;
begin
developer.GetAllBands(l_cur);
end;

begin
dbms_output.put_line('Songs on label: '||developer.GETCOUNTOFSONGSONLABEL());
end;

commit;

select * from BANDS;

select * from Songs;

select * from SONGS join LIKED_SONGS on SONGS.song_id=LIKED_SONGS.liked_song_id join USERS on USERS.id=LIKED_SONGS.user_id where LIKED_SONGS.user_id=56;

declare 
    l_cur sys_refcursor;
begin
developer.GetAllSongs(l_cur);
end;

select * from USERS where name='User1' and password='qwe1';

set serveroutput on;

declare l_cur sys_refcursor;
begin
developer.AddBand('Pantera','Texas','Groove Metal',1981,'pantera_logo.jpeg');
commit;
end;

declare l_cur sys_refcursor;
begin
developer.AddBand('aaaa','bbbb','cccc',2023,'dddd');
commit;
end;

declare l_cur sys_refcursor;
begin
developer.AddBand('Slipknot','Des Moines','Nu Metal',1992,'slipknot.jpg');
commit;
end;

select * from BANDS;
delete from BANDS where band_id>=80;

begin
developer.AddBand('Rise Of the Northstar','Paris','Thrash Metal',2006,'roth.jpg');
commit;
end;


begin
developer.AddBand('Tool','Los Angeles','Progressive',1990,'tool_logo.jpg');
commit;
end;

begin
developer.UpdateBand('Meshuggah',4,'Omea','Math Metal',1987,'meshuggah_logo.jpg');
commit;
end;

begin
developer.DeleteBand(5);
commit;
end;

------


begin
developer.AddAlbum('ObZen',4,to_date(sysdate),'obzen.jpg');
commit;
end;

begin
developer.AddAlbum('Lateralus',3,to_date(sysdate),'lateralus.jpg');
commit;
end;

begin
developer.AddAlbum('Far Beyond Driven',1,to_date(sysdate),'fbd.jpg');
commit;
end;

begin
developer.AddAlbum('Showdown',2,to_date(sysdate),'showdown.jpg');
commit;
end;

select * from Songs;
select s.song_name, b.band_name from SONGS s join BANDS b on s.band_id=b.band_id;


---

begin
developer.AddSong(4,'Combustion',4,to_date(sysdate),'Combustion.mp3');
commit;
end;

begin
developer.UpdateSong(5,'Parabol',to_date(sysdate),'Parabol.mp3');
commit;
end;

begin
developer.AddSong(4,'Lethargica',4,to_date(sysdate),'Lethargica.mp3');
commit;
end;

begin
developer.AddSong(2,'5 Minutes Alone',1,to_date(sysdate),'Pantera - 5 Minutes Alone.mp3');
commit;
end;

select * from BANDS join ALBUMS on BANDS.band_id=ALBUMS.band_id;

begin
developer.AddSong(3,'Schism',3,to_date(sysdate),'Schism.mp3');
commit;
end;

begin
developer.AddSong(2,'Strength Beyond Strength',1,to_date(sysdate),'Strength Beyond Strength.mp3');
commit;
end;

begin
developer.AddSong(3,'Parabol',3,to_date(sysdate),'Parabol.mp3');
commit;
end;

begin
developer.AddSong(1,'Nekketsu',2,to_date(sysdate),'Nekketsu.mp3');
commit;
end;

begin
developer.DeleteSong(27);
commit;
end;

select * from ALBUMS where album_id=1;

select * from Albums join bands on Albums.band_id=Bands.band_id join Songs on songs.band_id=Bands.band_id;



---
begin
developer.AddMemberInBand(2,'Vithia','Vocal');
commit;
end;

begin
developer.AddMemberInBand(2,'Eva B','Guitar');
commit;
end;

begin
developer.AddMemberInBand(2,'Air One','Guitar');
commit;
end;

begin
developer.AddMemberInBand(2,'Fabulous Fab','Bass');
commit;
end;

begin
developer.AddMemberInBand(2,'Hokuto No Kev','Drums');
commit;
end;

select * from BAND_MEMBERS where band_id=2;

--

select band_name from developer.BANDS where band_id=9;

select * from developer.SONG_WITH_BAND_AND_GENRE;

declare 
    l_cur sys_refcursor;
begin
developer.LikeSong(106,1,l_cur);
commit;
end;


begin
developer.LikeSong(106,28);
commit;
end;

select * from SONGS;

begin
developer.UnlikeSong(106,1);
commit;
end;

begin
developer.UnlikeSong(3,1);
commit;
end;



select * from LIKED_SONGS;
select * from developer.SONGS;
select * from SONGS where album_id=2;
delete from LIKED_SONGS;
select * from BANDS;

select * from Albums;



update SONGS set songs.song_likes_count=0 where songs.song_id=21;
update SONGS set songs.song_likes_count=0 where songs.song_id=22;
update SONGS set songs.song_likes_count=0 where songs.song_id=24;
update SONGS set songs.song_likes_count=0 where songs.song_id=26;
update SONGS set songs.song_likes_count=0 where songs.song_id=28;
update SONGS set songs.song_likes_count=0 where songs.song_id=29;
update SONGS set songs.song_likes_count=0 where songs.song_id=30;
commit;