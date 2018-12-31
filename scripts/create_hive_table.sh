#!/usr/bin/env bash
bqs=("BQ1" "BQ2" "BQ3" "BQ4" "BQ5")

for bq in "${bqs[@]}"; do
    hive_table_path="Project2/hive/tables/${bq}"
    echo "$hive_table_path"
    hdfs dfs -mkdir -p "$hive_table_path"
    hdfs dfs -cp "EZData/${bq}/part-m-00000" "$hive_table_path"
done

exit
