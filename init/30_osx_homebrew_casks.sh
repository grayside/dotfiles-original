# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask keg and recipe are installed.
kegs=(
  caskroom/cask
  phase2/devtools
)
brew_tap_kegs
recipes=(brew-cask)
brew_install_recipes

# Exit if, for some reason, cask is not installed.
[[ ! "$(brew ls --versions brew-cask)" ]] && e_error "Brew-cask failed to install." && return 1

# Hack to show the first-run brew-cask password prompt immediately.
brew cask info this-is-somewhat-annoying 2>/dev/null

# Homebrew casks
casks=(
  # Applications
  1password
  chromium
  devtools
  dropbox
  fastscripts
  firefox
  flowdock
  google-chrome
  gyazo
  hermes
  hex-fiend
  iterm2
  macvim
  omnidisksweeper
  phase2/devtools/docker
  phase2/devtools/docker-machine
  phase2/devtools/docker-compose
  race-for-the-galaxy
  remote-desktop-connection
  skype
  slack
  sourcetree
  spotify
  teamviewer
  the-unarchiver
  todoist
  transmission-remote-gui
  vagrant
  virtualbox
  vlc
  android-file-transfer
  nano
  # Quick Look plugins
  betterzipql
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  quicknfo
  suspicious-package
  webpquicklook
  # Color pickers
  colorpicker-developer
  colorpicker-skalacolor
)

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew cask install $cask
  done
  brew cask cleanup
fi

# Work around colorPicker symlink issue.
# https://github.com/caskroom/homebrew-cask/issues/7004
cps=()
for f in ~/Library/ColorPickers/*.colorPicker; do
  [[ -L "$f" ]] && cps=("${cps[@]}" "$f")
done

if (( ${#cps[@]} > 0 )); then
  e_header "Fixing colorPicker symlinks"
  for f in "${cps[@]}"; do
    target="$(readlink "$f")"
    e_arrow "$(basename "$f")"
    rm "$f"
    cp -R "$target" ~/Library/ColorPickers/
  done
fi
