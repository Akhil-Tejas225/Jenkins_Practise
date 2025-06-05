# Step 1: Generate cert + key
openssl req -newkey rsa:2048 -nodes -keyout jenkins.key -x509 -days 365 -out jenkins.crt

# notes:openssl req -newkey rsa:2048 -nodes -keyout jenkins.key -x509 -days 365 -out jenkins.crt(Disection)
# "openssl req":
#   - This starts  X509 certificate signing Request generation process
# "-newkey rsa:2048":
#   - create a newkey of rsa algorthim with 2048 bits
# "-nodes":
#    - do not encrypt the private keyfile
#    - stand for no "DES" 
#    - This means don't promt for phassphrase on the private key file
#  This is useful for automated systems like Jenkins, where you don’t want Jenkins asking for a password every time it uses the key.
# "-keyout jenkins.key" :
#     - save the private key to jenkins.key
#"-x509":
#    - This skips the CSR step and directly generates a self-signed certificate
# Perfect for internal/testing HTTPS setups without needing a real certificate authority (CA).
#"-days 365": 
#  - valid for 365 days
#"-out jenkins.crt":
#  - output the jenkins.certificate

# ziping jenkins.crt and jenkins.key to p12 format and protecting it with password 
openssl pkcs12 -export \
  -in jenkins.crt \
  -inkey jenkins.key \
  -out jenkins.p12 \
  -name jenkins \
  -password pass:changeit
# running the jenkins.war file directly 
java -jar jenkins.war \
  --httpPort=-1 \               # disabling the httpPort
  --httpsPort=8443 \
  --httpsKeyStore=jenkins.p12 \
  --httpsKeyStorePassword=changeit

# sudo lsof -i :8080 
#   -  lsof means list open files
#   -  This command checks which application is using port 8080
#   -  we will recieve PId as one of the output which we can use for killing the process
# sudo kill -9 <pid> 
#   - "-9" stands for sending SIGKILL(i.e for sending kill signal for process id at kernel level)forcefull shutdown
#   - "-15"stands for sending SIGTERM(i.e for sending termination signal for process id at kernel level )gracefull termination 


 
