# Machine setup

`xcode-select --install`

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

## Settup git
```
# generate ssh key
ssh-keygen -t ed25519 -C "7sedam7@gmail.com"

# Add generated key to keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Add it to github
pbcopy < ~/.ssh/id_ed25519.pub
```
