#!/bin/bash
export CHROMA_SERVER_HTTP_PORT=${CHROMA_SERVER_HTTP_PORT:-8000}
export CHROMA_SERVER_LOG_CONFIG=${CHROMA_SERVER_LOG_CONFIG:-log_config.yaml}
export CHROMA_SERVER_HOST=${CHROMA_SERVER_HOST:-"0.0.0.0"}

sudo chown -R chroma:chroma ${PERSIST_DIRECTORY}

. /chroma/venv/bin/activate
pip install --force-reinstall --no-cache-dir chroma-hnswlib
pip uninstall numpy -y ;
pip install numpy==1.26.4 ;
uvicorn chromadb.app:app --workers 1 --host ${CHROMA_SERVER_HOST} --port ${CHROMA_SERVER_HTTP_PORT} --proxy-headers #--log-config ${CHROMA_SERVER_LOG_CONFIG}
