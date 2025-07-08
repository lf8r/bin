#!/bin/bash
set -e

sudo apt install -y git-lfs
git lfs install

REPO=git@github.com:HPE-EMU
if [ -z "$REPO" ]; then
    echo "Error: REPO environment variable is not set (e.g. REPO=sdasguppta@m4:/Volumes/FAST1/data/repo)"
    exit 1
fi

# Assume the emu identity. Note: Remember to cleanup the garbage (killall --exact ssh-agent).
eval `ssh-agent -s` && ssh-add ~/.ssh/id_rsa_emu
BASEDIR=`pwd`

DIR="golden"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="golden-vector-db"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="dream-docs"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="dream-docs-vector-db"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="morpheus"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="morpheus-vector-db"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="slack-C04TLCJKVGF"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="slack-C04TLCJKVGF-vector-db"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="slack-C082SGG8T6G"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="slack-C082SGG8T6G-vector-db"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="vme"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

DIR="vme-vector-db"
cd "$BASEDIR"
REP=$REPO/$DIR
if [ -d "$DIR" ]; then
    echo "Directory $DIR already exists. cd to it."
    cd "$DIR"
else
    echo "Directory $DIR doesn't exist. Clone $REP to it."
    git clone "$REP"
    cd "$DIR"
fi
git checkout main
git pull origin main

# rm -rf golden && git clone ${REPO}/golden
# rm -rf golden-vector-db && git clone ${REPO}/golden-vector-db
# rm -rf dream-docs && git clone ${REPO}/dream-docs
# rm -rf dream-docs-vector-db && git clone ${REPO}/dream-docs-vector-db
# rm -rf morpheus && git clone ${REPO}/morpheus
# rm -rf morpheus-vector-db && git clone ${REPO}/morpheus-vector-db
# rm -rf slack-C04TLCJKVGF && git clone ${REPO}/slack-C04TLCJKVGF
# rm -rf slack-C04TLCJKVGF-vector-db && git clone ${REPO}/slack-C04TLCJKVGF-vector-db
# rm -rf slack-C082SGG8T6G && git clone ${REPO}/slack-C082SGG8T6G
# rm -rf slack-C082SGG8T6G-vector-db && git clone ${REPO}/slack-C082SGG8T6G-vector-db

killall --exact ssh-agent