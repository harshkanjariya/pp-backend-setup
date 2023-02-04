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

rm -r $ppb/node_modules
rm $ppb/package-lock.json
cd $ppb
docker exec -it pp-builder bash install.sh
docker stop pp-builder
docker rm pp-builder
