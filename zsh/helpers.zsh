# Helper functions
function has_bin(){ for var in "$@"; do which $var 2>/dev/null >&2; done; }
function source_if_exists(){ for var in "$@"; do test ! -r "$var" || source "$var"; done; }
function maybe_run_bin(){ if has_bin "$1"; then eval "$@"; fi; }
function maybe_eval_bin(){ if has_bin "$1"; then eval "$($*)"; fi; }
function maybe_add_fpath(){ if test ! -d "$1"; then return; fi; export -U FPATH="$1${FPATH:+:$FPATH}" ;}
function maybe_add_fpaths(){ for p in "$@"; do maybe_add_fpath "$p"; done; }
function maybe_add_path(){ if test ! -d "$1"; then return; fi; export -U PATH="$1${PATH:+:$PATH}" ;}
function maybe_add_paths(){ for p in "$@"; do maybe_add_path "$p"; done; }

# List all defined options, in a more pretty way.
function list-fpath(){ echo "${FPATH}" | tr ":" "\n" ;}
function list-path(){ echo "${PATH}" | tr ":" "\n" ;}
function list-hosts(){ cat /etc/hosts |column -t ;}
function list-users(){ cat /etc/passwd |column -ts: | sort -nk3 ;}
function list-keybinds(){ bindkey |grep -v "magic-space"  |tr -d "\""| column -t ;}

function dotfiles::run-navi() {  BUFFER=" navi"; zle accept-line; }
function dotfiles::skim-files-in-directory() {  BUFFER=" sk --ansi -i -c 'grep -rI --color=always --line-number \"{}\" .'"; zle accept-line; }
function dotfiles::skim-directory() {  BUFFER=' vim -p $(find . -type f | sk -m)'; zle accept-line; }

function background() { # starts one or multiple args as programs in background
  for ((i=2;i<=$#;i++)); do ${@[1]} ${@[$i]} &> /dev/null &; done
}

function scp_to_same(){ scp -rp "$1" "$2:$1" ;}
function uuid() { # Usage: uuid
  C="89ab"
  for ((N=0;N<16;++N)); do
      B="$((RANDOM%256))"
      case "$N" in
          6)  printf '4%x' "$((B%16))" ;;
          8)  printf '%c%x' "${C:$RANDOM%${#C}:1}" "$((B%16))" ;;
          3|5|7|9) printf '%02x-' "$B" ;;
          *) printf '%02x' "$B" ;;
      esac
  done
  printf '\n'
}


typeset -a baliases; baliases=(); # blank aliases
typeset -a ialiases; ialiases=(); # ignored aliases
function balias() { alias $@; args="$@"; args=${args%%\=*}; baliases+=(${args##* }); }
function ialias() { alias $@; args="$@"; args=${args%%\=*}; ialiases+=(${args##* }); }
function expand-alias-space() {
  [[ $LBUFFER =~ "\<(${(j:|:)ialiases})\$" ]]; ignored=$?
  [[ $LBUFFER =~ "\<(${(j:|:)baliases})\$" ]]; insertBlank=$?
  if [[ "$ignored" = "0" ]]; then return; fi
  # zle _expand_alias
  zle self-insert
  if [[ "$insertBlank" = "0" ]]; then zle backward-delete-char; fi
}

