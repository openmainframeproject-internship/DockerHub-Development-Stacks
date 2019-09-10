#!/bin/bash

mkdir /knrt10
export SOURCE_ROOT=/knrt10/
cd $SOURCE_ROOT
wget https://storage.googleapis.com/golang/go1.10.3.linux-s390x.tar.gz
chmod ugo+r go1.10.3.linux-s390x.tar.gz
tar -C /usr/local -xzf go1.10.3.linux-s390x.tar.gz
export PATH=$PATH:/usr/local/go/bin
ln /usr/bin/gcc /usr/bin/s390x-linux-gnu-gcc


cd $SOURCE_ROOT
mkdir -p $SOURCE_ROOT/src/github.com/coreos
cd $SOURCE_ROOT/src/github.com/coreos
git clone http://github.com/coreos/etcd
cd etcd
git checkout v3.3.13

export GOPATH=$SOURCE_ROOT
mkdir -p $SOURCE_ROOT/etcd_temp
export ETCD_DATA_DIR=$SOURCE_ROOT/etcd_temp


cd $SOURCE_ROOT/src/github.com/coreos/etcd
./build
cp $GOPATH/src/github.com/coreos/etcd/bin/etcd /usr/bin/

cd $SOURCE_ROOT/src/github.com/coreos/etcd
PASSES='bom dep build unit' ./test

export ETCD_UNSUPPORTED_ARCH=s390x


