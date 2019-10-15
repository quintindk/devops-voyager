#! /usr/bin/env bash

echo "copy latest app"
cp ../app.py .
cp ../requirements.txt .

echo "build container"
docker build -t devops-voyager:latest .