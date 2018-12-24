-- BQ1 
data = load '/home/cloudera/BQ1/part-m-00000' using PigStorage('|') AS (COUNTRY_NAME:chararray, YEAR:chararray,DATA:double);
group_all = group data by COUNTRY_NAME;

filter_30 = filter group_all by data.DATA < 30.0;
less_30 = foreach filter_30 generate group, MIN(data.DATA); 

avg_percent = foreach group_all generate group, AVG(data.DATA) as average;
avg_less_30 = filter avg_percent by average < 30.0; 

store less_30 into 'HOutput/BQ1/LESS_30';
store avg_less_30 into 'HOutput/BQ1/AVG_LESS_30';