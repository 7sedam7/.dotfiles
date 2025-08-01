# Machine setup

## Keyboardb
Salt & Pipar split keyboard

[config](https://zmk.studio/) --> press `ESC` + `'`
[timeless setup](https://github.com/urob/zmk-config#timeless-homerow-mods) that I did not do yet.

## Initial setup
`xcode-select --install`

## Settup git
```
# generate ssh key
ssh-keygen -t ed25519 -C "<your email>"

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

## Nvim dev
### Rust
Run `:MasonInstall rust-analyzer`
Run `:MasonInstall codelldb`

### Lua
Run `cargo install stylua`

### Markdown
Run `:MasonInstall marksman`

## Extra
Nvim uses nvchad and my config is in /lua/chadrc.lua and /config/lspconfig.lua

Plex server config not included.

Libation is not on homebrew. (used for fetching my audible library)

## Aider
Config is loaded from dir where you run Aider, so the `.env` needs to be coppied to where you want to run it.
Deepseek API key needs to be added. (Or some other model configured)
