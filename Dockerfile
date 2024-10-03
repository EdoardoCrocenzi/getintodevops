FROM httpd:latest
COPY httpd.no-cgid.conf /usr/local/apache2/conf/httpd.conf
