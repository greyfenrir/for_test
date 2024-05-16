#!/bin/bash

# exit immediately if command exits with a non-zero status
set -e

usage() {
  echo -e "Update tag & version"
  echo -e "\t --version <version> (by default current_tag + 0.0.1)"
}

while [ "$1" != "" ]
do
  case $1 in
    "-h" | "--help" ) usage exit ;;
    "--version" ) shift; new_version=$1 ;;
  esac
  shift
done

old_version=$(git describe --tags --abbrev=0)
# shellcheck disable=SC2206
old_version_parts=(${old_version//./ })
new_version=${old_version_parts[0]}.${old_version_parts[1]}.$((old_version_parts[2] + 1))
echo "old_version: $old_version"
echo "new_version: $new_version"


# Add new git tag & push it
git tag "$new_version"
git push -u origin master --tags

echo "Version $new_version has been released"
