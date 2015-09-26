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
	sudo mkdir -p /var/log/gunicorn
	sudo mkdir /var/run/gunicorn
	sudo chmod 777 /var/run/gunicorn
	sudo systemctl daemon-reload
	sudo systemctl stop isuxi.ruby
	sudo systemctl disable isuxi.ruby
	sudo systemctl start isuxi.python
	sudo systemctl enable isuxi.python

nginx:
	sudo systemctl stop nginx
	sudo rm -rf /etc/nginx
	sudo ln -s $(HOME)/isucon5/etc/nginx /etc/nginx
	sudo systemctl start nginx

mysql:
	sudo systemctl stop mysql
	sudo rm -rf /etc/my.cnf
	sudo rm -rf /etc/mysql/conf.d
	sudo rm -rf /etc/mysql/mysql.conf.d
	sudo ln -s $(HOME)/isucon5/etc/my.cnf /etc/my.cnf
	sudo cp -r $(HOME)/isucon5/etc/mysql/conf.d/ /etc/mysql/conf.d/
	sudo cp -r $(HOME)/isucon5/etc/mysql/mysql.conf.d/ /etc/mysql/mysql.conf.d/
	sudo systemctl start mysql
	mysql -u root isucon5q -e "ALTER TABLE relations ADD INDEX idx1_one (`one`)"
	mysql -u root isucon5q -e "ALTER TABLE relations ADD INDEX idx2_another (`another`)"

init: git app mysql python nginx
	@echo "application initial deployed"
