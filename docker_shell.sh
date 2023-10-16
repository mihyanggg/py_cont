#!/usr/bin/env bash

image=$1

if [ "$image" == "" ]
then
    image=docker_test
fi

# 포트 바인딩
#docker run -p 8080:5000 -v ~/.aws:/root/.aws -v ~/.ssh:/root/.ssh -v $(pwd)/task:/var/task --rm -it $image /bin/bash
docker run --name mimi --hostname mimi -v $(pwd):/home/mimi --rm -it $image /bin/bash
