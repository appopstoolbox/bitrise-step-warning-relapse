#!/bin/bash
set -ex

# Compute the number of warnings
warning_number_space=$(cat ${logFile} | grep -o "⚠️.*" | sort | uniq | wc -l)

# Trim all spaces
warning_number="$(echo -e "${warning_number_space}" | tr -d '[:space:]')"

# Share the value of the warning number to envman
envman add --key NUMBER_OF_WARNINGS --value $warning_number

# Test regression
./cli-regression-protector "warning_relapse" "$warning_number" "<" ".ci/ci.sqlite3"
