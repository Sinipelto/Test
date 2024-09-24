#!/bin/bash

# Handle git push differently per ecosystem
# To consolidate logic for all ecosystems
# Workaround for incapability of pushing to repo within GitLab
# using built-in features, a manual git push using a custom token is still needed

if [[ "${1}" == *gitlab* ]]; then
	git push https://gitlab-ci-token:"$CI_ACCESS_TOKEN"@"$CI_SERVER_HOST"/"$CI_PROJECT_PATH".git HEAD:"${2}"
elif [[ "${1}" == *github* ]]; then
	git push origin HEAD:"${2}"
else
	echo "ERROR: UNRECOGNIZED CI/CD ECOSYSTEM. CANNOT PROCEED."
	exit 1
fi
