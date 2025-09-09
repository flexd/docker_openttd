#!/bin/sh

# This is the script that will run at the end
set -- /usr/local/bin/startgame "$@"

# Change openttd user and group ids to what was specified
PUID=${PUID:-911}
PGID=${PGID:-1000}
groupmod -o -g "$PGID" openttd
usermod -o -u "$PUID" openttd

# Take ownership of /config and /app
chown -R openttd:openttd /config
chown -R openttd:openttd /app

echo "

User UID:    $(id -u openttd)
User GID:    $(id -g openttd)

───────────────────────────────────────

"

# Drop from root to the openttd user
set -- gosu openttd "$@"

# Run original entrypoint
exec "$@"


