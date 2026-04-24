# Fall back to xterm-256color when the incoming TERM has no matching
# terminfo entry on this BusyBox image. Common when SSHing from tmux or
# GNU screen — those set TERM=tmux-256color / screen.xterm-256color
# which are not shipped in /usr/share/terminfo here, so ncurses apps
# like dialog (and therefore luckfox-config) abort with
# "Error opening terminal: ...".
case "$TERM" in
    tmux*|screen*) export TERM=xterm-256color ;;
esac
