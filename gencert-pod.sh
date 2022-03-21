#!/bin/bash
sudo podman run -it --rm --name certbot \
--pod my-pod \
-v $(pwd)/le/certs:/etc/letsencrypt:Z \
-v $(pwd)/le/data:/webroot:Z \
certbot/certbot certonly --standalone -v