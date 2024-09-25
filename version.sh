#!/bin/bash

# Copyright 2024 Tampere University
# 
# Main authors: Toni Blåfield
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in 
# the Software without restriction, including without limitation the rights to 
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so, 
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# ---------------------------------------------------------------------------------

# Screws up the maths
#set -e

# Required parameter
ver=${1:?}

# Check valid format
! [[ "$ver" =~ ^[1-9]?[0-9]\.[1-9]?[0-9]\.[1-9]?[0-9]$ ]] && { echo "ERROR: Invalid version input format."; exit 1; }

# Separate version components
major=$(echo "$ver" | awk -F'.' '{print $1}')
minor=$(echo "$ver" | awk -F'.' '{print $2}')
rev=$(echo "$ver" | awk -F'.' '{print $3}')

# All required not empty
major=${major:?}
minor=${minor:?}
rev=${rev:?}

# Bump up version components correspondingly
((minor >= 9)) && ((rev >= 9)) && { ((major+=1)); ((minor=0)); ((rev=-1)); }
((rev >= 9)) && { ((minor+=1)); ((rev=0)); true; } || ((rev+=1))

# Output new version
echo "${major}.${minor}.${rev}"
