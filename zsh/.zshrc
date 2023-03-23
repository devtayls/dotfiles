# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/taylorpine/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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
plugins=(git zsh-autosuggestions zsh-syntax-highlighting colored-man-pages mix asdf zsh-interactive-cd)

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
alias zshconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"
alias reload="source ~/.zshrc"
alias clean-deps="rm package-lock.json && rm -rf ./node_modules && npm i"
alias bump="git push --force-with-lease"
alias git-bump="git push --force-with-lease"
alias git-oops="git commit --amend --no-edit && git push --force-with-lease"

# Replace Ls with exa
alias ls='exa -a --icons --color=always --group-directories-first'
alias la='exa -al --icons --color=always --group-directories-first'
alias ll='exa -l --icons --color=always --group-directories-first'
alias lt='exa -aT --icons --color=always --group-directories-first'

# Replace common file ops with more interactive versions
alias mv="mv -iv"
alias cp="cp -iv"
alias rm="rm -v"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

. /opt/homebrew/opt/asdf/libexec/asdf.sh
export GPG_TTY=$(tty)

# Custom Path Exports:
export PATH=/usr/local/bin:$PATH

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Enable tty
export GPG_TTY=$TTY

# Sauce Labs
export SAUCE_USERNAME="tayls"
export SAUCE_ACCESS_KEY="9e89baa4-e7da-465a-aac8-11265f4c1a73"

#font-awesome
export FONTAWESOME_NPM_AUTH_TOKEN="06536BB0-ECE8-4A79-941F-416036FE5BD2"


autoload -U colors && colors
local returncode="%(?..%{$fg[red]%} %? ↵%{$resetcolor%})"
export RPS1='$(gitinfo)${returncode}'
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
# Add local path for user-created scripts
export PATH="$HOME/.local/bin:$PATH"

# function to forward ports to your local machine for inspecting preview deployments databases
forward-preview() {

echo "kubectl" "port-forward deployment/houston" "5400:5432" "-n $1"

}
export PATH=$PATH:/Users/taylorpine/.spicetify

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/taylorpine/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/taylorpine/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/taylorpine/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/taylorpine/google-cloud-sdk/completion.zsh.inc'; fi

# Enable erlang iex history
export ERL_AFLAGS="-kernel shell_history enabled"

# Enable dirEnv
# https://direnv.net/docs/hook.html
eval "$(direnv hook zsh)"

# Enable Deno
export DENO_INSTALL="/Users/taylorpine/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Steven's Man suggestion
export MANPAGER="nvim +Man!"
