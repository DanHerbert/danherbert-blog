#!/usr/bin/env bash
set -eux

stylus --compress --out ~/Code/dan.herbert.io/themes/herbertio/static/css/ ~/Code/dan.herbert.io/themes/herbertio/styl/main.styl
hugo --minify
ssh herbert.io -t "rm -rf ~/blog-staging; exit"
scp -r ./public herbert.io:~/blog-staging
ssh herbert.io -t "cp -r /srv/www/dan.herbert.io/www-root/blog ~/blog-old; rm -rf /srv/www/dan.herbert.io/www-root/blog; cp -r ~/blog-staging /srv/www/dan.herbert.io/www-root/blog; rm -rf ~/blog-staging; exit"
