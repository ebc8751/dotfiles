[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null

export PATH="${PATH}:/home/ebc/.scripts:/home/ebc:/home/ebc/altera/quartus/bin:/home/ebc/altera/modelsim_ase/bin:/home/ebc/altera/modelsim_ase/linuxaloem"

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi

