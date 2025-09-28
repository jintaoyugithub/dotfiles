# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit directory and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}}/.local/share}/zinit/zinit.git"

# download zinit if not found
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# source/load zinit
source "${ZINIT_HOME}/zinit.zsh"

# -- Plugins --
zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# -- Completions and suggestions config --
HISTSIZE=100
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space # allow you to ignore some commands by typing a space before it
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # disable case sensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# -- Snippets --
# check https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
zinit snippet OMZP::git

# Auto load plugins
autoload -U compinit && compinit

zinit cdreplay -q # call compinit once

# -- Keybindings --
bindkey '^p' history-search-backward  # allow search command history related to specific command
bindkey '^n' history-search-forward 

# -- Alias --
alias ls='ls --color'
alias c='clear'
alias nv="nvim"
alias yz='yazi'
alias lg='lazygit'

alias tns='tmux'
alias tas='tmux attach-session -t'
alias tl='tmux ls'
alias tkS='tmux kill-server'
alias tks='tmux kill-session -t'
alias tkw='tmux kill-window'
alias tlw='tmux list-windows'

# set default editor
export VISUAL=nvim;
export EDITOR=nvim;

# set font encoding
export LANG=en_US.UTF-8

# vulkan sdk
VULKAN_SDK="$HOME/VulkanSDK/1.4.304.0"

# -- Shell integrations --
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
