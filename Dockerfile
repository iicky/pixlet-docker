FROM python:3.9-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
  libwebpdemux2 \
  libwebpmux3 \
  wget

# Install FastAPI
RUN pip install --upgrade --no-cache-dir \
  fastapi \
  pydantic \
  uvicorn

# Download Pixlet
WORKDIR /tmp
RUN wget https://github.com/tidbyt/pixlet/releases/download/v0.18.1/pixlet_0.18.1_linux_amd64.tar.gz && \
  tar -xvf pixlet_0.18.1_linux_amd64.tar.gz -C /usr/local/bin

WORKDIR /srv
COPY app /srv/app
COPY stars /srv/stars

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "3001"]