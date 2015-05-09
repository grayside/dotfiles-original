# Editing

if [[ ! "$SSH_TTY" ]] && is_osx; then
  export EDITOR='mvim'
  export LESSEDIT='mvim ?lm+%lm -- %f'
else
  export EDITOR='vim'
fi

export VISUAL="$EDITOR"
alias q="$EDITOR"
alias qv="q $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias qs="q $DOTFILES"

# Tabs to Spaces, Indent by 2, Preserve indentation level on carriage return.
alias nano="/opt/boxen/homebrew/bin/nano"
alias nani="nano -i -E -T 2"
