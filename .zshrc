# Lines configured by zsh-newuser-install
export BROWSER="firefox"
export EDITOR="vim"
export QUARTUS_64BIT=1
export SUDO_EDITOR="vim"
## workaround for handling TERM variable in multiple tmux sessions properly from http://sourceforge.net/p/tmux/mailman/message/32751663/ by Nicholas Marriott
if [[ -n ${TMUX} && -n ${commands[tmux]}  ]];then
        case $(tmux showenv TERM 2>/dev/null) in
            *256color) ;&
            TERM=fbterm)
                    TERM=screen-256color ;;
            *)
                    TERM=screen
        esac
fi

source /etc/profile
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ebc/.zshrc'
autoload -Uz colors && colors
autoload -U promptinit && promptinit
autoload -Uz compinit && compinit

setopt completealiases
setopt correct
setopt autocd
setopt notify

#runhelp
autoload -Uz run-help
unalias run-help
alias help=run-help

#insert sudo
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# Meta-u to chdir to the parent `directory
bindkey -s '\eu' '^Ucd ..; ls^M'

# End of lines added by compinstall
PROMPT=" %{$fg_bold[blue]%} »  "
RPROMPT="%{$fg[blue]%}%M:%{$fg_bold[yellow]%}%~%{$reset_color%}   "

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
alias svim="sudo vim"
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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
