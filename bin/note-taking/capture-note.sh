#!/bin/bash

file_name="$(date +%Y-%m-%d_%T).md"
cp "/Users/jkunst/Library/Mobile Documents/iCloud~md~obsidian/Documents/Kifla/templates/todo.md" "/Users/jkunst/Library/Mobile Documents/iCloud~md~obsidian/Documents/Kifla/inbox/${file_name}"
nvim "/Users/jkunst/Library/Mobile Documents/iCloud~md~obsidian/Documents/Kifla/inbox/${file_name}"
