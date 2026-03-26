FROM postgres:latest
COPY conf/* /etc/postgresql/
COPY initdb/* /docker-entrypoint-initdb.d/
#COPY scripts/* /home/scripts/