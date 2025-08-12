#!/bin/bash
# ubuntu-setup.sh
# Setup script for AI video agent and n8n in WSL2 Ubuntu

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install Docker
echo "Installing Docker..."
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Install FFmpeg
echo "Installing FFmpeg..."
sudo apt-get install -y ffmpeg

# Run n8n in Docker
echo "Starting n8n..."
docker run -d --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n n8nio/n8n

# Download n8n workflow
echo "Downloading n8n workflow..."
wget https://raw.githubusercontent.com/vinodioo/installer/main/n8n-workflow.json

# Placeholder: Import workflow into n8n (manual step or API needed)
echo "n8n workflow downloaded to ~/n8n-workflow.json. To import, access n8n at http://localhost:5678 and upload manually, or configure via n8n API."

# Placeholder: Install AI models
# Update with specific models (e.g., ElevenLabs, LLaMA) based on your input
echo "AI model installation placeholder. Specify models for customization."

# Configure n8n to start on boot
echo "Configuring n8n to start on boot..."
sudo bash -c 'echo "docker start n8n" >> /etc/rc.local'

echo "Setup complete! Access n8n at http://localhost:5678"
echo "To check Docker status, run: docker ps"
echo "To view n8n logs, run: docker logs n8n"
