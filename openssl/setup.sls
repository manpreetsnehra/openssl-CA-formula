{{ salt['pillar.get']('opensslca:cadir') }}:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false
    
{{ salt['pillar.get']('opensslca:cadir') }}/crlnumber:
  file.managed:
    - source: salt://openssl/files/crlnumber    
    - user: root
    - group: root
    - mode: 600
    - replace: false
    
{{ salt['pillar.get']('opensslca:cadir') }}/serial:
  file.managed:
    - source: salt://openssl/files/serial
    - user: root
    - group: root
    - mode: 600
    - replace: false
    
{{ salt['pillar.get']('opensslca:cadir') }}/index.txt:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    - replace: false
 
{{ salt['pillar.get']('opensslca:cadir') }}/certs:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false
 
{{ salt['pillar.get']('opensslca:cadir') }}/newcerts:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false

{{ salt['pillar.get']('opensslca:cadir') }}/crl:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false 

{{ salt['pillar.get']('opensslca:cadir') }}/private:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false    

{{ salt['pillar.get']('opensslca:cadir') }}/csr:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false 
    
{{ salt['pillar.get']('opensslca:cadir') }}/revoked:
  file.directory:
    - makedirs: True    
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700
    - replace: false 
    
{{ salt['pillar.get']('opensslca:configdir') }}/openssl.cnf:
  file.managed:
    - source: salt://openssl/templates/openssl.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 600


      