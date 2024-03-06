FROM pytorch/pytorch:2.2.1-cuda11.8-cudnn8-runtime

ARG USERNAME
ARG USER_ID

WORKDIR /workspace
ENV HOME=/workspace
ENV PATH=/workspace/.local/bin:$PATH
ENV USERNAME=${USERNAME}
ENV USER_ID=${USER_ID}

ADD cert.pem /workspace/cert.pem
ADD key.pem /workspace/key.pem

# Install dependencies and set default realm
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        curl \
        sudo \
        git \
        krb5-user \
        kstart \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext6 \
    && rm -rf /var/lib/apt/lists/* \
    && echo "MEDIA.MIT.EDU" > /tmp/default_realm.txt \
    && echo "MEDIA.MIT.EDU" | sudo tee -a /etc/krb5.conf \
    && rm /tmp/default_realm.txt \
    && groupadd -g 2000 mlusers \
    && useradd -g 2000 -u $USER_ID -m -s /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && chown -R $USERNAME:mlusers /workspace \
    && mkdir -p /workspace/.cache \
    && chown -R $USERNAME:mlusers /workspace/.cache \
    && ln -s /u/$USERNAME \
    && curl -fsSL https://code-server.dev/install.sh | sh \
    && pip install ipykernel matplotlib ipywidgets

EXPOSE 8443
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8443", "--cert", "/workspace/cert.pem", "--cert-key", "/workspace/key.pem"]
