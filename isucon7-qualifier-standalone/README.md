# vagrant-isucon/isucon7-qualifier-standalone

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
./isubata &
```

## bench
```
sudo -i -u isucon
cd /home/isucon/isubata/bench
./bin/bench -remotes=127.0.0.1 -output result.json
```

