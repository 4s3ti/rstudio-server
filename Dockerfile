FROM r-base:latest

ENV rpwd="rstudio"

RUN apt update -y
RUN apt-get install -y gdebi-core gpg
RUN wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2022.07.1-554-amd64.deb
RUN gdebi -n rstudio-server-2022.07.1-554-amd64.deb


RUN rm -rf rstudio-server-2022.07.1-554-amd64.deb

RUN useradd -u 1001 -u 1001 -m -s /bin/bash rstudio \
  && echo rstudio:"${rpwd}" | chpasswd

EXPOSE 8787

ENTRYPOINT ["/usr/lib/rstudio-server/bin/rserver"]
CMD ["--server-daemonize=0"]
