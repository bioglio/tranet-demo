FROM jupyter/datascience-notebook

RUN pip install wordcloud

RUN mkdir ./tranet-demo
COPY *.ipynb ./tranet-demo/

WORKDIR ./tranet-demo/
ADD https://datacloud.di.unito.it/index.php/s/M8KwNk1zussVkos/download ./data.zip
USER root
RUN chown jovyan ./*
USER jovyan
RUN unzip -q data.zip
RUN rm data.zip



