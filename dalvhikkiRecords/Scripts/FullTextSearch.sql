--sqlplus / as sysdba
--@$ORACLE_HOME/ctx/admin/catctx.sql oracle123 sysaux temp nolock

grant CTXAPP to developer;


GRANT EXECUTE ON CTXSYS.CTX_DDL TO developer;
GRANT EXECUTE ON CTXSYS.CTX_DOC TO developer;
GRANT EXECUTE ON CTXSYS.CTX_OUTPUT TO developer;
GRANT EXECUTE ON CTXSYS.CTX_QUERY TO developer;
GRANT EXECUTE ON CTXSYS.CTX_REPORT TO developer;
GRANT EXECUTE ON CTXSYS.CTX_THES TO developer;
GRANT EXECUTE ON CTXSYS.CTX_ULEXER TO developer;

begin
    ctx_ddl.create_preference('my_wordlist','BASIC_WORDLIST');
    --CTX_DDL.CREATE_stoplist('default_stoplist');
    ctx_ddl.create_preference('my_lexer', 'BASIC_LEXER');
    ctx_ddl.set_attribute('my_lexer', 'INDEX_STEMS', 'ENGLISH');
end;

begin
    ctx_ddl.drop_preference('my_wordlist');
    ctx_ddl.drop_preference('my_lexer');
    --ctx_ddl.drop_stoplist('default_stoplist');
end;

create index song_name_idx on SONGS (SONG_NAME) indextype is CTXSYS.CONTEXT parameters('LEXER my_lexer WORDLIST my_wordlist STOPLIST default_stoplist SYNC(on commit)');

select * from SONGS where contains(song_name,'fuzzy(Combustioe)')>0;

select * from SONGS;

select * from BANDS;

create index index_for_bands on BANDS(band_name) indextype is ctxsys.context parameters('LEXER my_lexer WORDLIST my_wordlist STOPLIST default_stoplist SYNC(on commit)');

create index index_for_albums on ALBUMS(album_name) indextype is ctxsys.context parameters('LEXER my_lexer WORDLIST my_wordlist STOPLIST default_stoplist SYNC(on commit)');

create or replace procedure FullTextSearchSongs(search_string varchar2, cur out sys_refcursor)
as
begin
open cur for select * from SONGS where contains(song_name, search_string)>0;
end FullTextSearchSongs;

create or replace procedure FullTextSearchBands(search_string varchar2, cur out sys_refcursor)
as
begin
open cur for select * from BANDS where contains(band_name, search_string)>0;
end FullTextSearchBands;

create or replace procedure FullTextSearchAlbums(search_string varchar2, cur out sys_refcursor)
as
begin
open cur for select * from ALBUMS where contains(album_name, search_string)>0;
end FullTextSearchAlbums;

create or replace procedure FullTextSearchSongsByFuzzy(search_string varchar2, cur out sys_refcursor)
as
begin
open cur for select * from SONGS where contains(song_name, 'fuzzy('||search_string||')')>0;
end FullTextSearchSongsByFuzzy;

create or replace procedure FullTextSearchBandsByFuzzy(search_string varchar2, cur out sys_refcursor)
as
begin
open cur for select * from BANDS where contains(band_name, 'fuzzy('||search_string||')')>0;
end FullTextSearchBandsByFuzzy;

create or replace procedure FullTextSearchAlbumsByFuzzy(search_string varchar2, cur out sys_refcursor)
as
begin
open cur for select * from ALBUMS where contains(album_name, 'fuzzy('||search_string||')')>0;
end FullTextSearchAlbumsByFuzzy;