import pandas as pd
import time
from datetime import datetime

def main():
    print("Function 2 started.")
    csv_path = os.path.join(os.path.dirname(__file__), '..', 'shared', 'sample_data.csv')
    df = pd.read_csv(csv_path)

    df_filtered = df[df['value'] > 250]
    print("Function 2 - Filtered DataFrame:\n", df_filtered)

    for i in range(1, 14):
        print(f"Function 2 - Passed {i} min => {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        time.sleep(60)

if __name__ == "__main__":
    main()
