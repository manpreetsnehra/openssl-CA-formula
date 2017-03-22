#openssl initialization
{% set myca = salt['pillar.get']('opensslca:ca') %}
include:
  - openssl.install
  - openssl.setup
{% if  myca %}
  - openssl.createca
{% endif %}
  - openssl.createcsr
{% if myca %}    
  - openssl.revokecerts
  - openssl.createcerts  
{% endif %}  
