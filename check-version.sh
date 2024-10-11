#!/bin/bash

#SEARCH_PAGES='110'
SEARCH_PAGES='30'

if [ -f ./version_list ]; then
    rm version_list
    rm version
fi

# 76

for i in $(seq 12 ${SEARCH_PAGES}); do
    curl -s "https://packages.gitlab.com/app/gitlab/gitlab-ce/search?dist=&filter=debs&page=${i}&q=" | grep "_arm64.deb" | grep -v '\-rc' | sed 's/.*>\(.*\)<.*/\1/' | sort -u | sed 's/gitlab-ce_\(.*\)_arm64.deb/\1/' >> version_list;
done

grep -v '^\(1[0-3]\)\.' version_list | sort -Vu -o version

echo "Latest versions:"
cat version
wc -l version
