from pathlib import Path
from tkinter import filedialog
import tkinter as tk
import pandas as pd


# Ask user to select csv 
root = tk.Tk()
root.withdraw()

csv_path = filedialog.askopenfilename(
    title="Select processed CSV file",
    filetypes=[("CSV files", "*.csv")]
)

raw_df = pd.read_csv(csv_path)

# Create a new Dataframe for cleaned data 
cleaned_df = raw_df.copy()

# Create function for removing columns that were all not calculated 
def keep_calculated(df):
    df = df.copy()
    for col in df.columns:
        if df[col].eq("Not Calculated").all():
            df = df.drop(columns=col)
    return df

# Runs keep_calculated 
cleaned_df = keep_calculated(cleaned_df)

# Replacing "Not Calculated" strings for NaN 
cleaned_df = cleaned_df.replace(
    to_replace=r"(?i)^Not Calculated$",
    value=pd.NA,
    regex=True
)

# Create dataframe with missing value proportion per column
cleaned_report = (
    cleaned_df.isna()
    .mean()
    .reset_index()
)

# Output files
output_path = Path(csv_path).with_name("cleaned_results.csv")
cleaned_df.to_csv(output_path, index=False)

output_path2 = Path(csv_path).with_name("cleaned_report.csv")
cleaned_report.to_csv(output_path2, index=False)