FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copy dependency files
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o api ./server.go

FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/api .

EXPOSE 8080
CMD ["./api"]
