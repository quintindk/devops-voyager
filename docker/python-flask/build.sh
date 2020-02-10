#!/usr/bin/env bash

VERSION=$1

echo "copy latest app"
cp ../../src/python-flask/app.py .
cp ../../src/python-flask/requirements.txt .
cp ../../src/python-flask/data.csv .

echo "build container"
docker build -t devops-voyager:$VERSION .
docker tag devops-voyager:$VERSION devops-voyager:latest

echo "remove the application files"
rm app.py
rm requirements.txt
rm data.csv