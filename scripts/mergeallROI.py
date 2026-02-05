from pathlib import Path
from tkinter import filedialog
import tkinter as tk
import pandas as pd

# Ask user to select base directory
root = tk.Tk()
root.withdraw()
DATA_DIR = Path(filedialog.askdirectory())

# Find all CSVs ending with Results_byROI.csv recursively
csv_files = list(DATA_DIR.rglob("*Results_byROI.csv"))
if not csv_files:
    raise FileNotFoundError("No Results_byROI.csv files found in selected directory")

# Create DataFrame with all the results found 
dfs = []
for file in csv_files:
    df = pd.read_csv(file)

    # Add source folder name row
    df["source_folder"] = file.parent.name
   
    dfs.append(df)

# Merge all tables
final_df = pd.concat(dfs, ignore_index=True)

# Save output
output_path = DATA_DIR / "allROI_results.csv"
final_df.to_csv(output_path, index=False)

print(f"Merged file saved at:\n{output_path}")