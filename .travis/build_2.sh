CI_SOURCE_PATH=${CI_SOURCE_PATH:-$(dirname "$(realpath "$0")")/..}
TRAVIS_BRANCH=${TRAVIS_BRANCH:-$(git rev-parse --short HEAD)}

cd $CI_SOURCE_PATH

echo "Building $TRAVIS_BRANCH"
CHANGED_FILES="$(git diff --name-only $TRAVIS_COMMIT_RANGE)"

if [ -n "${CHANGED_FILES}" ] ; then
  if (echo ${CHANGED_FILES} | grep -qEw "PR1") ; then
    echo "PR1 has changed!"
    PR_CHANGED=1
  fi
  if (echo ${CHANGED_FILES} | grep -qEw "PR2") ; then
    echo "PR2 has changed!"
    PR_CHANGED=1
  fi
fi

if [ -f "/tmp/result" ]; then
  source /tmp/result
fi
if [ -z ${TEST_RESULT} ] ; then
  if [ -z ${PR_CHANGED} ] ; then
    echo "No changes, exiting tests ..."
    exit 0
  fi
  echo "No TEST_RESULT, but PR_CHANGED"
fi

if [ "$TRAVIS_BRANCH" == "master" -a "$TRAVIS_PULL_REQUEST" == "false" ]; then
  if [ -z ${TEST_RESULT} ] ; then
    echo "No TEST_RESULT, it will not be updated"
    exit 0
  else
    echo "TEST_RESULT! Updating stuff..."
    exit 0
  fi
fi
exit 0