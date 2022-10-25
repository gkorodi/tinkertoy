#!/usr/bin/env sh

up() {
  SCRIPT_NAME=$(basename $0 .sh)
  SCRIPT_DIR=$(dirname $0)

  cd $SCRIPT_DIR
  uvicorn app:app --reload --reload --host 0.0.0.0 --port 82
}

$*