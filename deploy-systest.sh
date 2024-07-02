#!/bin/bash

# Pull the latest code
git pull origin main

# Build and deploy your application (e.g., using Docker Compose)
docker-compose -f docker-compose.systest.yml up -d
