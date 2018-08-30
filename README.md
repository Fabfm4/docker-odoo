# Install
```bash
docker pull fabfm4/docker-odoo
```


# Run
```bash
docker run -it -v <path-.odoorc>:/home/odoo/public/.odoorc --link <containar-name-db>:<name-host> docker-odoo ./odoo-bin -c .odoorc
```
