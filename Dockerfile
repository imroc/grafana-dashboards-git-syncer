FROM docker.io/bitnami/git:2.41.0

COPY pull.sh /pull.sh

RUN chmod +x /pull.sh

ENTRYPOINT ["/pull.sh"]