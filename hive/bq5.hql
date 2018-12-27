CREATE EXTERNAL TABLE GENDER_STATS_DATA
( COUNTRY_NAME string
, COUNTRY_CODE string
, INDICATOR_NAME string
, INDICATOR_CODE string
, `1960` double
, `1961` double
, `1962` double
, `1963` double
, `1964` double
, `1965` double
, `1966` double
, `1967` double
, `1968` double
, `1969` double
, `1970` double
, `1971` double
, `1972` double
, `1973` double
, `1974` double
, `1975` double
, `1976` double
, `1977` double
, `1978` double
, `1979` double
, `1980` double
, `1981` double
, `1982` double
, `1983` double
, `1984` double
, `1985` double
, `1986` double
, `1987` double
, `1988` double
, `1989` double
, `1990` double
, `1991` double
, `1992` double
, `1993` double
, `1994` double
, `1995` double
, `1996` double
, `1997` double
, `1998` double
, `1999` double
, `2000` double
, `2001` double
, `2002` double
, `2003` double
, `2004` double
, `2005` double
, `2006` double
, `2007` double
, `2008` double
, `2009` double
, `2010` double
, `2011` double
, `2012` double
, `2013` double
, `2014` double
, `2015` double
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';

LOAD DATA INPATH '/user/cloudera/EZData/BQ5/part-m-00000'
INTO TABLE GENDER_STATS_DATA;

SELECT MA.COUNTRY_NAME
, ROUND(MA.`2010` - FE.`2010`, 1) AS `2010`
, ROUND(MA.`2011` - FE.`2011`, 1) AS `2011`
, ROUND(MA.`2012` - FE.`2012`, 1) AS `2012`
, ROUND(MA.`2013` - FE.`2013`, 1) AS `2013`
, ROUND(MA.`2014` - FE.`2014`, 1) AS `2014`
, ROUND(MA.`2015` - FE.`2015`, 1) AS `2015`
FROM GENDER_STATS_DATA AS `MA`
JOIN GENDER_STATS_DATA AS `FE`
ON (MA.COUNTRY_NAME = FE.COUNTRY_NAME)
WHERE MA.INDICATOR_CODE = 'SL.EMP.TOTL.SP.MA.ZS'
AND FE.INDICATOR_CODE = 'SL.EMP.TOTL.SP.FE.ZS'
ORDER BY COUNTRY_NAME;
