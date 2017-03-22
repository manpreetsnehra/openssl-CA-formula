#openssl initialization
{% set myca = salt['pillar.get']('opensslca:ca') %}
{% set myrevoke = salt['pillar.get']('revokecert:revoke') %}
include:
  - openssl.install
  - openssl.setup
  - openssl.createcsr
{% if  myca %}
  - openssl.createca
  - openssl.createcerts  
{% endif %}
{% if myrevoke %}  
  - openssl.revokecerts
{% endif %}
