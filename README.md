Dockerised test lab for testing prometheus and fluentd 
integration using the fluent-plugin-prometheus plugin.
Includes all the following in one container:

- NGINX 
- prometheus
- fluentd

Run like :

docker run -d -p 80:80 -p 443:443 -p 9999:9999 -p 24231:24231 -p 9090:9090 -p 20000:20000 <image-id>

Application ports browsable on localhost:

80	: sample nginx application 
9999:	: nginx proxy port (send you to google)
24231	: fluentd  
9090	: prometheus metrics

(NOTE: if there is another fluentd server listening on 20 000 fleuntd node will send heartbeat there)
