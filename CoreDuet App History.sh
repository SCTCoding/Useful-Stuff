#! /bin/bash

# Exact query syntax comes from: https://www.mac4n6.com/blog/2018/8/5/knowledge-is-power-using-the-knowledgecdb-database-on-macos-and-ios-to-determine-precise-user-and-application-usage

# Get path
read -p "Where is the SQL file? " path

# Output analysis
sqlite3 $path << INPUT >> ~/Desktop/AppHistory.csv
.headers on
.mode csv

SELECT datetime(ZOBJECT.ZCREATIONDATE+978307200,'UNIXEPOCH', 'LOCALTIME') as "ENTRY CREATION", CASE ZOBJECT.ZSTARTDAYOFWEEK WHEN "1" THEN "Sunday" WHEN "2" THEN "Monday" WHEN "3" THEN "Tuesday" WHEN "4" THEN "Wednesday" WHEN "5" THEN "Thursday" WHEN "6" THEN "Friday" WHEN "7" THEN "Saturday" END "DAY OF WEEK", ZOBJECT.ZSECONDSFROMGMT/3600 AS "GMT OFFSET", datetime(ZOBJECT.ZSTARTDATE+978307200,'UNIXEPOCH', 'LOCALTIME') as "START", datetime(ZOBJECT.ZENDDATE+978307200,'UNIXEPOCH', 'LOCALTIME') as "END", (ZOBJECT.ZENDDATE-ZOBJECT.ZSTARTDATE) as "USAGE IN SECONDS", ZOBJECT.ZSTREAMNAME, ZOBJECT.ZVALUESTRING FROM ZOBJECT WHERE ZSTREAMNAME IS "/app/inFocus" ORDER BY "START";

INPUT

exit



