# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
# →-.   →  .-'.   →  .--.   →  .--.   →  .--.   →  .-→
# →::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::: → →
# → →:.\ https://github.com/nosvagor/.dotfiles \::: → →  →  →
# →::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::→  →
#   → →   `--'  →   `.-'  →   `--'  →   `--'  →   `--' → →


# ╦┌┐┌┬┌┬┐
# ║││││ │
# ╩┘└┘┴ ┴

eval "$(starship init zsh)"
eval "$(thefuck --alias)"
~/.config/zsh/greeting.sh

# autostart startx after login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
startx
fi

# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt share_history


# ╔═╗┬  ┬┌─┐┌─┐┌─┐┌─┐
# ╠═╣│  │├─┤└─┐├┤ └─┐
# ╩ ╩┴─┘┴┴ ┴└─┘└─┘└─┘

# common navigation
alias dl="cd ~/downloads"
alias not="cd ~/notes"
alias dot="cd ~/dotfiles"

# common commands
alias pac='(){sudo pacman -S $1;}'
alias niol='clear && zsh'

alias gts='git status'
alias kurmit='(){git add . && git commit -m"$1" && git push;}'
alias ammend='(){git add . && git commit --ammend --no-edit;}'
alias gp='git pull'
alias n='nvim'

alias eyes='(){xrandr --output HDMI-A-0 --brightness $1;}'
alias eyess='(){xrandr --output eDP-1 --brightness $1;}'

# tmux
alias tls='tmux ls'
alias tad='tmux attach -t \ 🪙'
alias tan='tmux attach -t \ 📓'
alias td='(){tmux detach}'
alias tr='()tmux-session restore'
alias ts='tmux-session save'
alias tk='tmux kill-session'
alias tks='tmux kill-server'


# ╔═╗┬  ┬ ┬┌─┐┬┌┐┌┌─┐
# ╠═╝│  │ ││ ┬││││└─┐
# ╩  ┴─┘└─┘└─┘┴┘└┘└─┘

source ~/.local/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.local/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
  zstyle ':autocomplete:*' min-input 2
source ~/.local/zsh/zsh-colored-man-pages/colored-man-pages.plugin.zsh


# ╔═╗─┐ ┬┌─┐┌─┐┬─┐┌┬┐┌─┐
# ║╣ ┌┴┬┘├─┘│ │├┬┘ │ └─┐
# ╚═╝┴ └─┴  └─┘┴└─ ┴ └─┘

export GOPATH="$HOME/.go"
export PATH="$PATH:$HOME/.go/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"


# ┌─┐┬─┐ ┬  ┬┌─┌─┐┬ ┬┌─┐
# ├┤ │┌┴┬┘  ├┴┐├┤ └┬┘└─┐
# └  ┴┴ └─  ┴ ┴└─┘ ┴ └─┘

bindkey  "^[[1~"    beginning-of-line
bindkey  "^[[3~"    delete-char
bindkey  "^[[4~"    end-of-line
bindkey  "^[[1;5C"  forward-word
bindkey  "^[[1;5D"  backward-word
bindkey  "^S"       history-incremental-search-forward
bindkey  "^R"       history-incremental-search-backward
