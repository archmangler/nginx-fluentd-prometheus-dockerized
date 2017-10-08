#!/bin/sh
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
cd /opt/fluent-plugin-prometheus
echo "about to run FLUENTD ..."
bundle exec fluentd -c /opt/fluent-plugin-prometheus/misc/fluentd_sample.conf
./prometheus-1.5.2.linux-amd64/prometheus -config.file=./misc/prometheus.yaml -storage.local.path=./prometheus/metrics
