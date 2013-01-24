#!/bin/sh

set -e

PRGDIR=`dirname $0`

TMPDIR="$PRGDIR/temp"
REMOTE_DIR="~/.liren"

REPOSITORY_SSH=$1
REPOSITORY_DIR=$2
REMOTE_SSH=$3
REMOTE_DIR=$4

echo "preparing local temp directory..."
mkdir -p "$TMPDIR"
rm -rf "$TMPDIR" 

echo "fetching certificates from remote repository..."
scp -q "$REPOSITORY_SSH:$REPOSITORY_DIR" "$TMPDIR" 

echo "deploying certificates to remote environment..."
ssh -q "$REMOTE_SSH" "mkdir -p $REMOTE_DIR"
scp -q "$TMPDIR/*" "$REMOTE_SSH:$REMOTE_DIR"

