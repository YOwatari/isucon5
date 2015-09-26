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
	ln -s $(HOME)/isucon5/home/webapp/python $(HOME)/webapp/python
	ln -s $(HOME)/isucon5/home/webapp/sql $(HOME)/webapp/sql
	ln -s $(HOME)/isucon5/home/webapp/static $(HOME)/webapp/static
	sudo rm -rf /etc/systemd/system/isuxi.python.service
	sudo ln -s $(HOME)/isucon5/etc/systemd/system/isuxi.python.service /etc/systemd/system/isuxi.python.service
	sudo systemctl daemon-reload

init: git app
	@echo "application initial deployed"

run:
	sudo systemctl stop isuxi.ruby
	sudo systemctl start isuxi.python