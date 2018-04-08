#!/bin/sh
# go build
export ISUBATA_DB_HOST=127.0.0.1
export ISUBATA_DB_USER=isucon
export ISUBATA_DB_PASSWORD=isucon
export PATH=$HOME/local/go/bin:$HOME/go/bin:$PATH
sudo pkill -f 'isubata'
cd /home/isucon/shared/isubata/webapp/go
make
./isubata &

# bench
cd /home/isucon/isubata/bench
OUTPUT_FILE="result.json"
if [ ! "$1" = "" ]; then
        OUTPUT_FILE=$1
fi
NGINX_LOG_DIR="/var/log/nginx"
sudo chmod 777 ${NGINX_LOG_DIR}
sudo echo "" > ${NGINX_LOG_DIR}/access.log
sudo echo "" > ${NGINX_LOG_DIR}/error.log
sudo systemctl restart nginx
sleep 15
sudo ./bin/bench -remotes=127.0.0.1 -output ${OUTPUT_FILE}
