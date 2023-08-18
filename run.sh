#!/bin/sh
set -e

echo "Fetching required libraries"

python -m pip install --upgrade pip
pip install pymupdf

echo "Getting split.py"

wget -q -O split.py https://raw.githubusercontent.com/northy/pdf-to-markdown-workflow/master/split.py

echo "Running split.py"

python split.py "${INPUT_PDF_INPUT}" "${INPUT_OUTPUT_FOLDER}" "${INPUT_SOURCE_MD}" "${INPUT_OUTPUT_MD}" "${INPUT_ROOT_FOLDER}" "${INPUT_LINE_END}"

rm split.py

echo "Commiting and pushing"

git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
git config --global user.name "github-actions[bot]"

git add ${INPUT_ROOT_FOLDER}${INPUT_OUTPUT_FOLDER} ${INPUT_OUTPUT_MD} > /dev/null
git diff-index --quiet HEAD || git commit -m "Compile MD" --quiet

remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git push "${remote_repo}" --quiet

echo "Done!"
