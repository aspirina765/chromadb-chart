ARG CHROMA_VERSION=0.5.3
FROM chromadb/chroma:${CHROMA_VERSION} as base
#ghcr.io/chroma-core/chroma:${CHROMA_VERSION} as base

#COPY ./image/docker_entrypoint.sh /docker_entrypoint.sh
COPY ./docker_entrypoint.sh /docker_entrypoint.sh
WORKDIR /chroma
RUN find /chroma -mindepth 1 -maxdepth 1 ! \( -name 'chromadb' -o -name 'LICENSE' -o -name 'requirements.txt' \) -exec rm -rf {} \; && \
    groupadd chroma && \
    pip install virtualenv && \
    useradd -g chroma -d /chroma chroma && \
    python -m virtualenv /chroma/venv && \
    . /chroma/venv/bin/activate && \
    pip install --force-reinstall --no-cache-dir -r /chroma/requirements.txt && \
    chown -R chroma:chroma /chroma && \
    apt-get update -qq && apt-get install sqlite3 sudo -y && \
    echo 'chroma ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    pip uninstall numpy -y && \
    pip install numpy==1.26.4 && \
    chown -R chroma:chroma /docker_entrypoint.sh
EXPOSE 8000
USER chroma

CMD ["/docker_entrypoint.sh"]
