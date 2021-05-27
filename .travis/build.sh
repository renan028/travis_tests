CI_SOURCE_PATH=${CI_SOURCE_PATH:-$(dirname "$(realpath "$0")")/..}
TRAVIS_BRANCH=${TRAVIS_BRANCH:-$(git rev-parse --short HEAD)}

cd $CI_SOURCE_PATH

echo "Building $TRAVIS_BRANCH"
CHANGED_FILES="$(git diff --name-only ${TRAVIS_BRANCH}..HEAD --)"
echo ${CHANGED_FILES}

echo "HEAD@{0} HEAD@{1}: "
CHANGED_FILES="$(git diff --name-only HEAD@{0} HEAD@{1})"
echo ${CHANGED_FILES}

echo "TRAVIS_COMMIT_RANGE: "
CHANGED_FILES="$(git diff --name-only $TRAVIS_COMMIT_RANGE --)"
echo ${CHANGED_FILES}

echo "HEAD~..HEAD: "
CHANGED_FILES="$(git diff --name-only HEAD~..HEAD)"
echo ${CHANGED_FILES}
