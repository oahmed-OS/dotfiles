reload() {
    source ~/.zshrc
}

# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH=/Library/TeX/texbin:$PATH

JAVA_HOME=/opt/homebrew/Cellar/openjdk/22.0.2/libexec/openjdk.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
export M2_HOME=/opt/homebrew/opt/maven
export PATH=$M2_HOME/bin:$PATH

alias zed="open -a /Applications/Zed.app -n"

alias meow="echo meow"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix --follow'
# export FZF_DEFAULT_OPTS=' --height=40% --preview="bat --color=always {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_OPTS='--ansi --multi --height=60% --preview="$HOME/.config/zsh/preview.zsh {}" --preview-window=right:50%'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --follow"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow . "$1"
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
