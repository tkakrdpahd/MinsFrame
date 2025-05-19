#!/bin/bash
# root context
tree . -I "frontend|node_modules|pnpm-lock.yaml" --prune
cloc . --exclude-dir=dist,.next,node_modules --not-match-f='(^|/)pnpm-lock\.yaml$'
# frontend context
cd frontend
tree . -I ".next|node_modules|pnpm-lock.yaml" --prune
cloc . --exclude-dir=dist,.next,node_modules --not-match-f='(^|/)pnpm-lock\.yaml$'