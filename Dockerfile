FROM ubuntu:22.04

RUN apt-get update && apt-get install -y bash

WORKDIR /app
COPY . .

CMD ["bash", "hello.sh"]
