FROM debian:buster-slim
LABEL authors="Ding Corporation, Pieterjan Montens"

ENV USER=user \
    PASSWORD=password

VOLUME /var/mail /config /output

ADD save-attachments.crontab /etc/cron.d/save-attachments
ADD save-attachments.sh /opt/save-attachments.sh

COPY install-packages.sh .
RUN ./install-packages.sh

COPY default.fetchmailrc /config/.fetchmailrc

RUN maildirmake /var/mail/working \
    && mkdir /var/mail/working/landing \
    && mkdir /var/mail/working/extracted \
    && echo "to /var/mail/working" > /root/.mailfilter \
    && touch /var/mail/save-attachments.log \
    && chmod 0644 /etc/cron.d/save-attachments

ADD docker-entrypoint.sh /opt/docker-entrypoint.sh
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
CMD ["cron"]
