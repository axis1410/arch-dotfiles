POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
source /usr/share/cachyos-zsh-config/cachyos-config.zsh

export LANG=en_IN.UTF-8
export LC_ALL=en_IN.UTF-8


# ─────────────────────────────────────────────
#  PATH
# ─────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"

# ─────────────────────────────────────────────
#  HISTORY
# ─────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# ─────────────────────────────────────────────
#  PLUGINS
#  (expects zsh-autosuggestions & zsh-syntax-highlighting installed via pacman)
# ─────────────────────────────────────────────
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autosuggestions style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ─────────────────────────────────────────────
#  FZF
# ─────────────────────────────────────────────
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --info=inline
  --bind 'ctrl-/:toggle-preview'
"

# use fd if available (faster, respects .gitignore)
if command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
fi

# ─────────────────────────────────────────────
#  ZOXIDE  (smart cd)
# ─────────────────────────────────────────────
eval "$(zoxide init zsh)"
alias cd="z"   # make cd use zoxide transparently

# ─────────────────────────────────────────────
#  ALIASES — general
# ─────────────────────────────────────────────
# use eza if present, fall back to ls
if command -v eza &>/dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -lh --icons --group-directories-first --git"
  alias la="eza -lha --icons --group-directories-first --git"
  alias tree="eza --tree --icons"
else
  alias ls="ls --color=auto"
  alias ll="ls -lh --color=auto"
  alias la="ls -lha --color=auto"
fi

alias ..="cd .."
alias ...="cd ../.."
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias mkdir="mkdir -pv"
alias grep="grep --color=auto"
alias cat="bat --paging=never"       # remove if bat isn't installed
alias df="df -h"
alias du="du -sh"

alias lg="lazygit"

# editor
export EDITOR="nvim"
export VISUAL="nvim"
alias vi="nvim"
alias vim="nvim"

# ─────────────────────────────────────────────
#  ALIASES — pacman / yay
# ─────────────────────────────────────────────
alias pac="sudo pacman -S"
alias pacu="sudo pacman -Syu"
alias pacr="sudo pacman -Rns"
alias pacs="pacman -Ss"
alias pacq="pacman -Qi"
alias ya="yay -S"
alias yau="yay -Syu"

# ─────────────────────────────────────────────
#  ALIASES — git
# ─────────────────────────────────────────────
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gd="git diff"

# ─────────────────────────────────────────────
#  nwg-displays — always write to modules/monitors.conf
# ─────────────────────────────────────────────
alias nwg-displays="nwg-displays -m ~/.config/hypr/modules/monitors.conf"

# ─────────────────────────────────────────────
#  COMPLETION
# ─────────────────────────────────────────────
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ─────────────────────────────────────────────
#  KEYBINDINGS
# ─────────────────────────────────────────────
bindkey -e                        # emacs keys (Ctrl-A/E, etc.)
bindkey '^[[A' history-search-backward   # up arrow searches history
bindkey '^[[B' history-search-forward    # down arrow searches history

# ─────────────────────────────────────────────
#  STARSHIP PROMPT  (must be last)
# ─────────────────────────────────────────────
# cachyos-config.zsh loads p10k — disable it so starship takes over
function prompt_powerlevel9k_setup() {}
function _p9k_precmd() {}
eval "$(starship init zsh)"

