
## Codeserver-Pytorch-Cuda Docker

This Dockerfile is particularly designed for easier use of the MIT Media Lab NECsys.

### Connect NECsys

follow the official guidance of NECsys and connect to a matlaber node : https://nuwiki.media.mit.edu/bin/view/Necsysdocs/MatlaberNotes

### Clone this repository

`git clone https://github.com/kekehurry/coderserver_docker.git`

### Docker build

`docker build --build-arg USERNAME=kekehurry --build-arg USER_ID=8443 -t codeserver .`


### Docker run

`docker run -itd -v D:\codeserver:/workspace -p 8443:8443 -u 2000:2000 -e YOUR_HOST=10.29.159.180 -e YOUR_USERNAME=kekehurry -e YOUR_UID=2000 -e PASSWORD=kekehurry --name codeserver codeserver`


### ssl certificate
download the cert.pem and add to the trusted list. Also, you can generate your own cert and key with the domain '*.media.mit.edu', and replace `cert.pem` & `key.pem`.
I used [mkcert](https://github.com/FiloSottile/mkcert) to generate these files.


