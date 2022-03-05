
# ZSH Style Configurations                                          {{{1
#=======================================================================
zstyle ':completion:*'                cache-path        "$zsh_dir/completion.cache"
zstyle ':completion:*'                completer         _complete _match _approximate _expand_alias
zstyle ':completion:*'                file-list         list=20 insert=10
zstyle ':completion:*'                squeeze-slashes   true
zstyle ':completion:*'                use-cache         on
zstyle ':completion:*:*:kill:*'       menu              yes select
zstyle ':completion:*:(all-|)files'   ignored-patterns  '(|*/)CVS'
zstyle ':completion:*:default'        list-dirs-first   true
zstyle ':completion:*:approximate:*'  max-errors        1 numeric
zstyle ':completion:*:cd:*'           ignore-parents    parent pwd
zstyle ':completion:*:cd:*'           ignored-patterns  '(*/)#CVS'
zstyle ':completion:*:functions'      ignored-patterns  '_*'
zstyle ':completion:*:kill:*'         force-list        always
zstyle ':completion:*:match:*'        original          only
zstyle ':completion:*:rm:*'           file-patterns     '*.log:log-files' '%p:all-files'
