FROM golang:1.23.4 AS build-stage

# Set environment variable for private repositories

# Set environment variable for private repositories
ENV GOPRIVATE=github.com/motiong-io

# Configure Git to use SSH
RUN apt-get update && apt-get install -y openssh-client && \
    git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"

# Add GitHub's SSH key to known_hosts
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh && \
    ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts

# Work directory and app setup
WORKDIR /app
COPY . .

# Fetch private modules and build the application
RUN --mount=type=ssh \
    go mod tidy && \
    go build -o main main.go
# Run the tests in the container
# FROM build-stage AS run-test-stage
# RUN go test -v ./...

# Deploy the application binary into a lean image
FROM ubuntu:latest

WORKDIR /

COPY --from=build-stage /app/main /

EXPOSE 8000

ENTRYPOINT ["./main"]