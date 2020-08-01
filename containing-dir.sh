#!/usr/bin/env bash
#
# NOT YET FULLY IMPLEMENTED
#
# Resolve the containing directory of a script. It's like "dirname" but it 
# resolves symlinks.
#
# In other words, this snippet of Bash will identify the absolute path of the directory that contains the real (i.e. not
# a symlink) current executing Bash script. Why is this useful? Scripts are often packaged with other files and the
# script depends on those files and expects them at a specific relative path. So, if the script is symlinked it is not
# enough to use `dirname` to find the current directory but we must resolve the symlink to the original file.
#
# This snippet is inspired from Gradle which uses this technique in the Gradle wrapper script "gradlew". See
# https://github.com/gradle/gradle/blob/88c7b782748a3ccc8918c496c0e8622b31f5c045/gradlew#L29

# Resolve links: $0 may be a link
PRG="$0"
echo >&2 "PRG: $PRG"

# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    echo >&2 "'$PRG' is a symlink"
    ls=`ls -ld "$PRG"`
    echo >&2 "ls: $ls"
    link=`expr "$ls" : '.*-> \(.*\)$'`
    echo >&2 "link: $link"
    if expr "$link" : '/.*' > /dev/null; then
        echo >&2 "if branch hit"
        PRG="$link"
    else
        echo >&2 "else branch hit"
        PRG=`dirname "$PRG"`"/$link"
    fi
done

CONTAINING_DIR=$(dirname $PRG)
echo "CONTAINING_DIR: $CONTAINING_DIR"
