#ARG PIHOLE_VERSION
FROM pihole/pihole:2023.10.0
RUN apt update && apt install -y unbound

COPY pihole-unbound/lighttpd-external.conf /etc/lighttpd/external.conf 
COPY pihole-unbound/unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY pihole-unbound/99-edns.conf /etc/dnsmasq.d/99-edns.conf
RUN mkdir -p /etc/services.d/unbound
COPY pihole-unbound/unbound-run /etc/services.d/unbound/run
RUN chmod +x /etc/services.d/unbound/run

ENTRYPOINT ./s6-init