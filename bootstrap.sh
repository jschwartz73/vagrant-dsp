#!/usr/bin/env bash

apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root123'

apt-get -q -y install curl apache2 php5 php5-common php5-cli php5-curl php5-mcrypt php5-gd php5-mysql mysql-server mysql-client git

echo "create database dreamfactory" | mysql --user=root --password=root123
echo "grant all privileges on dreamfactory.* to 'dsp_user'@'localhost' identified by 'dsp_user'" | mysql --user=root --password=root123

wget https://raw.github.com/dreamfactorysoftware/platform-packages/master/dreamfactory-dsp_1.2.3-0_all.deb

sudo dpkg -i dreamfactory-dsp_1.2.3-0_all.deb

a2dissite 000-default 
service apache2 reload
