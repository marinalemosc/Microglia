// =======================================================
// Macro: Skeleton analysis for IBAClean images
// - Opens all images containing "ROI" and "IBAClean"
// - Applies Skeletonize
// - Runs Analyze Skeleton
// - Saves skeleton image replacing "IBAClean" by "Skeleton"
// - Saves ONLY the "Results" table as CSV
// =======================================================

// Directory containing the images
dir = "C:\\Users\\marin\\Documents\\LabIF\\Analise 4\\Imagens\\Controle\\Idoso - CTRL 1 E 2 - T=0\\";

// Get list of files in directory
list = getFileList(dir);

// Loop through all files
for (i = 0; i < list.length; i++) {

    filename = list[i];

    // Check if file contains "ROI" and "IBAClean" and is a TIFF
    if (indexOf(filename, "ROI") != -1 &&
        indexOf(filename, "IBAClean") != -1 &&
        (endsWith(filename, ".tif") || endsWith(filename, ".tiff"))) {

        print("Processing: " + filename);
        open(dir + filename);
        
        // Open image
        open(dir + filename);
        print("Processing: " + filename);

        // Skeletonize binary image
        run("Skeletonize");

        // Analyze skeleton
        run("Analyze Skeleton (2D/3D)", "prune=none show");

        // Save skeleton image
        skeletonName = replace(filename, "IBAClean", "Skeleton");
        saveAs("Tiff", dir + skeletonName);

        // -----------------------------
        // Save ONLY the "Results" table
        // -----------------------------
        baseName = replace(filename, ".tiff", "");
        baseName = replace(baseName, ".tif", "");
        resultsCSV = replace(baseName, "IBAClean", "Skeleton_results");


        if (isOpen("Results")) {
            selectWindow("Results");
            saveAs("Results", dir + resultsCSV + ".csv");
            close();
        }

        // Close Branch information table if it exists
        if (isOpen("Branch information")) {
            selectWindow("Branch information");
            close();
        }

        // Close skeleton image
        close();
    }
}