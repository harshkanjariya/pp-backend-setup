#!/bin/bash
ppb=$(pwd)/penpencil-backend
if [ ! -d "$ppb" ]; then
	echo "penpencil-backend folder not found"
	exit 1
fi
git clone git@github.com:harshkanjariya/pp-backend-setup.git
cd pp-backend-setup
docker build -t pp-builder -f pp-builder.docker .
cd ..
docker run --name pp-builder -d -v $ppb:/app pp-builder

cd $ppb
[ -e node_modules ] && rm -r node_modules
[ -e package-lock.json ] && rm package-lock.json
docker exec -it pp-builder bash -c "npm config set user 0"
docker exec -it pp-builder bash -c "npm --prefix ../app i"
docker stop pp-builder
docker rm pp-builder
