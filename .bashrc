#
# ~/.bashrc
#

# cd into directory by typing only directory name
shopt -s autocd

# infinite history
HISTSIZE=HISTFILESIZE=

# Environment Variables and Terminal Settings
#export TERM="tmux-256color"
export VISUAL='nvim'
export EDITOR='nvim'
export TERMINAL=alacritty
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/OpenBLAS/lib:/usr/local/lib
export PATH=$PATH:$HOME/scripts:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/perl5/lib/bin
export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$HOME/perl5\""
export PERL_Mb_OPT="INSTALL_BASE=$HOME/perl5"
set -o vi

source "$HOME/.config/alacritty/alacritty.bash"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias definitions
alias ls='ls --color=auto --group-directories-first'
alias la='ls -aogh --color=auto'
alias ll='ls -1 --color=auto'
alias grep='grep --color=auto'
alias tree="tree -a -I '.git'"
alias :q='exit'
alias dotcfg='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias sv='sudo vim'
alias ka='killall'
alias nvim='nvim'
alias vim='nvim'
alias v='nvim'
alias mkdir='mkdir -pv'
alias ccat='highlight --out-format=ansi'

if [ "$(hostname)" = "pop-os" ]; then
    print_satellite.sh
else
    print_mushroom.sh
fi

eval "$(starship init bash)"
