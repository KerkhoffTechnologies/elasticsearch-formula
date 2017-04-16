{% from "elasticsearch/map.jinja" import elasticsearch_map with context %}

include:
  - elasticsearch.repo

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch_map.filebeat_pkg }}
    - require:
      - sls: elasticsearch.repo

filebeat_config:
  file.managed:
    - name: /etc/filebeat/filebeat.yaml
    - source: salt://elasticsearch/templates/filebeat.jinja
    - template: jinja
    - watch_in:
      - service: filebeat_service

filebeat_service:
  service.running:
    - name: filebeat
    - enable: True
    - require:
      - pkg: filebeat

