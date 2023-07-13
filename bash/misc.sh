#!/usr/bin/env bash

export VENV_DIR=".venv"

# adapted from https://stackoverflow.com/questions/45216663/how-to-automatically-activate-virtualenvs-when-cding-into-a-directory
function cd() {
  builtin cd "$@" || return
  
  # if env folder is found then activate the virtual env
  if [[ -d "./$VENV_DIR" ]]; then
    # if a virtual env was already active, deactivate it first
    if [[ -n "$VIRTUAL_ENV" ]]; then
      echo "Deactivate old virtual env before activating new one"
      deactivate
    fi
    echo "Activate $VENV_DIR"
    # poetry shell
    source ./$VENV_DIR/bin/activate
  else
    # check the current folder is a sub-folder of the VIRTUAL_ENV
    # if not, deactivate the virtual env
    parentdir="$(dirname "${VIRTUAL_ENV}")"
    if [[ "$PWD"/ != "$parentdir"/* ]]; then
      if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "Deactivate old virtual env"
        deactivate
      fi
    fi
  fi
}
