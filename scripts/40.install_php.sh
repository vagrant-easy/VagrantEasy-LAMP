apt-get install -y php5 libapache2-mod-php5 php5-mcrypt php5-mysql

sed -i 's/index.html/index.php index.html/g' /etc/apache2/mods-enabled/dir.conf