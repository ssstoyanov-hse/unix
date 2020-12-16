#hw 5

# shellcheck disable=SC2038
find / | xargs grep -i linux

# shellcheck disable=SC2046
grep -i 'linux' $(find /)
