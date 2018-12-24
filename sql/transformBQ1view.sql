USE GENDER_STATS_DB;
DROP TABLE IF EXISTS TRANSFORM;
DROP PROCEDURE IF EXISTS TRANSFORM_BQ1;
DROP VIEW IF EXISTS BQ1_TRANSFORM;

#+-+-+-+-+-+-+-+-+#
# Transform table #
# to hold data    #
# for final       #
# transform view  #
#+-+-+-+-+-+-+-+-+
create table TRANSFORM(COUNTRY_NAME VARCHAR(100),YEAR INTEGER, DATA DECIMAL(65,30));

#+-+-+-+-+-+-+-+-+#
# Procedure to    #
# transform data  #
# from first view #
#+-+-+-+-+-+-+-+-+#
DELIMITER $$
CREATE procedure TRANSFORM_BQ1(LOWER_LIM INTEGER,UPPER_LIM INTEGER) 
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

call TRANSFORM_BQ1(2010,2016);

#+-+-+-+-+-+-+-+-+#
# Final transform #
# TABLE to sqoop  # 
#+-+-+-+-+-+-+-+-+#
CREATE TABLE BQ1_TRANSFORM AS SELECT * FROM TRANSFORM ORDER BY COUNTRY_NAME,YEAR ASC;

DROP TABLE IF EXISTS TRANSFORM;
SELECT * FROM BQ1_TRANSFORM;