FROM openjdk:11-jdk as atlassian-plugin-sdk-data

ARG CONFLUENCE_VERSION=7.13.0

RUN apt-get update && apt-get install -y --no-install-recommends apt-transport-https\
 && sh -c 'echo "deb https://packages.atlassian.com/atlassian-sdk-deb stable contrib" >>/etc/apt/sources.list'\
 && wget https://packages.atlassian.com/api/gpg/key/public\
 && apt-key add public\
 && apt-get update && apt-get install -y --no-install-recommends atlassian-plugin-sdk\
 && rm -rf /var/lib/apt/lists/*\
 # -----------------
 # dry-run to start confluence and create populated sdk-data-home
 # -----------------
 && atlas-run-standalone --product confluence --server localhost --http-port 8090 --version $CONFLUENCE_VERSION --context-path confluence\
 # -----------------
 # manually setup context path to root, because option --context-path  ROOT doesn't work in precedent command as described in docs
 # -----------------
 && sed -i 's#<property name="confluence.webapp.context.path">/confluence</property>#<property name="confluence.webapp.context.path"/>#' \
 /amps-standalone-confluence-LATEST/target/confluence/home/confluence.cfg.xml

FROM atlassian/confluence:$CONFLUENCE_VERSION as confluence-server

ENV CONFLUENCE_HOME=/var/atlassian/application-data/sdk-data-home

COPY --chown=confluence:confluence --from=atlassian-plugin-sdk-data /amps-standalone-confluence-$CONFLUENCE_VERSION/target/confluence/home $CONFLUENCE_HOME
