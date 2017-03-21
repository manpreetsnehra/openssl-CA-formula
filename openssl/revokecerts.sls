{% for fqdn in salt['pillar.get']('revokecert:fqdn') %}
revoke:
  cmd.run:
    - unless: (cat {{ salt['pillar.get']('opensslca:cadir') }}/index.txt|grep ^V|grep {{ fqdn }}| wc -l) == 1
    - name: cat {{ salt['pillar.get']('opensslca:cadir') }}/index.txt|grep ^V|grep {{ fqdn }}|awk {'print $3'}| xargs -Icrt openssl ca -config {{ salt['pillar.get']('opensslca:configdir') }}/openssl.cnf -revoke {{ salt['pillar.get']('opensslca:cadir') }}/newcerts/crt.pem -passin pass:{{ salt['pillar.get']('opensslca:capassword') }}
    - stateful: False
    - require: 
      - pkg: openssl_install
      - cmd: createcacert

gencrl:
  cmd.run:
    - unless: (cat {{ salt['pillar.get']('opensslca:cadir') }}/index.txt|grep ^V|grep {{ fqdn }}| wc -l) == 1
    - stateful: False
    - name: openssl ca -config {{ salt['pillar.get']('opensslca:configdir') }}/openssl.cnf  -gencrl -out {{ salt['pillar.get']('opensslca:cadir') }}/crl/crl.pem -passin pass:{{ salt['pillar.get']('opensslca:capassword') }}
    - require: 
      - pkg: openssl_install          
      - cmd: createcacert
      - cmd: revoke          
{% endfor %}