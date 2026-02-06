from pathlib import Path
from tkinter import filedialog
import tkinter as tk
import pandas as pd

# Ask user to select csv 
root = tk.Tk()
root.withdraw()

csv_path = filedialog.askopenfilename(
    title="Select allROI CSV file",
    filetypes=[("CSV files", "*.csv")]
)

raw_df = pd.read_csv(csv_path)

# Create a new Dataframe for processing data 
processed_df = raw_df.copy()

# Change ROI column name to "Image Name"
processed_df = processed_df.rename(columns={"ROI": "Image Name"})

# Creating a column "ROI Name" to standardize filenames for regex parsing
processed_df["ROI Name"] = (
    processed_df["Image Name"]
        .str.replace("- CTRL ", "", regex=False)
        .str.replace("- T=0 C=2 ", "", regex=False)
)

# Extract data from ROI Name column  
pattern = (
    r"(?P<group>Jovem|Idoso|GH)\s+"
    r"(?P<mouse_id>\d+)\s+"
    r"(?P<section>[EMI])\s+"
    r"(?:(?P<image_raw>\d+(?:\s+\d+)*)\s+)?"
    r"(?P<ROI>ROI\d+)"
)

# Create df from pattern 
parsed = processed_df["ROI Name"].str.extract(pattern)

# Merge both df 
processed_df = pd.concat([processed_df, parsed], axis=1)


# Function to create a normalized image index per group, mouse, and section
def normalize_image_index(df):
    df = df.copy()
    df["image_raw"] = df["image_raw"].fillna("")
    df["image_idx"] = (
        df.groupby(["group", "mouse_id", "section"])["image_raw"]
         .transform(lambda s: pd.factorize(s, sort=False)[0] + 1)
         )
    return df

# Normalize processed_df 
processed_df = normalize_image_index(processed_df)

# Rearranging the columns for clear understanding 
ordered_cols = ["ROI Name","group","mouse_id","section","image_idx","ROI","image_raw","Image Name",]

processed_df = processed_df.reindex(
    columns=ordered_cols + [c for c in processed_df.columns if c not in ordered_cols]
)


# Output file 
output_path = Path(csv_path).with_name("processed_results.csv")
processed_df.to_csv(output_path, index=False)
