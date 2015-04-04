#!/bin/bash

function error_exit
{
	echo "$1" 1>&2
	exit 1
}

# No Defaults for you!

# Set needed vars using passed parameters:
while [[ $# > 1 ]]
do
  key="$1"

  case $key in
      --site_path)
      SITE_PATH="$2"
      shift
      ;;
      --enabled)
      ENABLED="$2"
      shift
      ;;
      --log_level)
      LOG_LEVEL="$2"
      shift
      ;;
      --host)
      HOST="$2"
      shift
      ;;
      --last)
      LAST="$2"
      shift
      ;;
      *)
        # Die if parameter not listed above.
        error_exit "Unknown option '$key' with value '$2'! Aborting..."
      ;;
  esac
  shift
done

if [ -z ${SITE_PATH+x} ]; then error_exit "--site_path is not set!"; fi
if [ -z ${ENABLED+x} ]; then error_exit "--enabled is not set!"; fi
if [ -z ${LOG_LEVEL+x} ]; then error_exit "--log_level is not set!"; fi
if [ -z ${HOST+x} ]; then error_exit "--host is not set!"; fi
if [ -z ${LAST+x} ]; then error_exit "--last is not set!"; fi

cat > /etc/apache2/sites-available/$HOST.conf << EOL 
<VirtualHost *:80>
  ServerName ${HOST}
  # ServerAlias www.example.com

  DocumentRoot ${SITE_PATH}/current

  LogLevel ${LOG_LEVEL}

  ErrorLog \${APACHE_LOG_DIR}/error.log
  CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

ln -s /etc/apache2/sites-available/$HOST.conf /etc/apache2/sites-enabled/$HOST.conf

if $LAST
then
  rm -f /etc/apache2/sites-enabled/000-default.conf
  service apache2 restart
fi