{{ salt['pillar.get'](opensslca:configdir) }}:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false
    
{{ salt['pillar.get'](opensslca:configdir) }}/crlnumber:
  file.managed:
    - source: salt://openssl/files/crlnumber    
    - user: root
    - group: root
    - mode: 600
    - replace: false
    
{{ salt['pillar.get'](opensslca:configdir) }}/serial:
  file.managed:
    - source: salt://openssl/files/serial
    - user: root
    - group: root
    - mode: 600
    - replace: false
    
{{ salt['pillar.get'](opensslca:configdir) }}/index.txt:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    - replace: false
 
{{ salt['pillar.get'](opensslca:configdir) }}/certs:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false
 
{{ salt['pillar.get'](opensslca:configdir) }}/newcerts:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false

{{ salt['pillar.get'](opensslca:configdir) }}/crl:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false 

{{ salt['pillar.get'](opensslca:configdir) }}/private:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false    
    
createcakey:
  cmd.run:
    - unless: test -f {{ salt['pillar.get'](opensslca:configdir) }}/private/ca.key.pem
    - name: openssl genrsa -passout pass:{{ salt['pillar.get'](opensslca:configdir) }} -aes256 -out private/ca.key.pem 4096
    - stateful: False
    - creates: {{ salt['pillar.get'](opensslca:configdir) }}/private/ca.key.pem
    
createcacert:
  cmd.run:
    - unless: test -f {{ salt['pillar.get'](opensslca:configdir) }}/certs/ca.cert.pem
    - name:  openssl req -config openssl.cnf -key private/ca.key.pem -new -x509 -days 7300 -sha256 \
             -extensions v3_ca -passout pass:{{ salt['pillar.get'](opensslca:configdir) }} -out certs/ca.cert.pem \
             -subj "/C={{ salt['pillar.get'](opensslca:countryName) }}/ST={{ salt['pillar.get'](opensslca:provinceName) }}\
             /L={{ salt['pillar.get'](opensslca:cityName) }}/O={{ salt['pillar.get'](opensslca:organizationName) }}\
             /CN={{ salt['pillar.get'](opensslca:caName) }}/emailAddress={{ salt['pillar.get'](opensslca:adminEmail) }}/"
    - stateful: False
    - creates: {{ salt['pillar.get'](opensslca:configdir) }}/certs/ca.cert.pem    