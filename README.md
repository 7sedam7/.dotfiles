# Machine setup

## Keyboardb
Salt & Pipar split keyboard

[config](https://zmk.studio/)
[timeless setup](https://github.com/urob/zmk-config#timeless-homerow-mods) that I did not do yet.

## Initial setup
`xcode-select --install`

## Settup git
```
# generate ssh key
ssh-keygen -t ed25519 -C "7sedam7@gmail.com"

# Add generated key to keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Add it to github
pbcopy < ~/.ssh/id_ed25519.pub
```

Pull configs
`git clone https://github.com:7sedam7/.dotfiles.git`

## Homebrew
```
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install things based on Brewfile
brew bundle --file ~/.dotfiles/Brewfile

# To create Brewfile based on currently installed things
brew bundle dump --describe
```

## Dotfiles
```
# Raycast needs to be imported through Raycast

# With [stow](https://homebrew-file.readthedocs.io/en/latest/usage.html)
installed run bin/stow.sh script
./bin/stow.sh
```

## Extra
Plex server config not included.
Libation is not on homebrew. (used for fetching my audible library)
