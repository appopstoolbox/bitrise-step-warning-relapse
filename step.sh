#!/bin/bash
set -ex

DBPath=".ci/ci.sqlite3"
ScriptPath=$( cd "$(dirname "$0")" ; pwd -P )
WarningNumber="0"

if [[ "$buildTool" == "xcpretty" ]]; then
	WarningNumber=$(cat $logFile | grep -o "⚠️.*" | sort | uniq | wc -l | tr -d '[:space:]')
elif [[ "$buildTool" == "xcodebuild" ]]; then
	WarningNumber=$(cat $logFile | grep -o ": warning:" | sort | uniq | wc -l | tr -d '[:space:]')
else
	echo "Unimplemented build tool"
	exit 1
fi

$ScriptPath/relapse "warning_relapse_$BITRISE_SCHEME" "$WarningNumber" "<" $DBPath

# update saved database
git add $DBPath
git commit -am "Update Warning Count Database"
git push origin HEAD:$BITRISE_GIT_BRANCH
