import pandas as pd
import time
from datetime import datetime

def main():
    print("Function 1 started.")
    csv_path = os.path.join(os.path.dirname(__file__), '..', 'shared', 'sample_data.csv')
    df = pd.read_csv(csv_path)

    df['value_squared'] = df['value'] ** 2
    print("Function 1 - DataFrame with squared values:\n", df)

    for i in range(1, 14):
        print(f"Function 1 - Passed {i} min => {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        time.sleep(60)

if __name__ == "__main__":
    main()
