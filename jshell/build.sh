#!/usr/bin/env bash
# Compile

find src -name "*.java" > sources.txt
javac @sources.txt --class-path "lib/*" -d out --enable-preview -source 14 -Xlint:preview
