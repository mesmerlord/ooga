#!/bin/bash

# Download the model
python3.8 download-model.py chavinlo/gpt4-x-alpaca

# Start the application
exec python3.8 server.py --auto-devices --cai-chat
