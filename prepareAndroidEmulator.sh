#!/bin/bash
set +e

START=$(date +%s)

${ANDROID_HOME}/emulator/emulator -avd test -no-window -no-audio &
android-wait-for-emulator.sh

END=$(date +%s)
DIFF="$(($END-$START))"

echo "Prepared Emulator in $DIFF seconds"