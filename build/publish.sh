#!/bin/bash

set -e

self_dir="$(dirname "$(readlink -f "${BASH_SOURCE}")")"
repository_dir="$(dirname "${self_dir}")"
out_dir_name="book"
out_dir="${repository_dir}/${out_dir_name}"

cd "${repository_dir}"

echo "Generating site"
mdbook build

echo "Updating gh-pages branch"
(
  set +x
  cd "${out_dir}" &&
  git init &&
  git add . &&
  git commit -m "Publishing to gh-pages"

  git push git@github.com:azriel91/home_alone_2.git master:gh-pages -f
)
