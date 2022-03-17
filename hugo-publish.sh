#!/usr/bin/env bash
set -eux

if [[ $(git status --porcelain ./content/ | wc -l) -gt 0 ]]; then
  set +x
  echo 'Git repo has uncommitted content. Refusing to publish.'
  exit 1
fi

if [[ $(git status --porcelain ./config.toml | wc -l) -gt 0 ]]; then
  set +x
  echo 'Git repo has uncommitted config file. Refusing to publish.'
  exit 1
fi

hugo --minify --cleanDestinationDir --environment "production"
git rev-parse --verify HEAD > ./public/version.txt

ssh herbert.io -t "rm -rf ~/blog-staging; exit"
oldVersion=$(ssh herbert.io -t "cat /srv/www/dan.herbert.io/www-root/blog/version.txt; exit")
ssh herbert.io -t "cp -r /srv/www/dan.herbert.io/www-root/blog ~/blog-rev-${oldVersion}";
scp -r ./public herbert.io:~/blog-staging
ssh herbert.io -t "cp -r /srv/www/dan.herbert.io/www-root/blog ~/blog-old; rm -rf /srv/www/dan.herbert.io/www-root/blog; cp -r ~/blog-staging /srv/www/dan.herbert.io/www-root/blog; rm -rf ~/blog-staging; exit"
