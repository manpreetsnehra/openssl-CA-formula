# openssl-formula
Saltstack openssl formula

The configuration is very static as of now here is the pillar explanation

#Certificate authority Config
opensslca:
  - configdir: /etc/ssl    #location of openssl.cnf
  - cadir: /etc/ssl/CA     #location of the CA directory tree
  - countryName: SC        #default country name for CA and certs its even added to openssl.cnf if manual certificate generation is performed
  - provinceName: Some State # default state name for openssl.cnf
  - cityName: Some City      #city/organization/adminemail and name of the CA   
  - organizationName: Some Organization
  - adminEmail: admin@example.com
  - caName: Organization Root Certificate
  - capassword: password     # CA password, your certificates are signed with this password do not place this file in a publicically available location
  - ca: True #create a ca or only use this formula for csr generation
    
gencert: 
  - fqdn:
    - host0.example.com      #hosts/user for which you want to generate signed certificate
    
revokecert:
  - revoke: False #Whether to revoke any certificates or not.
  - fqdn:
    - host0.example.com      # hosts/user for which you want to revoke the certificate