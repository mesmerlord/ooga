# Use the official NVIDIA CUDA base image
FROM nvidia/cuda:11.1.1-cudnn8-runtime-ubuntu20.04

# Set the working directory
WORKDIR /app

# Install Python and other required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.8 \
    python3-pip \
    python3.8-dev \
    git && \
    rm -rf /var/lib/apt/lists/*

# Update pip
RUN python3.8 -m pip install --upgrade pip

# Copy requirements.txt into the container
COPY requirements.txt ./

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt
# RUN pip install --no-cache-dir -r google_translate_requirements.txt
# RUN pip install --no-cache-dir -r silero_tts_requirements.txt

# Copy the rest of the application code
COPY . .

# Create a volume for the model files
VOLUME /app/models

RUN python3.8 download-model.py chavinlo/gpt4-x-alpaca

# Expose the port the app will run on
EXPOSE 7860

# Start the application
CMD ["python3.8", "server.py", "--auto-devices", "--cai-chat"]
