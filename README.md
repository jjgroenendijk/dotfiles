# dotfiles
Linux desktop customization
More info on storing dotfiles [here](https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/).

## Setup
This is the basic setup for a dotfile git:

  git init --bare $HOME/.dotfiles
  alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  dotconfig config --local status.showUntrackedFiles no
  echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.config/zsh/.zshrc
  dotconfig remote add main git@github.com:jjgroenendijk/dotfiles.git
  dotconfig push --set-upstream main main
  dotconfig status

## Migrate
Installing dotfiles on another machine. The file alias file might be different. On a fresh machine it's probably ~/.zshrc or ~/.bashrc

  alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.config/zsh/.zshrc
  echo ".dotfiles" >> .gitignore
  git clone --bare git@github.com:jjgroenendijk/dotfiles.git $HOME/.dotfiles
  config checkout

In case some files already exist:

  mkdir -p .config-backup && \
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}
  config checkout
  dotconfig config --local status.showUntrackedFiles no
