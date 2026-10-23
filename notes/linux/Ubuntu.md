```bash
# Check Ubuntu Server
# Ubuntu 14.04.3 LTS
lsb_release -a


# Basic updates
sudo apt-get update
sudo apt-get upgrade
```

## Git + ZSH
```bash
# install git
sudo apt-get install git

# configure git
git config --global color.ui true
git config --global core.editor "vim"
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR@EMAIL.com"
ssh-keygen -t rsa -C "YOUR@EMAIL.com"

# vim as editor
export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR="$VISUAL"

# install zsh and oh-my-zsh
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# copy ssh key
cat ~/.ssh/id_rsa.pub

# test github connection
ssh -T git@github.com
```

## Ruby + Rbenv
```bash
# Ruby Dependencies
sudo apt-get install curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

# install rbevn
# https://github.com/sstephenson/rbenv#installation
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# restart shell
exec $SHELL

# test rbenv
type rbenv
#=> "rbenv is a function"

# ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# install ruby
rbenv install -l
rbenv install 2.2.3
rbenv global 2.2.3
rbenv rehash

# disable documentation for gems
echo "gem: --no-ri --no-rdoc" > ~/.gemrc

# install bunder
gem install bundler
```

## Node.js + NVM
```bash
# install nvm
# https://github.com/creationix/nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh | bash
exec $SHELL

# install node.js
nvm install stable
nvm alias default stable
```


## Databases
```bash 
# install mysql
sudo apt-get install mysql-server mysql-client libmysqlclient-dev

# add postgresql repo
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

# install postgresql
sudo apt-get update
sudo apt-get install postgresql-common
sudo apt-get install postgresql-9.3 libpq-dev

# set postgres user
sudo -u postgres createuser vadim -s

# set password
sudo -u postgres psql
postgres=# \password vadim
```


## Samba Server
```bash
# install samba file sharing
sudo apt-get install samba

# configure shares
# workgroup = WORKGROUP
#[ubu-shared]
#   comment = Shared
#   path = /home/vadim/ubu-shared
#   browseable = yes
#   read only = no
#   guest ok = no
#   writeable = yes
sudo vim /etc/samba/smb.conf 

# add user to samba
sudo smbpasswd -a vadim

# restart the sambe service
sudo restart smbd
sudo restart nmbd
```


## Testing Rails
```bash
# testing rails app
rails new myapp                # SQLite
rails new myapp -d mysql       # MySQL
rails new myapp -d postgresql  # Postgres

# If you setup MySQL or Postgres with a username/password, modify the
# config/database.yml file to contain the username/password that you specified

# Create the database
rake db:create
rake db:migrate

# Rails Server
rails server

# Accessing Rails Server from the VM
rails server -b 10.0.9.31
```


## Clojure
```bash
# Install Clojure
sudo apt-get install open-jdk-7-jre-headless
sudo wget -P /usr/bin/ https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
cd /use/bin
sudo chmod a+z lein
lein
```


## Elixir
```bash
# Add Erlang Solutions repo
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get install elixir
```


## Elm
```bash
# Need to have node installed
npm install -g elm
```


## Misc Commands
```bash
# Power off the Server
sudo poweroff
sudo reboot
```


## Refences
- [GoRails](https://gorails.com/setup/ubuntu/15.04)
- [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server)