{% for fqdn in salt['pillar.get']('gencert:fqdn') %}
gencert:
  cmd.run:
    - unless: test `cat {{ salt['pillar.get']('opensslca:cadir') }}/index.txt|grep ^V|grep {{ fqdn }}| wc -l` -eq 1
    - name: openssl ca -config {{ salt['pillar.get']('opensslca:configdir') }}/openssl.cnf -batch -md sha256 -out {{ salt['pillar.get']('opensslca:cadir') }}/certs/{{ fqdn }}.crt -in {{ salt['pillar.get']('opensslca:cadir') }}/csr/{{ fqdn }}.csr -passin pass:{{ salt['pillar.get']('opensslca:capassword') }}
    - stateful: False
    - require: 
      - pkg: openssl_install
      - cmd: gencsrkey
{% endfor %}
