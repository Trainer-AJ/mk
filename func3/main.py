import datetime
import logging
import time
import os
import azure.functions as func  # ✅ This import is required

def main(mytimer: func.TimerRequest) -> None:
    utc_timestamp = datetime.datetime.utcnow().replace(tzinfo=datetime.timezone.utc).isoformat()
    logging.info(f"Function triggered at {utc_timestamp}")

    # Read and print contents of the file
    file_path = os.path.join("shared", "azure_resources.txt")
    try:
        with open(file_path, "r") as file:
            resources = file.read()
            logging.info("Contents of azure_resources.txt:")
            logging.info(resources)
    except Exception as e:
        logging.error(f"Error reading file: {e}")

    # Run for 25 minutes, printing every minute
    start_time = datetime.datetime.now()
    end_time = start_time + datetime.timedelta(minutes=25)

    while datetime.datetime.now() < end_time:
        current_minute = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        logging.info(f"Running at minute: {current_minute}")
        time.sleep(60)
