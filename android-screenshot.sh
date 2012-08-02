#!/bin/bash
# This is a simple script which will take a screenshot from a currently
# connected Android device and dump it to the user's desktop.
# Written by Nik Reiman: nik.reiman@gmail.com

# Requirements:
# For this tool, you will need the Android SDK installed.

source $HOME/.bashrc
androidSdkPath=$ANDROID_SDK_HOME
screenshotToolPath=./src
screenshotOutputPath=$HOME/Desktop
screenshotFilenamePrefix="Android Screenshot"

if [ ! "$androidSdkPath" ] ; then
  errorMessage="Can't find the Android SDK. Have you set the ANDROID_SDK_HOME environment variable in your ~/.bashrc file?"
  osascript -e "tell app \"System Events\" to display dialog \"$errorMessage\""
  exit 1
fi

PATH=$PATH:$androidSdkPath/platform-tools
currentDate=`date "+%d %b %Y %H-%M-%S"`
printf -v outputFile "%s %s.png" "$screenshotFilenamePrefix" "$currentDate"
cd $screenshotToolPath
java com/android/screenshot/Screenshot -d "$screenshotOutputPath/$outputFile"
open "$screenshotOutputPath/$outputFile"
