# vim:foldmethod=marker ts=2 sw=2

if [ "$SSH_CONNECTION" ]; then
  SSH_SESSION=$(echo "$SSH_CONNECTION" | base64)
fi

# Language and IME {{{1
export LANG=en_US.UTF-8

# The following lines were added by compinstall {{{1
fpath=(~/.zsh/completion $fpath)

zstyle :compinstall filename '/home/heyrict/.zshrc'
zstyle ':completion:*' menu select

autoload -Uz compinit 
if [[ -n ${ZDOTDIR:-${HOME}}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# End of lines added by compinstall

# Custom completions with --help {{{1
helpcomp_bins=(
    ctfetch
    dust
    gotop
    miniserve
    xsv
    zathura
    bat
)
compdef _gnu_generic $helpcomp_bins
compdef nvim=vim

# Completion styles {{{1
zstyle ':completion:*' auto-description yes
zstyle ':completion:*:descriptions' format "%U%B%d%b%u"
zstyle ':completion:*:messages' format "%F{green}%d%f"
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''

# Antibody {{{1
export ANTIBODY_HOME=~/.antibody
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

if [ ! "${TTY:5:3}" = "tty" ]; then
    antibody bundle romkatv/powerlevel10k
fi

# Oh-my-zsh {{{1
## Path to your oh-my-zsh installation.
#export ZSH="/home/heyrict/.oh-my-zsh"
#
#CASE_SENSITIVE=true
#
## Uncomment the following line to disable bi-weekly auto-update checks.
#DISABLE_AUTO_UPDATE="true"
#
## Uncomment the following line to display red dots whilst waiting for completion.
##COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="%Y-%M-%d %H:%m:%s"

#plugins=(
#    adb
#    cargo
#    command-not-found
#    #django
#    colored-man-pages
#    docker
#    encode64
#    fd
#    flutter
#    git
#    node
#    npm
#    nvm
#    pip
#    postgres
#    python
#    ripgrep
#    rsync
#    rust
#    rustup
#    taskwarrior
#    torrent
#    ufw
#    virtualenv
#    yarn
#)
#
#if [ ${TTY:5:3} = "tty" ]; then
#    ZSH_THEME="altered-jonathan"
#else
#    ZSH_THEME="powerlevel10k/powerlevel10k"
#fi
#
#source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [ $SSH_CONNECTION ]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# History {{{1
if [ $SSH_CONNECTION ]; then
  HISTFILE=~/.histfile_$SSH_SESSION
else
  HISTFILE=~/.histfile
fi
HISTSIZE=1000
SAVEHIST=1000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt APPEND_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS

# Vim key binding {{{1
bindkey -v
bindkey "^e" _expand_alias
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^h' backward-delete-char
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'V' edit-command-line
# End of lines configured by zsh-newuser-install

# Ported from bash {{{1
## colored prompts {{{2
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

## some more ls aliases {{{2
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
## "alert" alias for long running commands {{{2
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## Alias definitions {{{2
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
# Enviroment {{{1
## Mapping {{{2
typeset -U path
export -TU INFOPATH infopath
export -TU CLASSPATH classpath

path=('/usr/local/bin' '/usr/bin' $path)
manpath=('/usr/local/man' '/usr/share/man' $manpath)

## Texlive {{{2
#manpath+=/usr/local/texlive/2020/texmf-dist/doc/man
#infopath+=/usr/local/texlive/2020/texmf-dist/doc/info
#path+=/usr/local/texlive/2020/bin/x86_64-linux
## Nvm {{{2
export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/init-nvm.sh

## Yarn {{{2
path+=$HOME/.yarn/bin
## Java {{{2
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
classpath=(. $JAVA_HOME/lib/dt.jar $JAVA_HOME/lib/tools.jar)
path=($JAVA_HOME/bin $JAVA_HOME/jre/bin $path)
## Android {{{2
export ANDROID_HOME="$HOME/Android"
export ANDROIDSDK="$HOME/Android"
export APP_ANDROID_SDK_PATH="$HOME/Android"

## Rust {{{2
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
export RUST_SRC_PATH=/home/heyrict/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
path+=$HOME/.cargo/bin
## Flutter {{{2
#export PUB_HOSTED_URL=https://pub.flutter-io.cn
#export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PUB_HOSTED_URL="https://mirrors.tuna.tsinghua.edu.cn/dart-pub/"
export FLUTTER_STORAGE_BASE_URL="https://mirrors.tuna.tsinghua.edu.cn/flutter"
path+=$HOME/Flutter/bin
path+=$HOME/Flutter/bin/cache/dart-sdk/bin
## NNN {{{2

# Book marks
# - w: working directory
# - c: notes for clinical medicine
# - m: Multimedia
# - u: Mount point
# - t: /tmp
export NNN_BMS="w:~/Eric/MyPrograms;c:~/pandoc_markdown/markdown/CliMed;m:/mnt/LENOVO/Eric/mov;u:/mnt;t:/tmp"

# Light theme
export NNN_COLORS='5234'
export NNN_FCOLORS='04030c020001090e050ddc06'
export NNN_ARCHIVE="\\.(7z|bz2|gz|tar|tgz|zip)$"
export NNN_IDLE_TIMEOUT=180

# Plugins
# - o: Open file found with fzf
# - p: View photos in this folder
# - P: View photos in this folder in numeric order
# - d: Show diffs between two files
# - c: CD into directory found with fzf
# - s: Organize
# - b: Page the file with bat
export NNN_PLUG='o:fzopen;p:-_feh -Z.;P:-_feh -Z. `ls|sort -n`;d:diffs;k:-chksum;c:fzcd;z:fzz;S:organize;b:-_bat $nnn;s:croc'
## GPG {{{2
export GPG_TTY=$(tty)

## Custom {{{2
export TASKRC="~/.taskrc"

path=(
    $path
    $HOME/MyPrograms/bin
    $HOME/Programs/bin
    $HOME/Programs/Slicer-4.11.0-2020-04-30-linux-amd64/bin
    $HOME/Android/platform-tools
)

# Other configs {{{1
## Zsh {{{2
unsetopt beep

## Python {{{2
if [ ! "${TTY:5:3}" = "tty" ]; then
    # Load venv only on pseudo-tty
    source ~/pyenv/env/bin/activate
fi
export HASURA_GRAPHQL_ADMIN_SECRET="CINDYTHINK_HASURA_ADMIN_SECRET"

## Change ls colors {{{2
export LS_COLORS="$LS_COLORS:ow=1;36"

## Navi {{{2
export NAVI_PATH=~/.config/navi/custom

# Starship for zsh {{{1
#case "$TERM" in
#    xterm-color|*-256color) eval "$(starship init zsh)";;
#esac

# Fuzzy finder {{{1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Powerlevel10k {{{1
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Navi {{{1
[ -x `command -v navi` ] && source <(navi widget zsh)
