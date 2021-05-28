CI_SOURCE_PATH=${CI_SOURCE_PATH:-$(dirname "$(realpath "$0")")/..}
TRAVIS_BRANCH=${TRAVIS_BRANCH:-$(git rev-parse --short HEAD)}

cd $CI_SOURCE_PATH

echo "Building $TRAVIS_BRANCH"
CHANGED_FILES="$(git diff --name-only $TRAVIS_COMMIT_RANGE --)"

if [ -n "${CHANGED_FILES}" ] ; then
  if (echo ${CHANGED_FILES} | grep -qEw "README") ; then
    echo "README has changed"
    echo "${CHANGED_FILES}"
  else
    echo "Current changes are: "
    echo "${CHANGED_FILES}"
    echo "README not changed"
    exit 0
  fi
else
  echo "No changes at all!"
  exit 0
fi

echo "TEST_RESULT=1" > /tmp/result
