#! /usr/bin/env bash

VERSION=$1

echo "copy latest app"
cp ../app.py .
cp ../requirements.txt .
cp ../data.csv .

echo "build container"
docker build -t devops-voyager:$VERSION .