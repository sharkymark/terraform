# Define the argument before its first use
FROM python:3.13-slim

# get ps utility in the container
RUN apt-get update && apt-get install -y procps curl net-tools htop ssh git bzip2

# Set working directory
WORKDIR /app

# Copy application code
COPY . /app/

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available
EXPOSE 5000

# Set Flask environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Run the application
CMD ["flask", "run"]


