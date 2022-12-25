#!/usr/bin/env zsh
autoload -Uz compinit promptinit colors
compinit
promptinit
colors

# ignore duplicate history, share history between login, alias commad completion
setopt histignorealldups sharehistory completealiases

zstyle ':completion:*' menu select

PROMPT="%{$fg[red]%}%T%{$reset_color%} %{$fg[green]%}%1~ %{$fg[blue]%}%# %{$reset_color%}"
# correct the spell mistake
setopt correct
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [Yes, No, Abort, Edit] "

# use emacs keybind
bindkey -e emacs

# command history setting
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=/wks/.cache/zsh/.history

# ignore Ctrl-C
set -o ignoreeof

# setting worksapce stack
DIRSTACKFILE="/wks/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus


# TODO
# add plugin from zplug: https://wiki.debian.org/Zsh

if [ -f ~/.zsh_alias ]; then
	. ~/.zsh_alias
fi

if [ -f ~/.zsh_env ]; then
	. ~/.zsh_env
fi

if [ -f ~/.zsh_cmd ]; then
	. ~/.zsh_cmd
fi
