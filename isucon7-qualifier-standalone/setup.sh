#!/bin/sh
echo "set up start!"
echo "code link"
DIR="/home/isucon/isubata"
if [ -d ${DIR} ]; then
  sudo rm -rf /home/isucon/isubata 2> /dev/null
fi
sudo unlink ${DIR} 2> /dev/null
sudo ln -s /home/isucon/shared/isubata /home/isucon

echo "nginx set up"
NGINX_DIR_AV="/etc/nginx/sites-available/nginx.conf"
NGINX_DIR_EN="/etc/nginx/sites-enabled/nginx.conf"
if [ -f ${NGINX_DIR_AV} -o -f ${NGINX_DIR_EN} ]; then
  sudo rm -rf ${NGINX_DIR_AV} 2> /dev/null
  sudo rm -rf ${NGINX_DIR_EN} 2> /dev/null
  sudo unlink ${NGINX_DIR_AV} 2> /dev/null
  sudo unlink ${NGINX_DIR_EN} 2> /dev/null
fi
sudo ln -s ${DIR}/files/app/nginx.conf /etc/nginx/sites-available
sudo ln -s ${NGINX_DIR_AV} /etc/nginx/sites-enabled
sudo systemctl restart nginx
echo "set up success!"

