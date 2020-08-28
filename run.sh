#!/bin/sh
set -e

echo "Fetching required libraries"

python -m pip install --upgrade pip
pip install pymupdf

echo "Getting split.py"

wget -q -O split.py https://raw.githubusercontent.com/northy/pdf-to-markdown-workflow/master/split.py

echo "Running split.py"

python split.py ${INPUT_PDF_INPUT} ${INPUT_OUTPUT_FOLDER} ${INPUT_SOURCE_MD} ${INPUT_OUTPUT_MD}

rm split.py

echo "Commiting and pushing"

git add ${INPUT_OUTPUT_FOLDER} ${INPUT_OUTPUT_MD} > /dev/null
git commit -m "Compile MD" --quiet

remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git push "${remote_repo}" --quiet

echo "Done!"