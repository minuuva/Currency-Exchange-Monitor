# Use an official lightweight image as the base
FROM alpine:latest

# Install necessary packages
RUN apk update && \
    apk add --no-cache bash curl jq mysql-client

# Set environment variables for API and MySQL credentials (to be overridden at runtime)
ENV API_URL="http://api.exchangeratesapi.io/v1/latest"
ENV API_KEY=""
ENV TARGET_CURRENCIES="USD,AUD,CAD,PLN,MXN"
ENV DB_USER=""
ENV DB_PASS=""
ENV DB_NAME="exchange_rates_db"

# Copy the fetch_exchange_rates.sh script into the container
COPY fetch_exchange_rates.sh /usr/local/bin/fetch_exchange_rates.sh

# Make the script executable
RUN chmod +x /usr/local/bin/fetch_exchange_rates.sh

# Run the script (optional)
CMD ["/usr/local/bin/fetch_exchange_rates.sh"]

