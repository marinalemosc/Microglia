// =======================================================
// Macro: Merge DAPI + IBA images and save as RGB colored
// =======================================================

// Define the input directory containing the paired images
inputDir = "C:\\Users\\marin\\Documents\\LabIF\\Analise 4\\Imagens\\IdosoGH\\";
list = getFileList(inputDir);

// Loop through all files
for (i=0; i<list.length; i++) {

    // Only process files ending in C=1 (IBA1 channel)
    if (endsWith(list[i], "C=1.tif")) {

        ibaFile = list[i];                             // IBA1 file
        dapiFile = replace(ibaFile, "C=1", "C=0");     // Expected DAPI pair

        // Check if the DAPI file exists
        if (!File.exists(inputDir + dapiFile)) {
            print("Pair not found for: " + ibaFile);
            continue;
        }

        // Open DAPI and rename the window to a simple title
        open(inputDir + dapiFile);
        rename("DAPI");

        // Open IBA1 and rename the window
        open(inputDir + ibaFile);
        rename("IBA");

        // Merge channels: IBA → RED | DAPI → BLUE
        run("Merge Channels...", "red=IBA blue=DAPI create");

        // Convert the result to RGB to keep real color when saving
        run("Make Composite", "display=Composite");
        run("Stack to RGB");

        // Create output name replacing C=1 by C=2
        outputName = replace(ibaFile, "C=1", "C=2");

        // Save as colored Tiff
        saveAs("Tiff", inputDir + outputName);

        // Close all windows to clean workspace
        close("*");
    }
}

// End of script
// =======================================================
