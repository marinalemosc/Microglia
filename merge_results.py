# Script for merge CSV results from ImageJ analysis 

import pandas as pd
import os
import re

# Directory containing all CSV result files
DATA_DIR = r"C:\Users\marin\Documents\LabIF\Analise 4\Imagens\Controle\Idoso - CTRL 1 E 2 - T=0"


# Name of the final merged output file
OUTPUT_FILE = "Results_byROI.csv"

# Regular expression used to extract the ROI identifier
# Example matched string:
# "Idoso - CTRL 1 E - T=0 C=2 ROI1"
ROI_PATTERN = r"(Idoso\s-\sCTRL\s1\sE\s-\sT=0\sC=2\sROI\d+)"

# =====================================================
# MAIN PROCESSING
# =====================================================

# Dictionary that will store one merged DataFrame per ROI
roi_tables = {}

# Iterate over all files in the directory
for file in os.listdir(DATA_DIR):

    # Process only CSV files
    if not file.lower().endswith(".csv"):
        continue

    # Extract ROI name from the filename using regex
    match = re.search(ROI_PATTERN, file)

    # If ROI pattern is not found, skip the file
    if not match:
        print(f"ROI not recognized in filename: {file}")
        continue

    roi_name = match.group(1)
    file_path = os.path.join(DATA_DIR, file)

    # Read CSV file into a DataFrame
    df = pd.read_csv(file_path)
    # Force a simple numeric index to avoid MultiIndex issues
    df = df.reset_index(drop=True)

    # ImageJ / FracLac summary tables should have one row only
    # If more than one row exists, keep the first one and warn the user
    if len(df) != 1:
        print(f" {file} has multiple rows — using the first row only")
        df = df.iloc[[0]]

    # Determine result type from the filename
    # Example:
    # " FracLac", " Particle", " Skeleton"
    result_type = file.replace(roi_name, "").replace(".csv", "").strip()
    result_type = result_type.replace("_results", "").strip() 

    # Prefix column names to avoid name collisions after merging
    # Example:
    # Area -> Particle_Area
    df = df.add_prefix(result_type + "_")

    # Merge results belonging to the same ROI
    if roi_name in roi_tables:
        roi_tables[roi_name] = pd.concat([roi_tables[roi_name], df], axis=1)
    else:
        roi_tables[roi_name] = df

# =====================================================
# FINAL MERGE (ALL ROIs)
# =====================================================

# Combine all ROIs into a single DataFrame
# Each row corresponds to one ROI
final_df = pd.concat(
    [df.assign(ROI=roi) for roi, df in roi_tables.items()],
    ignore_index=True
)

# Move the ROI column to the first position
columns_order = ["ROI"] + [col for col in final_df.columns if col != "ROI"]
final_df = final_df[columns_order]

# =====================================================
# SAVE OUTPUT
# =====================================================

# Full path to output file
output_path = os.path.join(DATA_DIR, OUTPUT_FILE)

# Save the merged DataFrame as CSV
final_df.to_csv(output_path, index=False)

print(f" Final merged CSV saved at:\n{output_path}")
