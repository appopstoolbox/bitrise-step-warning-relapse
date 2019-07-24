#!/bin/bash
set -ex

DBPath=".ci/ci.sqlite3"
ScriptPath=$( cd "$(dirname "$0")" ; pwd -P )

WarningNumber=$($ScriptPath/XCPrettyJSONExtractNumberOfWarning.swift $logFile)

$ScriptPath/relapse "warning_relapse_$BITRISE_SCHEME" "$WarningNumber" "<" $DBPath

# update saved database
git add $DBPath
git commit -am "Update Warning Count Database"
git push origin HEAD:$BITRISE_GIT_BRANCH
