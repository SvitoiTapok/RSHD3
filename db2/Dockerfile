FROM postgres:latest
COPY conf/* /etc/postgresql/
COPY standby/standby.sh /usr/local/bin/standby.sh
RUN chmod +x /usr/local/bin/standby.sh
#COPY scripts/* /home/scripts/