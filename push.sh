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

# Handle git push differently per ecosystem
# To consolidate logic for all ecosystems
# Workaround for incapability of pushing to repo within GitLab
# using built-in features, a manual git push using a custom token is still needed

# Arguments to add to all push commands
DEF_ARGS="-o ci.skip"

if [[ "${1}" == *gitlab* ]]; then
	git push "$DEF_ARGS" https://gitlab-ci-token:"$CI_ACCESS_TOKEN"@"$CI_SERVER_HOST"/"$CI_PROJECT_PATH".git HEAD:"${2}"
elif [[ "${1}" == *github* ]]; then
	git push "$DEF_ARGS" origin HEAD:"${2}"
else
	echo "ERROR: UNRECOGNIZED CI/CD ECOSYSTEM. CANNOT PROCEED."
	exit 1
fi
