FROM python:3.6.10-slim

RUN apt-get update && apt-get install -y \
  gcc \
  git
  
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
    
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

RUN pip install jupyter

RUN git clone https://github.com/usc-isi-i2/kgtk/ --branch feature/lite

RUN cd /kgtk && python setup.py install --lite