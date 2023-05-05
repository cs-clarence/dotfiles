# create a function to launch tmux with provided session, window, and layout name
# params:
# {} - value
# <> - required
# [] - optional
# <{layout_name}>
# [-s {session_name}]
# [-w {window_name}]


tmuxl() {
  local OPTIND OPTARG
  echo "Launching tmux with layout $1"
  getopt -o s:w: -l session:,window: -- "$@"
  echo "session: $session, window: $window"
}
