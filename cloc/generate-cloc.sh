#! /bin/ash

cd /git
cloc ./ --by-file --csv --quiet --report-file=/logs/cloc.csv
