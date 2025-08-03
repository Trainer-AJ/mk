import datetime
import logging
import os
import azure.functions as func

COUNTER_FILE = "/tmp/execution_count.txt"

def get_execution_count():
    if os.path.exists(COUNTER_FILE):
        with open(COUNTER_FILE, "r") as f:
            return int(f.read().strip())
    return 0

def increment_execution_count(count):
    with open(COUNTER_FILE, "w") as f:
        f.write(str(count))

def main(mytimer: func.TimerRequest) -> None:
    count = get_execution_count() + 1
    increment_execution_count(count)

    current_time = datetime.datetime.utcnow().isoformat()
    logging.info(f"Function executed at {current_time}. Total executions: {count}")
