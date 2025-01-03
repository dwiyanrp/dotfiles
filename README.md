# dotfiles
all configuration files for my machine

requires tmux fzf eza
```
brew install tmux fzf eza
```

to clone it 

```
cd
git clone git@github.com:dwiyanrp/dotfiles.git
ln -sf dotfiles/.customzsh
ln -sf dotfiles/.config/sesh/sesh-connect.sh
```

add the following to your .zshrc
```
echo 'source ~/.customzsh' >> ~/.zshrc
source ~/.customzsh
```

execute symlink script
```
ln-config
```
