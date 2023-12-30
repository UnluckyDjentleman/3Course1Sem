create view developer.SONG_WITH_BAND_AND_GENRE as
select SONGS.song_id as song_id, SONGS.song_name as track_name, BANDS.band_genre as genre,BANDS.band_name as band, SONGS.song_file as music_file 
from SONGS join BANDS on SONGS.band_id=BANDS.band_id;

drop view developer.SONG_WITH_BAND_AND_GENRE;

create view developer.ALBUM_WITH_BAND_AND_GENRE as
select distinct albums.album_id, Albums.album_name, BANDS.band_genre as genre,BANDS.band_name as band 
from SONGS join BANDS on SONGS.band_id=BANDS.band_id join ALBUMS on SONGS.album_id=ALBUMS.album_id;

drop view developer.ALBUM_WITH_BAND_AND_GENRE;