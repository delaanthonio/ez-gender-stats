#!/usr/bin/env bash
sqoop export \
      --connect "jdbc:mysql://localhost/GENDER_STATS_DB" \
      --username "EZ_ADMIN" \
      --password 'ez--__!1978!' \
      --table "GENDER_STATS_DATA" \
      --fields-terminated-by ',' \
      --enclosed-by '\"' \
      --export-dir "GenderStatsData" \
      -m "1"
