#!/bin/bash
real_dir="$(realpath $(dirname "$0"))"
cd $real_dir
# PUSH
push() {
	# Variabel untuk menyimpan kredensial
	USERNAME="matobodol"
	PASSWORD="$(cat ../file)"

	read -p "commit: " commit
	git branch
	read -p "branch: " branch

	# Remote repository (sesuaikan URL dengan repositori Anda)
	REPO_URL="https://$USERNAME:$PASSWORD@github.com/${USERNAME}/nvim-termux.git"
	REPO_LOCAL="$real_dir"

	[ -d "${HOME}/.config/nvim" ] && echo "chek files" && rm -rf ${REPO_LOCAL}/.config
	[ $? -eq 0 ] && echo "update repo" && cp -r ${HOME}/.config ${REPO_LOCAL}/.config

	[ $? -eq 0 ] && git add . 
	[ $? -eq 0 ] && git status
	[ $? -eq 0 ] && git commit -m "$commit"

	# Push perubahan ke branch utama
	[ $? -eq 0 ] && git push "$REPO_URL" $branch

	if [ $? -eq 0 ]; then
		echo "push suksess"
	else
		echo "not pushed"
	fi
}

# INSTALL
setup_termux() {
	[ ! -d ~/.config ] && mkdir -p .config
	dotfiles="termux"

	git clone https://github.com/matobodol/nvim-termux ~/${dotfiles}
	rm -rf ~/${dotfiles}/{.git/,README.md,script.sh}
	cp -r  ~/${dotfiles}/. ~/ && rm -rf ~/${dotfiles}

	 # setup color scheme
	 path="https://github.com/dracula/termux/archive/master.zip"
	 theme="dracula"

	 curl -L -o ~/${theme}.zip $path
	 unzip -o ~/${theme}.zip -d ~/
	 cp -r ~/termux-master/colors.properties ~/.termux/colors.properties
	 rm -rf ~/{termux-master,${theme}.zip}

	 # setup font
	 path="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip"
	 font="0xproto"

	 curl -L -o ~/${font}.zip $path
	 unzip -o ~/${font}.zip -d ~/
	 cp -r ~/0xProtoNerdFont-Regular.ttf ~/.termux/font.ttf
	 rm -rf ~/{${font}.zip,*.ttf,README.md,LICENSE}

	 [ ! -d "$HOME/storage" ] && termux-setup-storage
	 # termux-change-repo
 }

 install_packages() {
	 pkg update && pkg upgrade -y

	 packages=(
		 neofetch
		 eza
		 starship
		 fish
		 whiptail
		 nodejs
		 neovim
		 build-essential
		 git
		 fd
		 ripgrep
		 python3
		 lua53
		 luarocks
		 lua-language-server
		 wget
		 rust
		 rust-analyzer
	 )

	 pkg install -y "${packages[@]}"
 }

 set_fish_as_default() {
	 shell="fish"
	 current_shell=$(echo $SHELL | awk -F/ '{print $NF}')

	 [ ! $(command -v $shell > /dev/null) ] && pkg install -y $shell
	 if [ "$current_shell" != "$shell" ] && command -v $shell > /dev/null; then
		 chsh -s fish
	 fi
 }


msg="$(
cat <<EOF
 Options:
 [1] push this repo
 [2] install repo
 select : 
EOF
)"

read -p "$msg" selected_option
case "$selected_option" in
	1)
		push
		;;
	2)
		setup_termux
		install_packages
		set_fish_as_default

		termux-reload-settings
		echo "Setup dan instalasi selesai!"
		;;
	*)
		echo "nomatch! program exit"
		;;
esac

exit
