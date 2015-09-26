HOME=/home/isucon

git:
	rm -rf $(HOME)/.ssh
	rm -rf $(HOME)/.gitconfig
	ln -s $(HOME)/isucon5/home/.ssh $(HOME)/.ssh
	ln -s $(HOME)/isucon5/home/.gitconfig $(HOME)/.gitconfig
	chmod 0600 $(HOME)/.ssh/id_rsa

app:
	sudo rm -rf $(HOME)/webapp/python
	rm -rf $(HOME)/webapp/sql
	rm -rf $(HOME)/webapp/static
	rm -rf $(HOME)/env.sh
	ln -s $(HOME)/isucon5/home/webapp/python $(HOME)/webapp/python
	ln -s $(HOME)/isucon5/home/webapp/sql $(HOME)/webapp/sql
	ln -s $(HOME)/isucon5/home/webapp/static $(HOME)/webapp/static
	ln -s $(HOME)/isucon5/home/env.sh $(HOME)/env.sh

python:
	sudo rm -rf /etc/systemd/system/isuxi.python.service
	sudo cp $(HOME)/isucon5/etc/systemd/system/isuxi.python.service /etc/systemd/system/isuxi.python.service
	sudo systemctl daemon-reload
	sudo systemctl stop isuxi.ruby
	sudo systemctl disable isuxi.ruby
	sudo systemctl start isuxi.python
	sudo systemctl enable isuxi.python

nginx:
	sudo rm -rf /etc/nginx
	sudo ln -s $(HOME)/isucon5/etc/nginx /etc/nginx
	sudo /etc/init.d/nginx restart

init: git app python nginx
	@echo "application initial deployed"
