data = load 'EZData/BQ5/part-m-00000' using PigStorage('|') AS (country_name:chararray
    , country_code: chararray
    , indicator_name: chararray
    , indicator_code: chararray
    , y1960: double
    , y1961: double
    , y1962: double
    , y1963: double
    , y1964: double
    , y1965: double
    , y1966: double
    , y1967: double
    , y1968: double
    , y1969: double
    , y1970: double
    , y1971: double
    , y1972: double
    , y1973: double
    , y1974: double
    , y1975: double
    , y1976: double
    , y1977: double
    , y1978: double
    , y1979: double
    , y1980: double
    , y1981: double
    , y1982: double
    , y1983: double
    , y1984: double
    , y1985: double
    , y1986: double
    , y1987: double
    , y1988: double
    , y1989: double
    , y1990: double
    , y1991: double
    , y1992: double
    , y1993: double
    , y1994: double
    , y1995: double
    , y1996: double
    , y1997: double
    , y1998: double
    , y1999: double
    , y2000: double
    , y2001: double
    , y2002: double
    , y2003: double
    , y2004: double
    , y2005: double
    , y2006: double
    , y2007: double
    , y2008: double
    , y2009: double
    , y2010: double
    , y2011: double
    , y2012: double
    , y2013: double
    , y2014: double
    , y2015: double
    , y2016: double
    );

valid_data = filter data
    by y2010 is not null
    and y2011 is not null
    and y2012 is not null
    and y2013 is not null
    and y2014 is not null
    and y2015 is not null
    ;

split valid_data into
    male_data if indicator_code == 'SL.EMP.TOTL.SP.MA.ZS'
    , female_data if indicator_code == 'SL.EMP.TOTL.SP.FE.ZS';

joined_data = join male_data by country_code, female_data by country_code;

employment_diff = foreach joined_data generate
    male_data::country_name
    , ROUND(male_data::y2010 - female_data::y2010)
    , ROUND(male_data::y2011 - female_data::y2011)
    , ROUND(male_data::y2012 - female_data::y2012)
    , ROUND(male_data::y2013 - female_data::y2013)
    , ROUND(male_data::y2014 - female_data::y2014)
    , ROUND(male_data::y2015 - female_data::y2015)
    ;

STORE employment_diff
    INTO 'hbase://bq5'
    USING org.apache.pig.backend.hadoop.hbase.HBaseStorage('data:low_grad_rate');