atlassian-sdk-confluence
========================

Docker image with
[Atlassian Confluence Server](https://hub.docker.com/r/atlassian/confluence-server)
running with demo data from
[Attlasian SDK](https://developer.atlassian.com/server/framework/atlassian-sdk/atlas-run-standalone/).

How to use
==========

```bash
docker run -p 8090:8090 -p 8091:8091 qwazer/atlassian-sdk-confluence
```

After Confluence start it will be accessible at
http://localhost:8090 with `admin:admin` credentials.
