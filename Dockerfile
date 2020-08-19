FROM openjdk:11-jdk as atlassian-plugin-sdk-data

RUN apt-get update && apt-get install -y --no-install-recommends apt-transport-https\
 && sh -c 'echo "deb https://packages.atlassian.com/atlassian-sdk-deb stable contrib" >>/etc/apt/sources.list'\
 && wget https://packages.atlassian.com/api/gpg/key/public\
 && apt-key add public\
 && apt-get update && apt-get install -y --no-install-recommends atlassian-plugin-sdk\
 && rm -rf /var/lib/apt/lists/*\
## dry-run to start confluence and get sdk-data-home
 && atlas-run-standalone --product confluence --server localhost

FROM atlassian/confluence-server:latest as confluence-server

ENV CONFLUENCE_HOME=/var/atlassian/application-data/sdk-data-home

COPY --from=atlassian-plugin-sdk-data /amps-standalone-confluence-LATEST/target/confluence/home $CONFLUENCE_HOME
