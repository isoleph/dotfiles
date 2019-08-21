#!/bin/bash

# command Aliases
alias cpwd="pwd | tr -d '\n' | pbcopy"      # copy current ./ to clipboard
alias :q="exit"                             # vim exit alias ;)
alias pip="pip3"                            # who uses pip2?
alias venv="virtualenv venv/"
alias dirs="dirs -v"                        # show last dirs
alias fc="fc -e vim"                        # fc edit last command

# create gitignore files
function gi() { curl -sL https://www.gitignore.io/api/$@ ;}
# create shortened url 
function tiny() { curl -sL https://tinyurl.com/api-create.php\?url\=http://$@/ ;}
