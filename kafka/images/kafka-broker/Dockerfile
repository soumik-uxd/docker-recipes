FROM kafka-base:latest

# Start broker
COPY *.sh .
RUN chmod +x ./*.sh
ENTRYPOINT ["./entrypoint.sh"]
