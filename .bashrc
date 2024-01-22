#
# ~/.bashrc
#

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

# Terminal colors using tput
# Basic colors
GRAY=$(tput setaf 7)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7; tput bold)

# Character styles
BOLD=$(tput bold)
RESET=$(tput sgr0)

# Symbol colors
SHEV_COLOR="${CYAN}"
BRANCH_COLOR="${BLUE}"
MODE_COLOR="${RED}"
DIR_COLOR="${GREEN}"

# Symbols
LEFT_SHEV="${SHEV_COLOR}${BOLD}⟪${RESET}"
RIGHT_SHEV="${SHEV_COLOR}${BOLD}⟫${RESET}"
MODE="${MODE_COLOR}${BOLD}"
GIT_INFO=""

# Function definitions
#parse_git_branch() {
#    branch_name=$(git branch 2> /dev/null| sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
#    if [[ -n $branch_name ]]
#    then
#        BRANCH=${BRANCH_COLOR}$branch_name${RESET}
#        git_mode=$(git status 2>/dev/null | sed -n '/You\ are/p' | sed -r 's/.*(bisecting|merging|rebasing|editing).*/\U\1/')
#        if [[ -n $git_mode ]]
#        then
#            MODE="|$MODE$git_mode${RESET}"
#        fi
#        echo "$LEFT_SHEV$BRANCH$MODE$RIGHT_SHEV${RESET}" 2> /dev/null
#    else
#        echo "" 2> /dev/null
#    fi
#}

# Alias definitions
alias ls='ls --color=auto'
alias la='ls -aogh'
alias ll='ls -1'
alias tree="tree -a -I '.git'"
alias vim='nvim'
alias :q='exit'
alias dotcfg='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'



#PS1='╔═╣${DIR_COLOR}\w/${RESET}  $(parse_git_branch)\n╚═> '

if [ "$(hostname)" = "pop-os" ]; then
    print_satellite.sh
else
    print_mushroom.sh
fi

eval "$(starship init bash)"
