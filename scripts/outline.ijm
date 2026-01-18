// =======================================================
// Macro: Turning IBAClean microglia in outlines
// =======================================================

// Directory containing IBAClean images
dir = "C:\\Users\\marin\\Documents\\LabIF\\Analise 4\\Imagens\\Controle\\Idoso - CTRL 1 E - T=0\\";

// Get list of files
list = getFileList(dir);

// Loop through all files
for (i = 0; i < list.length; i++) {

    filename = list[i];

    // Process only IBAClean images
    if (indexOf(filename, "IBAClean") != -1 &&
        (endsWith(filename, ".tif") || endsWith(filename, ".tiff"))) {

        print("Processing FracLac for: " + filename);

        // -----------------------------
        // Open image
        // -----------------------------
        open(dir + filename);

        // -----------------------------
        // Convert to outline
        // -----------------------------
        run("Outline");

        // Save outline image
        outlineName = replace(filename, "IBAClean", "Outline");
        saveAs("Tiff", dir + outlineName);
        
          // -----------------------------
        // Close all windows
        // -----------------------------
        run("Close All");
    }
}