{% for fqdn in salt['pillar.get'](revokecert:fqdn) %}
revokecert:
  cmd.run:
    - unless: `cat {{ salt['pillar.get'](opensslca:configdir) }}/index.txt|grep ^V|grep {{ fqdn }}| wc -l` == 1
    - name:
      - cat {{ salt['pillar.get'](opensslca:configdir) }}/index.txt|grep ^V|grep {{ fqdn }}|awk {'print $3'}| xargs -Icrt openssl ca -revoke newcerts/cert.pem -passin pass:{{ salt['pillar.get'](opensslca:capassword) }}
      - openssl ca -gencrl -out crl/crl.pem -passin pass:{{ salt['pillar.get'](opensslca:capassword) }}
    - stateful: False
{% endfor %}	
       