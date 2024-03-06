
## Codeserver-Pytorch-Cuda Docker

This Dockerfile is particularly designed for easier use of the MIT Media Lab NECsys.

### Clone this repository

`git clone https://github.com/kekehurry/coderserver_docker.git`

### Docker build

`docker build --build-arg USERNAME=$(whoami) --build-arg USER_ID=$(id -u) -t codeserver .`


### Docker run

`docker run -itd -v /mas:/mas -v /u:/u -v /dtmp:/dtmp -v /tmp:/tmp -p $(id -u):8443 -u $(id -u):2000 -e YOUR_HOST=$(hostname) -e YOUR_USERNAME=$(whoami) -e YOUR_UID=$(id -u) -e "PASSWORD=$(whoami)" --name codeserver codeserver`


### ssl certificate
download the cert.pem and add to the trusted list. Also, you can generate your own cert and key with the domain '*.media.mit.edu', and replace `cert.pem` and `key.pem`.
I used `mkcert` to generate these files.


