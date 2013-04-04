if [ `uname` != "Linux" ];
then {
  PS1="\[\033[35m\]\[\033[m\]\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "


  # don't put duplicate lines in the history. See bash(1) for more options
  # ... and ignore same sucessive entries.
  export HISTCONTROL=ignoreboth
  export HISTSIZE=100000
  # some more ls aliases
  alias ls='ls -FG'
  alias ll='ls -l'
  alias la='ls -A'
  alias l='ls -CF'
  alias rm='rm -i'
  alias cp='cp -i'
  alias mv='mv -i'
  alias vim='mvim -v'
  alias grep='grep --color'
  gr () { grep -rI --color "$*" .; }
  gri () { grep -riI --color "$*" .; }

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
  fi

  # git
  source ~/scripts/git-completion.bash

  # Phabricator
  source /Users/david/web/phacility/arcanist/resources/shell/bash-completion
  export PHABRICATOR_ENV=custom/myconfig
  export EDITOR=vim

  # EC2
  export JAVA_HOME=/usr
  export EC2_HOME=~/ec2-api-tools
  export EC2_PRIVATE_KEY=~/.ec2/pk-7F3CLDG5B2D73MDLCQRWUS6QLKJCRULH.pem
  export EC2_CERT=~/.ec2/cert-7F3CLDG5B2D73MDLCQRWUS6QLKJCRULH.pem

  export PATH=~/.cabal/bin:/usr/local/bin:/usr/local/sbin:$PATH:~/web/phacility/arcanist/bin:~/ec2-api-tools/bin:/usr/local/mysql/bin:/Users/david/go/bin:/usr/local/Cellar/ruby/1.9.3-p125/bin

  # let less inteligently open more filetypes
  LESSOPEN="|lesspipe.sh %s"; export LESSOPEN
}
else
  source .bashrc
fi
