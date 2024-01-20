#!/usr/bin/env bash
# Sets up web servers for the deployment of web_static.

sudo apt-get update
sudo apt-get -y install nginx

sudo mkdir -p '/data/web_static/releases/test/'
sudo mkdir -p '/data/web_static/shared/'
echo "Holberton School" | sudo tee '/data/web_static/releases/test/index.html'

sudo ln -sf '/data/web_static/releases/test/' '/data/web_static/current'

sudo chown -R ubuntu:ubuntu /data/

printf %s "server {
	listen 80 default_server;
	add_header X-Served-By $HOSTNAME;
	root   /var/www/html;
	index index.html index.htm;

	location /hbnb_static/ {
		alias /data/web_static/current/;
		index index.html index.htm;
	}

	location /redirect_me {
    	return 301 https://github.com/titem-012;
    }

	error_page 404 /404.html;
    location /404 {
    	root /var/www/html;
    	internal;
    }
}" | sudo tee /etc/nginx/sites-enabled/default

sudo service nginx restart

