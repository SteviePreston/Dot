#!/bin/bash

for func_file in ~/.config/bin/*.sh; do
    if [[ "$(basename "$func_file")" != "setup.sh" ]] && [[ -r "$func_file" ]]; then
        source "$func_file"
    fi
done
