# PDF To Markdown Workflow

## How to use
* Add the following lines to your source markdown file. The workflow will replace these comments with the actual blog post list:

```md
<!-- PDF-TO-MARKDOWN:START -->
<!-- PDF-TO-MARKDOWN:END -->
```

Create the following file: `.github/workflows/pdf-to-markdown.yml`
```yml
name: PDF To Markdown

on:
  push:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8]
    steps:
    - uses: actions/checkout@v2
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v2
      with:
        python-version: ${{ matrix.python-version }}
    - name: Compile markdown
      uses: northy/pdf-to-markdown-workflow@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Options

| Option        | Default Value | Description                                              | Required |
|---------------|---------------|----------------------------------------------------------|----------|
| pdf_input     | source.pdf    | Input PDF file path                                      |    Yes   |
| output_folder | output_pngs   | Output PNGs folder (don't add trailing "/")              |    Yes   |
| source_md     | source.md     | Source Markdown File                                     |    Yes   |
| output_md     | README.md     | Output Markdown File (CAN be the same file as the input) |    Yes   |