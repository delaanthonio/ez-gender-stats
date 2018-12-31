#!/usr/bin/env bash
bqs=("BQ1" "BQ2" "BQ3" "BQ4" "BQ5")

for bq in "${bqs[@]}"; do
    tables=("Project2/hive/tables/${bq}" "Project2/pig/${bq}")
    for table in "${tables[@]}"; do
        echo "Creating ${table}"
        hdfs dfs -mkdir -p "${table}"
        hdfs dfs -cp "EZData/${bq}/part-m-00000" "${table}"
    done
done

exit
