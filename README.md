### First Step

`docker build --build-arg USERNAME=$(whoami) --build-arg USER_ID=$(id -u) -t codeserver .`
`


### Second Step

`docker run -itd -v /mas:/mas -v /u:/u -v /dtmp:/dtmp -v /tmp:/tmp -p $(id -u):8443 -u $(id -u):2000 -e YOUR_HOST=$(hostname) -e YOUR_USERNAME=$(whoami) -e YOUR_UID=$(id -u) -e "PASSWORD=hk19931111" --name codeserver codeserver`