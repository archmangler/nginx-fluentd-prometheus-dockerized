Dockerised test lab for testing prometheus and fluentd 
integration using the fluent-plugin-prometheus plugin.
Includes all the following in one container:

- NGINX 
- prometheus
- fluentd

Run like :

docker run -d -p 80:80 -p 443:443 -p 9999:9999 -p 24231:24231 -p 9090:9090 -p 20000:20000 <image-id>


