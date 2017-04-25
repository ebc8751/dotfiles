$ [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
export PATH="${PATH}:/home/ebc/.scripts:/home/ebc:/home/ebc/opt/altera/quartus/bin:/home/ebc/opt/altera/modelsim_ase/bin"
