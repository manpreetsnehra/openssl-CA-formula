createcakey:
  cmd.run:
    - name: openssl genrsa -passout pass:{{ salt['pillar.get']('opensslca:capassword') }} -aes256 -out {{ salt['pillar.get']('opensslca:cadir') }}/private/ca.key.pem 4096
    - unless: test -f {{ salt['pillar.get']('opensslca:cadir') }}/private/ca.key.pem
    - stateful: False
    - creates: {{ salt['pillar.get']('opensslca:cadir') }}/private/ca.key.pem
    - require: 
      - pkg: openssl_install
                
createcacert:
  cmd.run:
    - unless: test -f {{ salt['pillar.get']('opensslca:cadir') }}/certs/ca.cert.pem
    - name:  openssl req -config {{ salt['pillar.get']('opensslca:configdir') }}/openssl.cnf -key {{ salt['pillar.get']('opensslca:cadir') }}/private/ca.key.pem -new -x509 -days 7300 -sha256 -extensions v3_ca -passin pass:{{ salt['pillar.get']('opensslca:capassword') }} -out {{ salt['pillar.get']('opensslca:cadir') }}/certs/ca.cert.pem -subj "/C={{ salt['pillar.get']('opensslca:countryName') }}/ST={{ salt['pillar.get']('opensslca:provinceName') }}/L={{ salt['pillar.get']('opensslca:cityName') }}/O={{ salt['pillar.get']('opensslca:organizationName') }}/CN={{ salt['pillar.get']('opensslca:caName') }}/emailAddress={{ salt['pillar.get']('opensslca:adminEmail') }}/"
    - stateful: False
    - require: 
      - cmd: createcakey