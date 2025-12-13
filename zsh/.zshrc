# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/taylorpine/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Disabled in favor of Starship prompt
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting colored-man-pages mix zsh-interactive-cd fzf-tab zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias reload="source ~/.zshrc"
alias clean-deps="rm package-lock.json && rm -rf ./node_modules && npm i"
alias bump="git push --force-with-lease"
alias git-bump="git push --force-with-lease"
alias git-oops="git commit --amend --no-edit && git push --force-with-lease"

# Replace Ls with lsd
alias ls='lsd -a --icon=auto --color=always --group-directories-first'
alias la='lsd -al --icon=auto --color=always --group-directories-first'
alias ll='lsd -l --icon=auto --color=always --group-directories-first'
alias lt='lsd -aT --icons=auto --color=always --group-directories-first'


# Replace common file ops with more interactive versions
alias mv="mv -iv"
alias cp="cp -iv"
alias rm="rm -v"

# Language Specific
# Elixir
alias e='iex -S mix phx.server || (code=$?; [ $code -gt 1 ] && iex -S mix start || iex)'

# Vim
# alias n='nvim +"Telescope find_files"'
alias n='nvim'

# Kitty theme switcher
alias ktheme='~/.config/kitty/switch-theme.sh'

export GPG_TTY=$(tty)

# Custom Path Exports:
export PATH=/usr/local/bin:$PATH

# Mise configuration
eval "$(~/.local/bin/mise activate zsh)"



# Enable tty
export GPG_TTY=$TTY

autoload -U colors && colors
local returncode="%(?..%{$fg[red]%} %? ↵%{$resetcolor%})"
export RPS1='$(gitinfo)${returncode}'
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

# Add local path for user-created scripts
export PATH="$HOME/.local/bin:$PATH"

# Add go language bins
export PATH="$HOME/go/bin:$PATH"

# function to forward ports to your local machine for inspecting preview deployments databases
forward-preview() {

echo "kubectl" "port-forward deployment/houston" "5400:5432" "-n $1"

}

export PATH=$PATH:/Users/taylorpine/.spicetify

# The next line enables shell command completion for gcloud.
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Enable erlang iex history
export ERL_AFLAGS="-kernel shell_history enabled"

# Enable Deno
export DENO_INSTALL="/Users/taylorpine/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Steven's Man suggestion
export MANPAGER="nvim +Man!"

# Set bun on the path
export PATH="$HOME/.cache/.bun/bin:$PATH"

# Stripe auto complete
fpath=(~/.stripe $fpath)
autoload -Uz compinit && compinit -i

# Custom Functions
# Enable runner to watch files saves and perform given command
function w() {
  fd --hidden $1 | entr -c "${@:2}"
}

function ew() {
  w "\.exs?$" "$@"
  # fd "\.exs?$" | entr -c "$@"
}

# Enable fzf for zsh
eval "$(fzf --zsh)"

# Bat configuration
alias cat=bat
export BAT_THEME="nord"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Enable Mix escripts
export PATH=~/.mix/escripts:$PATH

# Initialize Starship prompt
eval "$(starship init zsh)"

# Source local customizations
[[ -f "/Users/taylorpine/.zshrc.local" ]] && source "/Users/taylorpine/.zshrc.local"
