#
# ~/.bash_profile
#
export PATH="${PATH}:/home/ebc/altera/quartus/bin:/home/ebc/altera/modelsim_ae/bin:/home/ebc/altera/modelsim_ase/bin:/home/ebc/altera/modelsim_ase/linuxaloem:/home/ebc/altera/modelsim_ae/linuxaloem"
[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
export PATH="${PATH}:/home/ebc/.scripts:/home/ebc:/home/ebc/opt/altera/quartus/bin:/home/ebc/opt/altera/modelsim_ase/bin