#!/bin/bash
#
# Git Summary - a pretty overview of a set of git repos
#
# MIT License terms (see accompanying license file)
# Copyright (c) 2017 Reed Wade - <reed@typist.geek.nz>
#

#
# inspired and bits of logic by https://github.com/Andrew565/dotfiles
#

RED="\033[31m"
PINK="\033[1;31m"
MUSTARD="\033[33m"
YELLOW="\033[1;33m"
GREEN="\033[32m"
PURPLE="\033[35m"
WHITE="\033[1;37m"
CYAN="\033[1;36m"
RESET="\033[m"


function git_summary() {
    local branch status statusColour shortDirname
    cd $1
    shortDirname=$(basename $1)
    statusColour=$RED
    branch="<not a git repo>"
    status="-"

    if [ -e $1/.git ]; then
    
        local git_status="`git status -unormal 2>&1`"

        if [[ "$git_status" =~ behind ]]; then
            statusColour=$CYAN
            status='behind'
        elif [[ "$git_status" =~ nothing\ to\ commit ]]; then
            statusColour=$GREEN
            status='clean'
        elif [[ "$git_status" =~ untracked ]]; then
            statusColour=$RED
            status='untracked'
        elif [[ "$git_status" =~ Untracked ]]; then
            # "Untracked" catches case where we have both untracked and uncommitted
            statusColour=$RED
            status='untracked+uncommitted'
        else
            statusColour=$YELLOW
            status='uncommitted'
        fi

        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
        else
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
        fi
        printf "${statusColour}%16s${RESET} %20s   %s\n" "$status" "$branch" "$shortDirname"
    fi
}

echo
echo "~/src"
echo
for d in ~/src/* ; do
    git_summary $d
done

echo
echo "~/Artella/repos"
echo
for d in ~/Artella/repos/* ; do
    git_summary $d
done

echo
echo "~/go/src/github.com/AnimationMentor"
echo
for d in ~/go/src/github.com/AnimationMentor/* ; do
    git_summary $d
done
echo
