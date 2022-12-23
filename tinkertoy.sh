#!/usr/bin/env sh

SCRIPT_NAME=$(basename $0 .sh)
SCRIPT_DIR=$(dirname $0)

run() {
  cd $SCRIPT_DIR
  uvicorn app:app --reload --port 9001 #--host 0.0.0.0 --port 82
}

build() {
  cd $SCRIPT_DIR
  docker build . --tag tinkertoy:latest --tag tinkertoy:$(date +%s)
}

up() {
  cd $SCRIPT_DIR
  docker run -it --rm --name tinkertoy-app --publish "82:80" tinkertoy:latest
}

dockerpush() {
  docker login --username gaborkorodi #password is in ~/.docker/.hub_token
  docker tag tinkertoy:latest gaborkorodi/tinkertoy:latest
  docker push gaborkorodi/tinkertoy:latest
}



$*