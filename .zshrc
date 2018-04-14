# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt appendhistory autocd extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were read by zsh-newuser-install.
# They were moved here as they could not be understood.
# Tue Mar 13 11:22:50 +04 2018
# End of lines moved by zsh-newuser-install.
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ebc/.zshrc'
autoload -Uz colors && colors
autoload -U promptinit && promptinit
autoload -Uz compinit && compinit

setopt completealiases
setopt correct
setopt autocd
setopt notify

#insert sudo
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# Meta-u to chdir to the parent `directory
bindkey -s '\eu' '^Ucd ..; ls^M'

# End of lines added by compinstall
#PROMPT=" %{$fg_bold[blue]%} �  "
#RPROMPT="%{$fg[blue]%}%M:%{$fg_bold[yellow]%}%~%{$reset_color%}   "

setopt prompt_subst

SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

if [ "$TERM" = "linux" ]; then
	PROMPT_CHAR=">"
else
	#PROMPT_CHAR="▬"
	#PROMPT_CHAR="ͻ"
	#PROMPT_CHAR="❯"
      PROMPT_CHAR=">"
fi

ON_COLOR="%{$fg[cyan]%}"
OFF_COLOR="%{$reset_color%}"
ERR_COLOR="%{$fg[red]%}"

function prompt_user() {
  echo "%(!.$ERR_COLOR.$OFF_COLOR)$PROMPT_CHAR%{$reset_color%}"
}

function prompt_jobs() {
  echo "%(1j.$ON_COLOR.$OFF_COLOR)$PROMPT_CHAR%{$reset_color%}"
}

function prompt_status() {
  echo "%(0?.$ON_COLOR.$ERR_COLOR)$PROMPT_CHAR%{$reset_color%}"
}

function -prompt_ellipse(){
  local string=$1
  local sep="$rsc..$path_color"
  if [[ $MINIMAL_SHORTEN == true ]] && [[ ${#string} -gt 10 ]]; then
    echo "${string:0:4}$sep${string: -4}"
  else
    echo $string
  fi
}

function prompt_path() {
  local path_color="%{[38;5;244m%}%}"
  local rsc="%{$reset_color%}"
  local sep="$rsc/$path_color"

  echo "$path_color$(print -P %3~ | sed s_/_${sep}_g)$rsc" # %N : number of directories
}

function git_branch_name() {
  local branch_name="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  [[ -n $branch_name ]] && echo "$branch_name"
}

function git_repo_status(){
  local rs="$(git status --porcelain -b)"

  if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty
    echo "%{$fg[red]%}"
  elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged
    echo "%{$fg[red]%}"
  elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind
    echo "%{[38;5;011m%}%}"
  elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead
    echo "%{$reset_color%}"
  else # is clean
    echo "%{$fg[green]%}"
  fi
}

function prompt_git() {
  local bname=$(git_branch_name)
  if [[ -n $bname ]]; then
    local infos="| $(git_repo_status)$bname%{$reset_color%}"
    echo " $infos"
  fi
}

function prompt_vimode(){
  local ret=""

  case $KEYMAP in
    main|viins)
      ret+="$ON_COLOR"
      ;;
    vicmd)
      ret+="$OFF_COLOR"
      ;;
  esac

  ret+="$PROMPT_CHAR%{$reset_color%}"

  echo "$ret"
}

function prompt_hostname(){
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo "$(hostname -s)"
    fi
}

function zle-line-init zle-line-finish zle-keymap-select {
  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish

PROMPT=' $(prompt_hostname)$(prompt_user)$(prompt_jobs)$(prompt_vimode)$(prompt_status) '
RPROMPT='$(prompt_path)$(prompt_git) '

# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line

# completion
zstyle ':completion:*' menu select
zstyle ':completion:*'                  squeeze-slashes true
zstyle ':completion:*'                  matcher-list \
 '' 'm:{a-z-}={A-Z_}' 'r:|[._-/]=* r:|=*'
zstyle ':completion:*'                  completer \
 _complete _match _ignored
zstyle ':completion:*:*:(cd|kill|ls|mv|rename|rm|vim):*' menu \
 yes select
zstyle ':completion:*:*:(cd|kill|ls|mv|rename|rm|vim):*' force-list \
 always
zstyle ':completion:*:*:(cd|kill|ls|mv|rename|rm|vim):*' ignore-parents \
 parent pwd
zstyle ':completion:*:*:(cd|kill|ls|mv|rename|rm|vim):*' list-dirs-first

zstyle ':completion:*:warnings'         format '%F{1}%d%f'
zstyle ':completion:*:messages'         format '%F{2}%d%f'
zstyle ':completion:*:corrections'      format '%F{3}%d%f'
zstyle ':completion:*:descriptions'     format '%F{4}%d%f'

zstyle ':completion:*:functions'        ignored-patterns '_*'
zstyle ':completion:*:*:*:users'        ignored-patterns \
 'avahi' 'bin' 'colord' 'daemon' 'dbus' 'ftp' 'git' 'http' 'mail' \
 'mpd' 'nobody' 'nvidia*' 'polkitd' 'systemd*' 'uuidd'
zstyle ':completion:*'                  list-colors $dircolors 'ma=00;40'
zstyle ':completion:*:*:kill:*'         list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:*:kill:*:jobs'    list-colors "=(#b) #([0-9]#)*=35=31"
zstyle ':completion:*'                  use-cache on
zstyle ':completion:*'                  cache-path \
 "$XDG_CACHE_DIR/zsh_comp_cache"

# TMUX
#if which tmux >/dev/null 2>&1; then
#if not inside a tmux session, and no session is started, start a new session
#		test -z "$TMUX" && tmux new-session
#fi
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
	  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
   [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() 
{
	 print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

      ## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS
      #
      ### This reverts the +/- operators.
setopt PUSHD_MINUS


#Aliases
alias mkpkg="makepkg -sri"
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias lr="ls -R"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias mke="sudo chmod +x"
alias pacman='sudo pacman'
alias alsamixer="alsamixer -g"
alias svim="sudoedit"
alias emac='emacs -nw'
alias h='history | tail'
alias hg='history | grep'
alias equalizer="alsamixer -D equal"
alias mkdir="mkdir -pv"
alias top="htop"
alias df="pydf"
alias ..="cd .."
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ffs='sudo $(history -p !!)'
alias run.c='./a.out'
alias pacs='pacman -Qss | grep'
alias monodevelop='flatpak run com.xamarin.MonoDevelop'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
