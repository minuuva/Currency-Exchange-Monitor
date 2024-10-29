##**🌍 Currency Exchange Rate Monitor 📈**
This project is a Currency Exchange Rate Monitor designed to periodically fetch exchange rates, store them in a MySQL database, and run in a Docker container for portability and ease of deployment. The system utilizes cron jobs to automate the data-fetching process every 6 hours, making it perfect for tracking currency trends over time.

**📁 Project Structure**
fetch_exchange_rates.sh - A shell script responsible for fetching the latest exchange rates using an API and storing them in a MySQL database.
cronjob - A cron job configuration file that defines the schedule to run the fetch_exchange_rates.sh script every 6 hours.
Dockerfile - Defines the Docker image configuration, encapsulating the shell script, required libraries, and cron setup for seamless deployment.
.env (optional) - A file to store sensitive environment variables (like API keys and database credentials) that are passed into the Docker container at runtime.

**🛠️ Getting Started**
Prerequisites
Docker: Install Docker to build and run the container.
MySQL: Set up a MySQL database for storing exchange rate data. Ensure you have database credentials ready.

**🧾 Setup**
Clone this repository:

bash
```
git clone https://github.com/yourusername/currency-exchange-monitor.git
cd currency-exchange-monitor
```

Create a .env file in the project root to securely store your environment variables (or provide them at runtime).

Example .env:
```
API_KEY=your_api_key
DB_USER=your_mysql_username
DB_PASS=your_mysql_password
DB_NAME=exchange_rates_db
Build the Docker image:
```

bash
```
docker build -t exchange-rate-monitor .
```

**🚀 Running the Project**
To run the project in a Docker container, use the following command:

bash
```
docker run --env-file .env exchange-rate-monitor
```
Alternatively, pass in the environment variables directly:

bash
```
docker run -e API_KEY="your_api_key" \
           -e DB_USER="your_mysql_username" \
           -e DB_PASS="your_mysql_password" \
           -e DB_NAME="exchange_rates_db" \
           exchange-rate-monitor
```

**📝 File Descriptions**
`fetch_exchange_rates.sh` 📜
The main shell script that:

Fetches exchange rates from an external API using curl.
Parses JSON data using jq to extract rates for specific currencies.
Inserts the data into MySQL with a timestamp for historical tracking.

**cronjob ⏲️**
Defines the cron job schedule to run the fetch_exchange_rates.sh script every 6 hours. This automates data fetching and storage at regular intervals, ensuring the database is always updated with recent exchange rates.

Example Cron Entry:

bash
```
0 */6 * * * /usr/local/bin/fetch_exchange_rates.sh
```

**Dockerfile 🐳**
The Dockerfile sets up the environment for the project. It:

Uses Alpine Linux as a lightweight base image.
Installs necessary dependencies: bash, curl, jq, and mysql-client.
Copies the fetch_exchange_rates.sh script into the container.
Sets executable permissions for the script.
Configures cron to run the script every 6 hours.
By containerizing the application, the Dockerfile ensures that all dependencies are included and that the project can be deployed consistently across different environments.

**.env (optional) 🔒**
A file to store sensitive environment variables, such as the API key and MySQL credentials, without hardcoding them in the Dockerfile. This file is specified when running the container with --env-file .env.

**📊 How It Works**
Data Fetching: The fetch_exchange_rates.sh script requests data from an exchange rate API every 6 hours.
Data Storage: Each time the script runs, it inserts the latest exchange rates into the MySQL database with a timestamp.
Docker & Cron Automation: Using Docker and cron, the project runs automatically and consistently, making it easy to deploy on any server with Docker support.

**💡 Use Cases**
Currency Analysis: Track exchange rates over time to identify trends.
Financial Applications: Use historical exchange rate data in financial modeling or forecasting.
Automation & Deployment: Deploy as a Docker container for easy automation and management.

**🤝 Contributing**
Contributions are welcome! Feel free to submit issues, fork the repository, and make pull requests.
