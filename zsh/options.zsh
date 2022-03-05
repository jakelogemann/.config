

# Standard ZSH Options                                              {{{1
#=======================================================================
setopt cbases cprecedences
setopt autocd autopushd pushdsilent pushdignoredups pushdtohome
setopt cdablevars interactivecomments printexitvalue shortloops
setopt localloops localoptions localpatterns
setopt pipefail vi evallineno

# Autocompletion
setopt hashdirs hashcmds 
setopt aliases 
setopt automenu 
setopt autoparamslash 
setopt autoremoveslash 
setopt completealiases 
setopt promptbang promptcr promptsp promptpercent promptsubst transientrprompt 
setopt listambiguous 
setopt listpacked 
setopt listrowsfirst 
setopt autolist 
setopt markdirs

setopt banghist 
setopt histbeep 
setopt inc_append_history
setopt histexpiredupsfirst 
setopt histignorealldups 
setopt histnostore 
setopt histfcntllock 
setopt histfindnodups 
setopt histreduceblanks 
setopt histsavebycopy 
setopt histverify 
setopt sharehistory

# Shell History
HISTFILE="$HOME/.zhistory" 
SAVEHIST=50000  # Total lines to save in zsh history.
HISTSIZE=1000   # Lines of history to save to save from the current session.

unsetopt correct correctall flowcontrol 

# Job Control
unsetopt flowcontrol   #Disable ^S & ^Q.
setopt autocontinue autoresume bgnice checkjobs notify longlistjobs
setopt checkrunningjobs 
