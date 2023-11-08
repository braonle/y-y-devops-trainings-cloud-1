FROM golang:1.21 as build
WORKDIR /app
COPY catgpt/ .
RUN go mod download && CGO_ENABLED=0 go build -o /app/catgpt

FROM gcr.io/distroless/static-debian11
COPY --from=build /app/catgpt /
CMD ["/catgpt"]
EXPOSE 8080