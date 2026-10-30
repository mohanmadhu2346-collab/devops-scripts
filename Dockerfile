FROM alpine:3.19

RUN apk add --no-cache bash curl jq

WORKDIR /app

COPY inspect_cluster.sh parse_services.sh log_splitter.sh service_checker.sh targets.txt ./

RUN chmod +x *.sh

ENTRYPOINT ["/bin/bash"]
CMD ["inspect_cluster.sh", "production"]
