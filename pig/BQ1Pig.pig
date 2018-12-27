-- BQ1 
data = load '/user/cloudera/EZData/BQ1/part-m-00000' using PigStorage('|') AS (COUNTRY_NAME:chararray,AVERAGE:double);

filter_30 = filter data by AVERAGE < 30.0;

store filter_30 into 'PigOut/BQ1/FILTER_30';