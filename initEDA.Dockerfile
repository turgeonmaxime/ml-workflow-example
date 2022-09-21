FROM --platform=linux/arm64 rocker/verse:4.2.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gdebi-core \
    && rm -rf /var/lib/apt/lists/*

RUN install2.r \
    cowplot \
    knitr \
    moments \
    pheatmap \
    quarto \
    scico

# Quarto is already installed in rocker/verse
# RUN curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
# RUN gdebi --non-interactive quarto-linux-amd64.deb && rm quarto-linux-amd64.deb

COPY data /home/data
COPY inst /home/inst
COPY src /home/src

WORKDIR /home

CMD ["bash"]