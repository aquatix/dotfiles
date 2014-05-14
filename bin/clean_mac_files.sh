#!/bin/bash
# Remove DS_Store stuff and ._* metafiles
find . -name '*.DS_Store' -type f -delete
find . -name '._*' -type f -delete
