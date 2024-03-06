FROM pytorch/pytorch:2.2.1-cuda11.8-cudnn8-runtime

WORKDIR /workspace
ENV HOME=/workspace
ENV PATH=/workspace/.local/bin:$PATH

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
    && useradd -g 2000 -u 17885 -m -s /bin/bash kaihu \
    && echo "kaihu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && chown -R kaihu:mlusers /workspace \
    && mkdir -p /workspace/.cache \
    && chown -R kaihu:mlusers /workspace/.cache \
    && ln -s /u/kaihu \
    && curl -fsSL https://code-server.dev/install.sh | sh \
    && pip install ipykernel matplotlib ipywidgets

EXPOSE 8443
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8443", "--cert", "/workspace/cert.pem", "--cert-key", "/workspace/key.pem"]
