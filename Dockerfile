FROM alpine:latest
COPY . /app
WORKDIR /app
CMD ["echo", "React-TODO-List"]