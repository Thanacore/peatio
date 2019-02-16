#!/bin/bash
# Crypto Currency Exchange
# Author: Adarshdubeytech
# Telegram @adarshdubey
# Email adarshdubeytech@gmail.com

################################################################
#  Goals of the script:
#  To install the secured crypto currency exchange
#
#  Script by Adarsh Dubey.
################################################################

sudo apt-get -y install boxes;
sudo apt-get -y update
echo 'WELCOME TO PEATIO CRYPTOCURRENCY EXCHANGE' | boxes -d diamonds -a hcvc
echo -e "\n\n"
echo -e "\033[34;7mWelcome to Peatio Crypto Exchange \e[0m "
echo -e "\n\n"

rm -rf peatio
rm -rf ~/.rbenv

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git curl zlib1g-dev build-essential \
           libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
           libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev

echo -e "\n\n"
echo -e "\033[34;7mInstalling RVM and Ruby 2.5.3\e[0m"
cd
gpg --keyserver hkp://keys.gnupg.net \
             --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
                         7D2BAF1CF37B13E2069D6956105BD0E739499BDB

echo -e "\n\n"
exec $SHELL &
curl -sSL https://get.rvm.io | bash -s stable --ruby=2.5.3 --gems=rails

echo -e "\n\n"
exec $SHELL &
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
source /home/deploy/.rvm/scripts/rvm
rvm use 2.5.3


echo -e "\n\n"
echo -e "\033[34;7mInstalling MYSQL\e[0m"

sudo apt-get install mysql-server mysql-client libmysqlclient-dev

echo -e "\n\n"
echo -e "\033[34;7mInstalling REDIS\e[0m"

sudo add-apt-repository ppa:chris-lea/redis-server

echo -e "\n\n"
exec $SHELL &
sudo apt-get update
sudo apt-get install redis-server

exec $SHELL &
echo -e "\n\n"
echo -e "\033[34;7mInstalling RabbitMQ\e[0m"

echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install rabbitmq-server

sudo rabbitmq-plugins enable rabbitmq_management
sudo service rabbitmq-server restart
wget http://localhost:15672/cli/rabbitmqadmin
chmod +x rabbitmqadmin
sudo mv rabbitmqadmin /usr/local/sbin

echo -e "\n\n"
echo -e "\033[34;7mInstalling Nginx & Passenger\e[0m"
sudo apt-get install -y dirmngr gnupg
exec $SHELL &

echo -e "\n\n"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7

echo -e "\n\n"
echo -e "\033[34;7mAdd HTTPS support to APT\e[0m"
sudo apt-get install -y apt-transport-https ca-certificates

sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

echo -e "\n\n"
echo -e "\033[34;7mInstalling nginx and passenger\e[0m"
sudo apt-get install -y nginx-extras passenger

sudo rm /etc/nginx/passenger.conf
sudo touch /etc/nginx/passenger.conf

sudo cat <<EOF > /etc/nginx/passenger.conf
passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
passenger_ruby /home/.rvm/rubies/ruby-2.5.3/bin/ruby;
EOF

sudo sed -i 's+# include /etc/nginx/passenger.conf;+include /etc/nginx/passenger.conf;+g' /etc/nginx/nginx.conf

echo -e "\n\n"
echo -e "\033[34;7mInstalling JavaScript Runtime\e[0m"

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install nodejs

 sudo apt-get install gcc g++ make
          
        curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
		
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
		
        sudo apt-get update && sudo apt-get install yarn    

exec $SHELL &
echo -e "\n\n"
echo -e "\033[34;7mInstalling ImageMagick\e[0m"

sudo apt-get install imagemagick

exec $SHELL &
echo -e "\n\n"
echo -e "\033[34;7mSetup production environment variable\e[0m"

echo Enter Mysql Root Password:
read mysqlpassword

echo "export RAILS_ENV=production" >> ~/.bashrc
echo "export DATABASE_HOST=localhost" >> ~/.bashrc
echo "export DATABASE_USER=root" >> ~/.bashrc
echo "export DATABASE_PASS=$mysqlpassword" >> ~/.bashrc
source ~/.bashrc
echo -e "\n\n"
echo -e "\033[34;7mNow you are Ready to Clone Peatio and start it\e[0m"
echo 'THANKS FOR INSTALLING PEATIO ENJOY !! CONTACT US ON TELEGRAM : Adarshdubey' | boxes -d peek -a c -s 40x11
