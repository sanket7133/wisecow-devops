FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*
#&& apt-get install -y fortune

COPY wisecow.sh /app/

RUN chmod +x app/wisecow.sh
WORKDIR /app


EXPOSE 4499


CMD ["./wisecow.sh"]