# Use a lightweight, secure base image
FROM alpine:3.19

# Install core runtime dependencies (bash, curl, jq)
RUN apk add --no-cache bash curl jq

# Set the working directory inside the container
WORKDIR /app

# Copy scripts and configuration into the container image
COPY inspect_cluster.sh parse_services.sh log_splitter.sh service_checker.sh targets.txt ./

# Ensure all scripts are executable
RUN chmod +x *.sh

# Default command executed when the container starts
ENTRYPOINT ["/bin/bash"]
CMD ["inspect_cluster.sh", "production"]
