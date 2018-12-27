#! /bin/bash

# Business Question 1
sqoop import \
--connect jdbc:mysql://localhost/GENDER_STATS_DB \
--username EZ_ADMIN \
--password 'ez--__!1978!' \
--table BQ1 \
--fields-terminated-by '|' \
--target-dir EZData/BQ1/ \
-m 1

# Business Question 2
sqoop import \
--connect jdbc:mysql://localhost/GENDER_STATS_DB \
--username EZ_ADMIN \
--password 'ez--__!1978!' \
--table BQ2 \
--fields-terminated-by '|' \
--target-dir EZData/BQ2/ \
-m 1

# Business Question 3
sqoop import \
--connect jdbc:mysql://localhost/GENDER_STATS_DB \
--username EZ_ADMIN \
--password 'ez--__!1978!' \
--table BQ3 \
--fields-terminated-by '|' \
--target-dir EZData/BQ3/ \
-m 1

# Business Question 4
sqoop import \
--connect jdbc:mysql://localhost/GENDER_STATS_DB \
--username EZ_ADMIN \
--password 'ez--__!1978!' \
--table BQ4 \
--fields-terminated-by '|' \
--target-dir EZData/BQ4/ \
-m 1

# Business Question 5
sqoop import \
--connect jdbc:mysql://localhost/GENDER_STATS_DB \
--username EZ_ADMIN \
--password 'ez--__!1978!' \
--table BQ5 \
--fields-terminated-by '|' \
--target-dir EZData/BQ5/ \
-m 1
