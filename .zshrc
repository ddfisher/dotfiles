# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="gallois"
ZSH_THEME="david"

# Example aliases
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(battery brew git git-extras haskell npm python osx screen vundle)

source $ZSH/oh-my-zsh.sh

autoload select-word-style
select-word-style shell

setopt no_beep
setopt extendedglob

setopt noautomenu

# function menu-expand-or-complete-and-search () {
#   zle menu-expand-or-complete 
#   zle history-incremental-search-forward
# }

# zle -N menu-expand-or-complete-and-search

bindkey '^T' menu-expand-or-complete
bindkey -M menuselect '^I' accept-line

export EDITOR="vim"

# Customize to your needs...
export PATH=/Users/david/.cabal/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Users/david/.cabal/bin:/usr/texbin:/Users/david/web/phacility/arcanist/bin:/Users/david/ec2-api-tools/bin:/usr/local/mysql/bin:/Users/david/go/bin:/usr/local/Cellar/ruby/1.9.3-p125/bin
