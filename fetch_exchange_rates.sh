#!/bin/bash

# Define API endpoint and parameters
API_URL="http://api.exchangeratesapi.io/v1/latest"  # Base URL for ExchangeRatesAPI
API_KEY="replace_with_your_actual_API_KEY"          # Replace with your actual API key
TARGET_CURRENCIES="USD,AUD,CAD,PLN,MXN"             # Specify target currencies

# MySQL credentials
DB_USER="replace_with_your_actual_username"
DB_PASS="replace_with_your_actual_password"
DB_NAME="exchange_rates_db"

# Fetch exchange rates using curl
response=$(curl -s "${API_URL}?access_key=${API_KEY}&symbols=${TARGET_CURRENCIES}")

# Check for errors
if [[ $? -ne 0 ]]; then
  echo "Failed to fetch data from API."
  exit 1
fi

# Parse JSON and check if the response was successful
success=$(echo "$response" | jq '.success')
if [[ "$success" != "true" ]]; then
  echo "API request unsuccessful. Response: $response"
  exit 1
fi

# Extract relevant fields from the JSON response
timestamp=$(echo "$response" | jq '.timestamp')
usd=$(echo "$response" | jq '.rates.USD')
aud=$(echo "$response" | jq '.rates.AUD')
cad=$(echo "$response" | jq '.rates.CAD')
pln=$(echo "$response" | jq '.rates.PLN')
mxn=$(echo "$response" | jq '.rates.MXN')

# Ensure all data is available before inserting into MySQL
if [[ -n "$timestamp" && -n "$usd" && -n "$aud" && -n "$cad" && -n "$pln" && -n "$mxn" ]]; then
  # Insert data into MySQL database
  mysql -u $DB_USER -p$DB_PASS $DB_NAME <<EOF
  INSERT INTO exchange_rates (timestamp, usd_rate, aud_rate, cad_rate, pln_rate, mxn_rate)
  VALUES ($timestamp, $usd, $aud, $cad, $pln, $mxn);
EOF
  echo "Data inserted into MySQL database"
else
  echo "Incomplete data received. Not logging to database."
fi

