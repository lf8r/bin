#!/bin/bash
set -e
#!/bin/bash
docker run --restart unless-stopped -d -e REGISTRY_STORAGE_DELETE_ENABLED=true -p 5000:5000 --name registry registry:2.7
