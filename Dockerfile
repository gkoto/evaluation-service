FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum* ./
COPY . .
RUN go mod tidy && go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o evaluation-service .

FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/evaluation-service .
EXPOSE 8004
CMD ["./evaluation-service"]
