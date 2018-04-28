#!/bin/bash
# Script for configuring vim for initial install
name="ChaseAfterStart"
pydir="/usr/lib/python2.7/config-x86_64-linux-gnu"
py3dir="/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu"
read -e -i "$name" -p "Please enter the name of the person compiling Vim: "
echo
read -e -i "$pydir" -p "Please enter the path to your python config directory: " pyinput
echo
read -e -i "$py3dir" -p "Please enter the path to your python3 config directory: " py3input

./configure --with-features=huge \
--with-compiledby=ChaseAfterStart \
--enable-pythoninterp=yes \
--enable-python3interp=yes \
--enable-terminal \
--enable-rubyinterp \
--with-python3-config-dir=$py3dir\
--with-python-config-dir=$pydir\
--enable-cscope

echo "Thank you, $name, Vim has been configured correctly."
echo "Please run make and then sudo make install to install Vim."
