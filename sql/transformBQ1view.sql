USE GENDER_STATS_DB;

#+-+-+-+-+-+-+-+-+#
# Transform table #
# to hold data    #
# for final       #
# transform view  #
#+-+-+-+-+-+-+-+-+
DROP TABLE IF EXISTS GENDER_STATS_DB.TRANSFORM;
create table GENDER_STATS_DB.TRANSFORM(COUNTRY_NAME VARCHAR(100),YEAR INTEGER, DATA DECIMAL(65,30));

#+-+-+-+-+-+-+-+-+#
# Procedure to    #
# transform data  #
# from first view #
#+-+-+-+-+-+-+-+-+#
DROP PROCEDURE IF EXISTS GENDER_STATS_DB.TRANSFORM_BQ1;
DELIMITER $$
CREATE procedure GENDER_STATS_DB.TRANSFORM_BQ1(LOWER_LIM INTEGER,UPPER_LIM INTEGER) 
BEGIN 
  DECLARE YEAR_VAR integer;
  DECLARE STR varchar(30);
  SET YEAR_VAR = LOWER_LIM;
  
  WHILE YEAR_VAR <= UPPER_LIM DO
  
  SET @STR:=concat('`',YEAR_VAR,'`');
  SET @sqlText = CONCAT(
				'INSERT INTO GENDER_STATS_DB.TRANSFORM (COUNTRY_NAME,YEAR,DATA)',
				' SELECT COUNTRY_NAME,',
                YEAR_VAR,',',@STR,
                ' FROM GENDER_STATS_DB.BQ1',
                ' WHERE ',@STR,
                ' IS NOT NULL'
                );
  PREPARE stmt FROM @sqlText;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  
  set YEAR_VAR = YEAR_VAR + 1;
  
  end while;
END$$
DELIMITER ;

call GENDER_STATS_DB.TRANSFORM_BQ1(2010,2016);

#+-+-+-+-+-+-+-+-+#
# Table order     #
# the countries   #
# to easily       #
# aggreagate      #
# values          # 
#+-+-+-+-+-+-+-+-+#
DROP TABLE IF EXISTS GENDER_STATS_DB.BQ1_PRETRANSFORM;
CREATE TABLE GENDER_STATS_DB.BQ1_PRETRANSFORM AS SELECT * FROM TRANSFORM ORDER BY COUNTRY_NAME,YEAR ASC;

#+-+-+-+-+-+-+-+-+#
# Final transform #
# TABLE to sqoop  # 
#+-+-+-+-+-+-+-+-+#
DROP TABLE IF EXISTS GENDER_STATS_DB.BQ1_TRANSFORM;
CREATE TABLE GENDER_STATS_DB.BQ1_TRANSFORM AS 
SELECT COUNTRY_NAME,AVG(DATA) AS AVERAGE FROM GENDER_STATS_DB.BQ1_PRETRANSFORM
GROUP BY COUNTRY_NAME
ORDER BY COUNTRY_NAME ASC;