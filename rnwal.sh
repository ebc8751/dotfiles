#!/bin/sh

sleep 1
pkill polybar &&
sleep 1
/home/ebc/wal -i "$(< "${HOME}/.cache/wal/wal")"
polybar bar &
polybar top &
sleep .5
