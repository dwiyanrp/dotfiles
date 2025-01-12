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
git clone -b dev git@github.com:dwiyanrp/sesh.git
cd sesh
go install
```

to clone it 

```
cd
git clone git@github.com:dwiyanrp/dotfiles.git
ln -sf dotfiles/.customzsh
ln -sf dotfiles/sesh-connect.sh
ln -sf ~/dotfiles/vscode/settings.json /Users/dwiyanrp/Library/Application\ Support/Code/User/settings.json
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
