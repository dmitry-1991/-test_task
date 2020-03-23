nginx_pkg:
  pkg.installed:
    - name: nginx

nginx_service:
  service.running:
    - name: nginx
    - reload: True
    - enable: True
    - require:
      - pkg: nginx_pkg

/etc/nginx/sites-available/webserver.conf:
  file.managed:
    - source: salt://nginx/webserver.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
      server_name: d-VirtualBox
    - require_in:
      - file: /etc/nginx/sites-enabled/webserver.conf

/etc/nginx/sites-enabled/webserver.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/webserver.conf
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/default:
  file:
    - absent
    - require:
      - pkg: nginx
