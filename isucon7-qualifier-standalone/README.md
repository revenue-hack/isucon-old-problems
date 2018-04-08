# vagrant-isucon/isucon7-qualifier-standalone
## vagrant box
https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box
```
vagrant box add isucon-7-s https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box
```

## Overview

isucon7予選とほぼ同じ環境を構築するためのVagrantfileです。

## Usage

*when go*

```
# db
sudo -i -u isucon
export DIR="/home/isucon/isubata"
export PATH=$HOME/local/go/bin:$HOME/go/bin:$PATH
cd ${DIR}/bench
./bin/gen-initial-dataset
${DIR}/db/init.sh
zcat ${DIR}/bench/isucon7q-initial-dataset.sql.gz | sudo mysql isubata
export ISUBATA_DB_HOST=127.0.0.1
export ISUBATA_DB_USER=isucon
export ISUBATA_DB_PASSWORD=isucon
go get github.com/constabulary/gb/...
cd ${DIR}/bench
gb vendor restore
make
cd ${DIR}/webapp/go
make
./isubata &
```

## bench
sudo -i -u isucon
```
sudo sh bench.sh ${OUTPUT_JSON_NAME}
```

## kataribe
```
cat /var/log/nginx/access.log |./kataribe -f kataribe.toml
```

## nginx
```
nginx -t -c /etc/nginx/sites-enabled/nginx.conf
```

## netdata
```
sudo apt-get install zlib1g-dev gcc make git autoconf autogen automake pkg-config
git clone https://github.com/firehol/netdata.git --depth=1
cd netdata
./netdata-installer.sh --dont-wait --install /tmp
```
http://168.192.33.10:19999

