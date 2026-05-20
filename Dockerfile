FROM golang:1.24-alpine AS builder
RUN apk add --no-cache git
WORKDIR /app
COPY . .
ENV GOTOOLCHAIN=auto
RUN go mod tidy && go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o evaluation-service .

FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/evaluation-service .
EXPOSE 8004
CMD ["./evaluation-service"]
