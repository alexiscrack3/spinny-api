#!/bin/sh

set -e

bin/rails db:create

bin/rails db:migrate

# exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
