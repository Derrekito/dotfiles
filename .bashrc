#
# ~/.bashrc
#

# Automatically attach to tmux session if available, otherwise start a new one
#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#    tmux -a || tmux new -s default
#fi

# cd into directory by typing only directory name
shopt -s autocd
# set vi mode
set -o vi

# infinite history
HISTSIZE=HISTFILESIZE=

# Environment Variables and Terminal Settings
#export TERM="tmux-256color"
export VISUAL='nvim'
export EDITOR='nvim'
export TERMINAL=alacritty
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/OpenBLAS/lib:/usr/local/lib
export PATH=$PATH:$HOME/go/bin:$HOME/scripts:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/perl5/lib/bin:/usr/local/cuda
export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$HOME/perl5\""
export PERL_Mb_OPT="INSTALL_BASE=$HOME/perl5"
# required for Davinci Resolve to work.
export LOG4CXX_CONFIGURATION=file:///$HOME/log4cxx.properties


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
alias tmux='tmux attach || tmux new-session'
alias resolve='LD_PRELOAD="/usr/lib/libgio-2.0.so /usr/lib/libgmodule-2.0.so" /opt/resolve/bin/resolve'

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gd='git diff'
alias gl='git log'
alias gll='git log --oneline'
alias gp='git push'
alias gpl='git pull'
alias gwta='git worktree add'
alias gwtl='git worktree list'
alias gwtm='git worktree move'
alias gwtr='git worktree remove'

if [ "$(hostname)" = "pop-os" ]; then
    print_satellite.sh
else
    print_mushroom.sh
fi

eval "$(starship init bash)"


