#!/bin/bash

# command Aliases
alias cpwd="pwd | tr -d '\n' | pbcopy"      # copy current ./ to clipboard
alias :q="exit"                             # vim exit alias ;)
alias pip="pip3"                            # who uses pip2?

# create gitignore files
function gi() { curl -sL https://www.gitignore.io/api/$@ ;}
