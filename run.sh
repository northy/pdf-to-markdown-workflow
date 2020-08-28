#!/bin/sh
set -e

wget -O split.py https://raw.githubusercontent.com/northy/pdf-to-markdown-workflow/master/split.py

python split.py ${INPUT_PDF_INPUT} ${INPUT_OUTPUT_FOLDER} ${INPUT_SOURCE_MD} ${INPUT_OUTPUT_MD}

rm split.py

git config --local user.email "action@github.com"
git config --local user.name "GitHub Action"
git add ${INPUT_OUTPUT_FOLDER} ${INPUT_OUTPUT_MD}
git commit -m "Compile MD"

remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git push "${remote_repo}";