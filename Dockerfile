# Use a base image that includes the JVM
FROM openjdk:11

# Install curl and supervisord
RUN apt-get update && apt-get install -y curl supervisor

RUN curl -SL "https://github.com/lightbody/browsermob-proxy/releases/download/browsermob-proxy-2.1.4/browsermob-proxy-2.1.4-bin.zip" -o "/browsermob-proxy.zip" \
    && unzip /browsermob-proxy.zip \
    && rm -f /browsermob-proxy.zip \
    && mkdir -p /var/run/supervisor /var/log/supervisor
# Copy the supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8081-8200

# Start supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]