#!/bin/bash

# command aliases
alias cpwd="pwd | tr -d '\n' | pbcopy"      # copy current dir to mac clipboard
alias dirs="dirs -v"                        # show last dirs
alias lss="ls -Glathr"                      # readable ls -la
alias rm="rm -i"                            # Are you sure about deleting this?
alias fc="fc -e vim"                        # fc edit last command
alias venv="virtualenv venv/"               # python virtual environment shortcut

# create gitignore files
function gi() { curl -sL https://www.gitignore.io/api/$@ ;}
# create shortened url 
function tiny() { curl -sL https://tinyurl.com/api-create.php\?url\=http://$@/ ; echo; }
# update brew 
function steep() {
    brew update;
    brew upgrade;
    brew cask upgrade;
    brew cleanup;
}
# list contents after cd
function cdl() {cd $1; ls;}
# cd into new directory
function mkcd() { mkdir -p "$1"; cd "$1";}
# compress directory into a tarball
function tardir() { tar -zcf "${1%/}.tar.gz" "$1";}
