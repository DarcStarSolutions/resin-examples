if [ ! -f /data/grafana/grafana.db ]; then
  mkdir /data/grafana
  cp /tmp/grafana.db /data/grafana/
fi

grafana-cli plugins install natel-influx-admin-panel

exec /usr/sbin/grafana-server --homepath /usr/share/grafana