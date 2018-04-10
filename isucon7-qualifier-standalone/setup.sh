#!/bin/sh
echo "set up start!"
DIR="/home/isucon/isubata"
echo "code link"
if [ -d ${DIR} ]; then
  sudo rm -rf ${DIR} 2> /dev/null
fi
sudo unlink ${DIR} 2> /dev/null
sudo ln -s /home/vagrant/shared/isubata ${DIR}
sudo chown -Rh isucon:isucon /home/isucon

echo "nginx set up"
NGINX_DIR_AV="/etc/nginx/sites-available"
NGINX_DIR_EN="/etc/nginx/sites-enabled"
NGINX_DIR="/etc/nginx"
if [ -f ${NGINX_DIR_AV}/nginx.conf -o -f ${NGINX_DIR_EN}/nginx.conf -o -L ${NGINX_DIR}/nginx.conf ]; then
  sudo rm -rf ${NGINX_DIR_AV}/nginx.conf 2> /dev/null
  sudo rm -rf ${NGINX_DIR_EN}/nginx.conf 2> /dev/null
  sudo rm -rf ${NGINX_DIR}/nginx.conf 2> /dev/null
fi
if [ -L ${NGINX_DIR_AV}/nginx.conf -o -L ${NGINX_DIR_EN}/nginx.conf -o -L ${NGINX_DIR}/nginx.conf ]; then
  sudo unlink ${NGINX_DIR_AV}/nginx.conf 2> /dev/null
  sudo unlink ${NGINX_DIR_EN}/nginx.conf 2> /dev/null
  sudo unlink ${NGINX_DIR}/nginx.conf 2> /dev/null
fi
sudo ln -s ${DIR}/files/app/nginx-sites.conf /etc/nginx/sites-available/nginx.conf
sudo ln -s ${NGINX_DIR_AV}/nginx.conf /etc/nginx/sites-enabled/nginx.conf
sudo ln -s ${DIR}/files/app/nginx.conf /etc/nginx
sudo systemctl restart nginx
echo "set up success!"

