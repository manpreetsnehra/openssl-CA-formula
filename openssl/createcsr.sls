{% for fqdn in salt['pillar.get']('gencsr:fqdn') %}
gencsrkey:
  cmd.run:
    - unless: (cat {{ salt['pillar.get']('opensslca:cadir') }}/index.txt|grep ^V|grep {{ fqdn }}| wc -l) == 0
    - name: openssl req -config {{ salt['pillar.get']('opensslca:configdir') }}/openssl.cnf -out {{ salt['pillar.get']('opensslca:cadir') }}/csr/{{ fqdn }}.csr -new -newkey rsa:2048 -nodes -days 365 -keyout {{ salt['pillar.get']('opensslca:cadir') }}/private/{{ fqdn }}.key -subj "/C={{ salt['pillar.get']('opensslca:countryName') }}/ST={{ salt['pillar.get']('opensslca:provinceName') }}/L={{ salt['pillar.get']('opensslca:cityName') }}/O={{ salt['pillar.get']('opensslca:organizationName') }}/CN={{ fqdn }}/emailAddress={{ salt['pillar.get']('opensslca:adminEmail') }}/"
    - stateful: False
    - creates:  {{ salt['pillar.get']('opensslca:cadir') }}/private/{{ fqdn }}.key
    - require: 
      - pkg: openssl_install
{% endfor %}