ARG CONFLUENCE_VERSION=7.15.0
FROM openjdk:11-jdk as atlassian-plugin-sdk-data
# To use the default value of an ARG declared before the first FROM use an ARG instruction without a value inside of a build stage:
ARG CONFLUENCE_VERSION

RUN apt-get update && apt-get install -y --no-install-recommends apt-transport-https\
 && sh -c 'echo "deb https://packages.atlassian.com/atlassian-sdk-deb stable contrib" >>/etc/apt/sources.list'\
 && wget https://packages.atlassian.com/api/gpg/key/public\
 && apt-key add public\
 && apt-get update && apt-get install -y --no-install-recommends atlassian-plugin-sdk\
 && rm -rf /var/lib/apt/lists/*\
 # -----------------
 # dry-run to start confluence and create populated sdk-data-home
 # -----------------
 && atlas-run-standalone --product confluence --server localhost --http-port 8090 --version $CONFLUENCE_VERSION --context-path ""

FROM atlassian/confluence:$CONFLUENCE_VERSION as confluence-server
# To use the default value of an ARG declared before the first FROM use an ARG instruction without a value inside of a build stage:
ARG CONFLUENCE_VERSION

ENV CONFLUENCE_HOME=/var/atlassian/application-data/sdk-data-home

COPY --chown=confluence:confluence --from=atlassian-plugin-sdk-data /amps-standalone-confluence-$CONFLUENCE_VERSION/target/confluence/home $CONFLUENCE_HOME
