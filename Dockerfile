FROM ubuntu:22.04

WORKDIR /app

COPY hello.sh .

RUN chmod +x hello.sh

CMD ["bash", "hello.sh"]
