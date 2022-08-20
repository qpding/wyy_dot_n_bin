#!/bin/bash

script_dir="$(dirname $(realpath $0))/"

cp ${script_dir}.profile $HOME/.profile
cp ${script_dir}.aliases $HOME/.aliases
