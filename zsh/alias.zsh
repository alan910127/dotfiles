# command line utilities
alias l="exa -lah"
alias ll="exa -lh"
alias ls=exa

# git aliases
alias gp="git push"
alias gl="git remote prune && git pull --ff-only"
alias gco="git checkout"
alias gst="git status"
alias gcl="git clone"


# tools
function take() {
  mkdir -p $1
  cd $1
}

