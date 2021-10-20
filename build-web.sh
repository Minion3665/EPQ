#!/bin/sh

emacs -Q --script build-web.el 
echo "epq.crawling.us" > ./Web-out/CNAME
