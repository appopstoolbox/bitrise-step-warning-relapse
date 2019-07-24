#!/bin/bash
set -ex

bundle install

DBPath=".ci/ci.sqlite3"
ScriptPath=$( cd "$(dirname "$0")" ; pwd -P )
WarningNumber="0"

WarningNumber=$(./XCPrettyJSONExtractNumberOfWarning.swift "$logfile")

$ScriptPath/relapse "warning_relapse_$BITRISE_SCHEME" "$WarningNumber" "<" $DBPath

# update saved database
git add $DBPath
git commit -am "Update Warning Count Database"
git push origin HEAD:$BITRISE_GIT_BRANCH
