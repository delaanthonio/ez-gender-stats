-- hdfs dfs -cp Project2/hive/tables/BQ* Project2/pig
data = LOAD 'Project2/pig/BQ2/part-m-00000'
    USING PigStorage('|') AS (COUNTRY_NAME:chararray
    ,COUNTRY_CODE:chararray
    ,INDICATOR_NAME:chararray
    ,INDICATOR_CODE:chararray
    ,Y1960:double
    ,Y1961:double
    ,Y1962:double
    ,Y1963:double
    ,Y1964:double
    ,Y1965:double
    ,Y1966:double
    ,Y1967:double
    ,Y1968:double
    ,Y1969:double
    ,Y1970:double
    ,Y1971:double
    ,Y1972:double
    ,Y1973:double
    ,Y1974:double
    ,Y1975:double
    ,Y1976:double
    ,Y1977:double
    ,Y1978:double
    ,Y1979:double
    ,Y1980:double
    ,Y1981:double
    ,Y1982:double
    ,Y1983:double
    ,Y1984:double
    ,Y1985:double
    ,Y1986:double
    ,Y1987:double
    ,Y1988:double
    ,Y1989:double
    ,Y1990:double
    ,Y1991:double
    ,Y1992:double
    ,Y1993:double
    ,Y1994:double
    ,Y1995:double
    ,Y1996:double
    ,Y1997:double
    ,Y1998:double
    ,Y1999:double
    ,Y2000:double
    ,Y2001:double
    ,Y2002:double
    ,Y2003:double
    ,Y2004:double
    ,Y2005:double
    ,Y2006:double
    ,Y2007:double
    ,Y2008:double
    ,Y2009:double
    ,Y2010:double
    ,Y2011:double
    ,Y2012:double
    ,Y2013:double
    ,Y2014:double
    ,Y2015:double
    ,Y2016:double);
data_avg = FOREACH data GENERATE
    (Y2015 - Y2000) / 15.0 AS avg_increase;
data_rank = RANK data_avg;
STORE data_rank
    INTO 'hbase://bq2'
    USING org.apache.pig.backend.hadoop.hbase.HBaseStorage('data:avg_increase');