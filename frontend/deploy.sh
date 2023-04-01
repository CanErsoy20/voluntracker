#!/bin/bash

projectId="voluntracker"
projectName="voluntracker_web"
version="1.0.0"

# only needed the first time
gcloud config set project $projectId
gcloud auth login

# change to primary app directory & build flutter web & go back to main level

flutter build web && cd ..

# if you're having issues with rendering, which we were, you can try the following instead
cd flutter build web --web-renderer canvaskit --release && cd ..

# clear web directory from server
rm simple_server/web -r

# copy the built web folder to the server directory
cp build/web simple_server/web -r

# change to the server directory
cd simple_server &&

# Create docker container
docker build -t $projectName .

#
# The rest is for pushing to GCP
#

#push it to GCP Cloud Repository
docker build -t gcr.io/$projectId/$projectName:v$version .
docker push gcr.io/$projectId/$projectName:v$version

# return back to root directory
cd ..

# deploy on google cloud
gcloud run deploy $projectName --image gcr.io/$projectId/$projectName:v$version