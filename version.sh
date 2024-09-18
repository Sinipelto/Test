#!/bin/bash

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
((minor >= 99)) && ((rev >= 99)) && { ((major+=1)); ((minor=0)); ((rev=-1)); }
((rev >= 99)) && { ((minor+=1)); ((rev=0)); true; } || ((rev+=1))

# Output new version
echo "${major}.${minor}.${rev}"
