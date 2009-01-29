#!/bin/bash

emacs -q --no-site-file -batch -eval "(add-to-list 'load-path \".\")" -f batch-byte-compile *.el
