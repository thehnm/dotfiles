export NVM_DIR=$HOME/.local/nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export DOCKER_HOST=unix:///run/user/1000/docker.sock
export GOPATH=$HOME/.local/go
export PATH=$HOME/.local/bin:/opt/nvim-linux64/bin:/usr/local/go/bin:$GOPATH/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export EDITOR="nvim"
export BROWSER="brave"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/password-store
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
export PYTHONPATH=/usr/lib/python3.10/dist-packages:/usr/lib/python3.10/site-packages:$PYTHONPATH
export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH

export HISTFILE=$XDG_DATA_HOME/zsh/history
export HISTSIZE=50000
export SAVEHIST=50000
export WORDCHARS=${WORDCHARS//\/[&.;]}       # Don't consider certain characters part of the word

export ZSH_CUSTOM_CONFIG_DIR=$XDG_CONFIG_HOME/zsh.d

source <(antibody init)
antibody bundle < $XDG_CONFIG_HOME/antibody/zsh_plugins.txt

if command -v fzf > /dev/null 2>&1; then
    if ! fzf --zsh > /dev/null 2>&1; then # fzf version < 0.48.0
        if [[ -r /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
        source /usr/share/doc/fzf/examples/key-bindings.zsh
        fi
        if [[ -r /usr/share/doc/fzf/examples/completion.zsh ]]; then
            source /usr/share/doc/fzf/examples/completion.zsh
        fi
    else
        source <(fzf --zsh)
    fi
fi

autoload -U colors && colors
autoload -Uz compinit
[ -f $XDG_CACHE_HOME/zcompdump ] \
  && compinit -d $XDG_CACHE_HOME/zcompdump \
  || compinit -C -d $XDG_CACHE_HOME/zcompdump

setopt correct                        # Auto correct mistakes
setopt extendedglob                   # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                     # Case insensitive globbing
setopt rcexpandparam                  # Array expension with parameters
setopt nocheckjobs                    # Don't warn about running processes when exiting
setopt numericglobsort                # Sort filenames numerically when it makes sense
setopt nobeep                         # No beep
setopt appendhistory                  # Immediately append history instead of overwriting
setopt histignorealldups              # If a new command is a duplicate, remove the older one
setopt autocd                         # if only directory path is entered, cd there.
setopt prompt_subst                   # enable substitution for prompt

zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

local ret_status="%(?:%{$fg_bold[green]%}#:%{$fg_bold[red]%}#)"
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} '

alias e='nvim'
alias cp='cp -iv'
alias df='df -h'
alias free='free -m'
alias l='exa -la'
alias ls='exa'
alias ln='ln -v'
alias chmod='chmod -c'
alias chown='chown -c'
alias mkdir='mkdir -v'
alias mv='mv -iv'
alias rm='rm -v'
alias cp='cp -iv'
alias rsync='rsync -avP'
alias um='udiskie-umount -a'
alias yay='yay --color=auto'
alias pacman='pacman --color=auto'
alias f='ranger'
alias e='nvim'
alias ydm='yt-dlp -x -f bestaudio --audio-format vorbis'
alias tsm='transmission-remote'
alias pr='pipenv run python'
alias pe='source "$(pipenv --venv)/bin/activate"'
alias vim='nvim'
alias lazydot='lazygit -w $HOME -g $HOME/.dotfiles'

# Git aliases
alias ga='git add'
alias gcmsg='git commit -m'
alias gpu='git push'
alias gsb='git status -b'
alias glog='git log'
alias gdiff='git diff'

# Dotfile aliases
alias dg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dgs='dg status -b'
alias dga='dg add'
alias dgc='dg commit'
alias dgcmsg='dg commit -m'
alias dglog='dg log'
alias dgdiff='dg diff'
alias dgpu='dg push'
alias dlazygit='lazygit -g $HOME/.dotfiles -w $HOME'

alias pandock='docker run --rm -v "$(pwd):/data" pandoc/core'

if [[ -d "$ZSH_CUSTOM_CONFIG_DIR" ]]; then
    for custom_config in $ZSH_CUSTOM_CONFIG_DIR/*; do
        if [[ -r "$ZSH_CUSTOM_CONFIG_DIR"/"$custom_config" ]]; then
            source $ZSH_CUSTOM_CONFIG_DIR/$custom_config
        fi
    done
fi
