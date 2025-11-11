# Initial Setup of p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -- sourcing alias
[ -f "$xDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"

# -- setting module init directory [ with bug check ]
ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# -- source zinit
source "${ZINIT_HOME}/zinit.zsh"

# -- zinit modules
zinit ice depth=1; zinit light romkatv/powerlevel10k # pwd UI
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # remove case sensitivity
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # add colors everywhere
zstyle ':completion:*' menu no # not interrupt with fzf gui
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
eval "$(fzf --zsh)" #fzf shell integration fuzzy search

# -- load modules
autoload -U compinit && compinit 

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# -- keybinds
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
bindkey "^[[3~" delete-char # delete key
bindkey "^H" backward-delete-word # ctrl bkspc key
bindkey "^[[5~" delete-word # ctrl delete key
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[2~" yank # paste with Insert key

# -- aliases
alias ll='ls --color -lahX'

# -- history manager
HISTFILE="$XDG_CACHE_HOME/zsh_history"
HISTSIZE=2048
SAVEHIST=2048
HISTCONTROL=ignoreboth
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Created by `pipx` on 2025-07-26 20:16:02
export PATH="$PATH:$HOME/.local/bin"
