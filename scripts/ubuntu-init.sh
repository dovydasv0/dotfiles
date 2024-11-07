#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get install python-dev python-pip python3-dev python3-pip -y

declare -a simple_install=("unzip" "git" "tmux" "zsh" "neovim" "stow" "build-essential")

for i in "${simple_install[@]}"; do
	if which "$i" > /dev/null; then
		echo "$i exists ----------------------------------------------------------------------"
	else
		echo "installing $i ------------------------------------------------------------------"
		sudo apt install "$i" -y
	fi
done

if which "oh-my-posh" > /dev/null; then
	echo "oh-my-posh exists ------------------------------------------------------------------"
else
	echo "installing oh-my-posh --------------------------------------------------------------"
	sudo curl -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /bin
fi

mkdir -p dotfiles
git clone https://github.com/dovydasv0/dotfiles.git ./dotfiles/
cd ./dotfiles
stow .
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
chsh

