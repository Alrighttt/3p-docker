#!/bin/bash
#whoami
mkdir ~/.einsteinium/
touch ~/.einsteinium/debug.log
chmod 600 ~/.einsteinium/einsteinium.conf

/einsteinium/src/einsteiniumd "$@" 

tail -f ~/.einsteinium/debug.log