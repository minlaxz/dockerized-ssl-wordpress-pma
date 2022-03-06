docker run -it --rm -p 443:443 -p 80:80 --name certbot \
--mount src=$(pwd)/le/certs,target=/etc/letsencrypt,type=bind \
--mount src=$(pwd)/le/data,target=/webroot,type=bind \
certbot/certbot certonly --standalone