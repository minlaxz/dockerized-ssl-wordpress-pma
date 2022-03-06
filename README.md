### Instructions:


1. Get a free domain name from freenom something like `domain.tld` _(You may need to use US address)_

2. Change NS of cloudflare in your provider, you can now close FreeNom website :).

3. You can also create a new subdomain like `subdomain.domain.tld` in cloudflare.

4. I considered that you already have a cloud server and its' IP address.

5. Point A record to your cloud server ip address. (Subdomain or Domain)

    + Like this: `A` | `IP_ADDRESS` | `domain.tld` or `subdomain.domain.tld` | `proxied`

6. SSH to your cloud server

7. Clone the repository

8. Run `./gencert.sh`

    + You will get a certificate and a key.

9. Check `.env` file and fill in your changes.

10. Run `./docker-compose up -d` to start.

    + Run `./docker-compose logs` to see the logs.

    + Run `./docker-compose down` to stop.



