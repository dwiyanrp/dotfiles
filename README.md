# dotfiles
all configuration files for my machine

requires tmux fzf eza
```
brew install tmux fzf eza
```

requires sesh
```
mkdir -p $GOPATH/src/github.com/joshmedeski
cd $GOPATH/src/github.com/joshmedeski
git clone -b 16-preview-support git@github.com:dwiyanrp/sesh.git
cd sesh
go install
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
