FROM openjdk:11-jdk

EXPOSE 1990

RUN apt-get update && apt-get install -y --no-install-recommends apt-transport-https\
 && sh -c 'echo "deb https://packages.atlassian.com/atlassian-sdk-deb stable contrib" >>/etc/apt/sources.list'\
 && wget https://packages.atlassian.com/api/gpg/key/public\
 && apt-key add public\
 && apt-get update && apt-get install -y --no-install-recommends atlassian-plugin-sdk\
 && rm -rf /var/lib/apt/lists/*\
## dry-run to fill caches
 && atlas-run-standalone --product confluence

ENTRYPOINT  ["atlas-run-standalone", "--product", "confluence"]
