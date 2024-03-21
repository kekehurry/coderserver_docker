
## Codeserver-Pytorch-Cuda Docker

This Dockerfile is particularly designed for easier use of the MIT Media Lab NECsys.

### Connect NECsys

follow the official guidance of NECsys and connect to a matlaber node : https://nuwiki.media.mit.edu/bin/view/Necsysdocs/MatlaberNotes

### Clone this repository

`git clone https://github.com/kekehurry/coderserver_docker.git`

### Docker build

`docker build --build-arg USERNAME=$(whoami) --build-arg USER_ID=$(id -u) -t codeserver .`


### Docker run

`docker run -itd -v /mas:/mas -v /u:/u -v /dtmp:/dtmp -v /tmp:/tmp -p $(id -u):8443 -u $(id -u):2000 -e YOUR_HOST=$(hostname) -e YOUR_USERNAME=$(whoami) -e YOUR_UID=$(id -u) -e "PASSWORD=$(whoami)" -e "KRB5CCNAME=FILE:/tmp/krb5cc_$(id -un)" --name codeserver codeserver`


### ssl certificate
download the cert.pem and add to the trusted list. Also, you can generate your own cert and key with the domain '*.media.mit.edu', and replace `cert.pem` & `key.pem`.
I used [mkcert](https://github.com/FiloSottile/mkcert) to generate these files.

### open codeserver in browser
run this command in matlaber terminal to get the url for codeserver
`echo "https://$(hostname).media.mit.edu:$(id -u)/"`


