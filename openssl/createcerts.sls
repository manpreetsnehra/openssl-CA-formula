{% for fqdn in salt['pillar.get'](gencert:fqdn) %}
gencsrkey:
  cmd.run:
    - unless: test -f {{ salt['pillar.get'](opensslca:configdir) }}/private/{{ fqdn }}.key
    - name: openssl req -out {{ salt['pillar.get'](opensslca:configdir) }}/csr/$1.csr -new -newkey rsa:2048 -nodes -keyout {{ salt['pillar.get'](opensslca:configdir) }}/private/$1.key -subj "/C={{ salt['pillar.get'](opensslca:countryName) }}/ST={{ salt['pillar.get'](opensslca:provinceName) }}\
             /L={{ salt['pillar.get'](opensslca:cityName) }}/O={{ salt['pillar.get'](opensslca:organizationName) }}\
             /CN={{ fqdn }}/emailAddress={{ salt['pillar.get'](opensslca:adminEmail) }}/"
    - stateful: False
    - creates:  {{ salt['pillar.get'](opensslca:configdir) }}/private/{{ fqdn }}.key
    
gencert:
  cmd.run:
    - unless: test -f {{ salt['pillar.get'](opensslca:configdir) }}/certs/{{ fqdn }}.crt
    - name: openssl ca -md sha256 -out {{ salt['pillar.get'](opensslca:configdir) }}/certs/$1.crt -in {{ salt['pillar.get'](opensslca:configdir) }}/csr/$1.csr -passin pass:{{ salt['pillar.get'](opensslca:capassword) }}
    - stateful: False
    - creates: {{ salt['pillar.get'](opensslca:configdir) }}/certs/{{ fqdn }}.crt

{% endfor %}    

 