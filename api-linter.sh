#!/bin/bash
set -e

# .protoファイルを見つけてapi-linterに渡す
proto_files=$(find . -type f -name "*.proto")

# ファイルが見つかった場合のみapi-linterを実行
if [ -n "$proto_files" ]; then
    api-linter $proto_files --config .apilinter.yml --set-exit-status
else
    echo "No .proto files found."
fi