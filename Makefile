HOME=/home/isucon

git:
	rm -rf $(HOME)/.ssh
	rm -rf $(HOME)/.gitconfig
	ln -s $(HOME)/isucon5/home/.ssh $(HOME)/.ssh
	ln -s $(HOME)/isucon5/home/.gitconfig $(HOME)/.gitconfig
	chmod 0600 $(HOME)/.ssh/id_rsa
