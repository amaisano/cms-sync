FROM quay.io/pantheon-public/build-tools-ci
USER root
COPY . /app
CMD ["/app/sync-pantheon.sh"]
