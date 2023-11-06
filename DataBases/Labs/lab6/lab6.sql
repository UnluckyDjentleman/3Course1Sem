--1
--sqlnet.ora -> look at screen1.png
--tsnames.ora -> look at screen2.png
--2
--look at screen3.png
--3
--look at screen4.png
--4
--Windows
--HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE
--screen5.png
--5
--screen6.png
--6
--screen7.png
--7
--screen7.png
--screen8.png
--8
--screen9.png
--9
--screen10.png
--screen11.png
--10
--screen12.png
--11
--time to write scripts
select * from dba_segments where owner='SYSTEM';
--12
create or replace view AllSegmentsInfo as
select owner, segment_type, COUNT(*) as count_segments, sum(extents) as summary_extent, sum(blocks) as summary_blocks, sum(bytes)/1024 as summary_bytes 
from dba_segments group by owner, segment_type;

select * from AllSegmentsInfo;