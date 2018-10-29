atlassian-sdk-confluence
=======================

Docker image with Atlassian Confluence
running in development mode with  [Attlasian SDK](https://developer.atlassian.com/server/framework/atlassian-sdk/atlas-run-standalone/).

Purpose
=======

Using during develop/CI cycles of products interacted with Confluence

How to use
==========

```bash
docker run -p 1990:1990 qwazer/atlassian-sdk-confluence
```

Confluence is accessible at http://localhost:1990/confluence with `admin:admin` credentials.
