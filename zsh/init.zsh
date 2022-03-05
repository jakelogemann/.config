# ----------------------------------------------- #
#     888888888888             88                 #
#              ,88             88                 #
#            ,88"              88                 #
#          ,88"     ,adPPYba,  88,dPPYba,         #
#        ,88"       I8[    ""  88P'    "8a        #
#      ,88"          `"Y8ba,   88       88        #
#     88"           aa    ]8I  88       88        #
#     888888888888  `"YbbdP"'  88       88        #
# ------------------------------------------------#
#   Author:                                       #
#     Jake Logemann (github.com/JakeLogemann)     #
# ------------------------------------------------#
XDG_CONFIG_DIR="${XDG_CONFIG_DIR:-$HOME/.config}"
zsh_dir="${XDG_CONFIG_DIR}/zsh"
source "${zsh_dir}/helpers.zsh"

maybe_add_fpaths "$zsh_dir/completions" "$zsh_dir/functions" 
maybe_add_paths  \
  "$HOME/.cargo/bin" \
  "$HOME/.fzf/bin" \
  "${GOPATH:-$HOME/go}/bin" \
  "${GOROOT:-/usr/lib/go}/bin" \
  "$HOME/.local/bin" \
  "$HOME/.pyenv/bin" \
  "$HOME/.pyenv/shims" \
  "$HOME/.rbenv/bin" \
  "$HOME/.rbenv/shims" \
  "/Library/Apple/usr/bin" \
  "/bin" \
  "/opt/homebrew/bin" \
  "/opt/homebrew/sbin" \
  "/sbin" \
  "/usr/bin" \
  "/usr/local/bin" \
  "/usr/local/sbin" \
  "/usr/sbin" 

# Third-Party/Vendor Scripts                                        {{{1
#=======================================================================
maybe_eval_bin direnv hook zsh
maybe_eval_bin rbenv init -
maybe_eval_bin pyenv init -
source_if_exists "$HOME/.profile"
source_if_exists "$HOME/.rbenv/completions/rbenv.zsh"

if type brew &>/dev/null; then FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"; fi
if [[ -n "${SSH_CONNECTION}" && "$TERM" == "alacritty" ]]; then export TERM=xterm-256color; fi
if [[ -n "${GPG_TTY:-}" ]]; then export GPG_TTY=$(tty); fi

# ZSH Modules {{{1
zmodload \
  "zsh/attr" \
  "zsh/cap" \
  "zsh/clone" \
  "zsh/complete" \
  "zsh/complist" \
  "zsh/computil" \
  "zsh/curses" \
  "zsh/langinfo" \
  "zsh/mathfunc" \
  "zsh/parameter" \
  "zsh/regex" \
  "zsh/sched" \
  "zsh/system" \
  "zsh/termcap" \
  "zsh/terminfo" \
  "zsh/zle" \
  "zsh/zleparameter" \
  "zsh/zpty" \
  "zsh/zselect" \
  "zsh/zutil"

autoload -Uz promptinit colors compinit bashcompinit;
promptinit && colors && compinit && bashcompinit

# Aliases                                                           {{{1
#=======================================================================
if has_bin lsd; then
  ialias l1='lsd -1'
  ialias l='lsd'
  ialias ll='lsd -Alh --date relative --size short --no-symlink'
  ialias ls='lsd -A'
  ialias lss='lsd -Alh --date relative --size short --no-symlink --sizesort'
  ialias lst='lsd -Alh --date relative --size short --no-symlink --timesort'
else
  ialias l1='ls -1'
  ialias l='ls'
  ialias ll='ls -Alh'
  ialias ls='ls -A'
  ialias lss='ls -Alh'
  ialias lst='ls -Alh'
fi

for e in "e" "nano" "pico" "vi" "edit"; do ialias $e="$EDITOR"; done
while IFS= read -r line; do eval "ialias $line"; done < "$HOME/.config/aliases.ini"

source_if_exists "$HOME/.nix-profile/etc/profile.d/nix.sh"
source_if_exists "${XDG_CONFIG_DIR}/zsh/options.zsh"
source_if_exists "${XDG_CONFIG_DIR}/zsh/completion.zsh"
source_if_exists "${XDG_CONFIG_DIR}/zsh/keybinds.zsh"
source_if_exists "${XDG_CONFIG_DIR}/zsh/plugins/skim.zsh"
source_if_exists "${HOME}/.iterm2_shell_integration.zsh"

maybe_eval_bin starship init zsh
maybe_eval_bin zoxide init --cmd="goto" zsh
