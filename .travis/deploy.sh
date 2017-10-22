#!/usr/bin/env bash
[ "${TRAVIS_PULL_REQUEST}" != 'false' ] && exit
[ "${TRAVIS_BRANCH}" != 'develop' ] && exit

GIT_COMMITTER_EMAIL='travis@digitalr00ts.com'
GIT_COMMITTER_NAME='Travis CI'
GIT_REPO_PUSH="git@$(git remote -v | head -n1 | grep -o --color=never 'github\.com.* ' | sed 's/\//\:/')"
GIT_BASE='master'

mkdir -p ~/.ssh/
openssl aes-256-cbc -K $encrypted_2de154196fc3_key -iv $encrypted_2de154196fc3_iv -in .travis/id_rsa.enc -out ~/.ssh/id_rsa -d
chmod 700 ~/.ssh/
chmod 400 ~/.ssh/id_rsa

git fetch origin ${GIT_BASE}:${GIT_BASE} && \
git checkout ${GIT_BASE} && \
echo "Attempting to merge $TRAVIS_COMMIT"
git merge --ff-only "$TRAVIS_COMMIT" && \
git push ${GIT_REPO_PUSH}
