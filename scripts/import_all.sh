#!/usr/bin/env bash
bqs=("BQ1" "BQ2" "BQ3" "BQ4" "BQ5")

for bq in "${bqs[@]}"; do
sqoop import \
--connect 'jdbc:mysql://localhost/GENDER_STATS_DB' \
--username 'EZ_ADMIN' \
--password 'ez--__!1978!' \
--table "${bq}" \
--fields-terminated-by '|' \
--target-dir "EZData/${bq}/" \
-m 1
done

exit
