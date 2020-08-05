#!/bin/bash

dir=$(
  cd "$(dirname "$0")"
  pwd
)

  echo $dir

docker run --name=jenkins \
  -p 8089:8080 \
  -p 50000:50000 \
  --network dbnet \
  -v $dir/data:/var/jenkins_home \
  -d jenkins/jenkins:lts-alpine

docker exec -it jenkins /bin/sh

