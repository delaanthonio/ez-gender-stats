-- BQ1 
data = load '/user/cloudera/EZData/BQ1/part-m-00000' using PigStorage('|') AS (country_name:chararray, average: double);
filter_30 = filter data by average < 30.0;
STORE filter_30
    INTO 'hbase://bq1'
    USING org.apache.pig.backend.hadoop.hbase.HBaseStorage('data:low_grad_rate');