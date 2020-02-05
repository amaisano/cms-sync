# cms-sync

Using [Pantheon's recommended base image](https://github.com/pantheon-systems/docker-build-tools-ci), spin up a Terminus-capable environment and run maintenance tasks against our Pantheon account.

The script here authenticates with Pantheon using an environmental variable.

Once authenticated the following steps are taken:

1. Backup the `test` environment prior to overwriting with `live` content
2. Clone the database and files from `live` to `test`
3. Clear caches on `test`
4. Clone the database and files from `test` to `dev` (no backup)
5. Clear caches on `dev`

## Notes

- This process takes a very long time. Each clone operation can take between 30 and 60 minutes, due to the size of the uploaded files directory.
