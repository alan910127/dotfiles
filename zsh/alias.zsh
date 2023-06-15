# command line utilities
alias ls=exa

# git aliases
alias gp="git push"
alias gl="git remote prune && git pull --ff-only"
alias gco="git checkout"

# tools
function take() {
  mkdir -p $1
  cd $1
}

