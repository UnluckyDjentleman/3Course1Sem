--before that you need to create directory and xml files on server Oracle
CREATE OR REPLACE DIRECTORY DIR AS '/opt/oracle/product/23c/dbhomeFree/xml_oracle';
create or replace procedure XmlImport
is
begin
insert into BANDS (band_name, band_location, band_genre, band_year_of_creation, band_logo)
SELECT ExtractValue(VALUE(BANDS), '//BAND_NAME') AS band_name ,
       ExtractValue(VALUE(BANDS), '//BAND_LOCATION') AS band_location,
       ExtractValue(VALUE(BANDS), '//BAND_GENRE') as band_genre,
       ExtractValue(VALUE(BANDS), '//BAND_YEAR_OF_CREATION') as band_year_of_creation,
       ExtractValue(VALUE(BANDS), '//BAND_LOGO') as band_logo
FROM TABLE(XMLSequence(EXTRACT(XMLTYPE(bfilename('DIR', 'BANDS_import.xml'), 
           nls_charset_id('UTF-8')),'/ROWSET/ROW'))) BANDS;
end XmlImport;


create or replace procedure XmlExport
is  
rc sys_refcursor; 
doc DBMS_XMLDOM.DOMDocument; 
begin 
OPEN rc FOR  
SELECT band_name, band_location, band_genre, band_year_of_creation, band_logo FROM BANDS; 
doc := DBMS_XMLDOM.NewDOMDocument(XMLTYPE(rc)); 
DBMS_XMLDOM.WRITETOFILE(doc, 'DIR/BANDS_export.xml'); 
commit; 
exception 
when others then 
raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
end XmlExport;

begin
developer.XMLImport();
end;

begin
developer.XMLExport();
end;