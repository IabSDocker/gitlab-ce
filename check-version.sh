#!/bin/bash

SEARCH_PAGES='110'

if [ -f ./version_list ]; then
    rm version_list
fi

for i in $(seq 105 ${SEARCH_PAGES}); do
    curl -s "https://packages.gitlab.com/app/gitlab/gitlab-ce/search?dist=&filter=debs&page=${i}&q=" | grep "_arm64.deb" | grep -v '\-rc' | sed 's/.*>\(.*\)<.*/\1/' | sort -u | sed 's/gitlab-ce_\(.*\)_arm64.deb/\1/' >> version_list;
done
grep -v '^\(13\|12\|11\|10\)\.' version_list | sort -Vu version_list -o version_list

echo "Latest versions:"
cat version_list
