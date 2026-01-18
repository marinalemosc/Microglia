// =======================================================
// Macro: Analyze Particles on IBAClean ROIs and export CSV
// =======================================================

// Directory containing the images
dir = "C:\\Users\\marin\\Documents\\LabIF\\Analise 4\\Imagens\\Controle\\Idoso - CTRL 1 E - T=0\\";

// Get list of files
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
        
     
        // Clear previous results and ROI Manager
        if (isOpen("Results")) {
            selectWindow("Results");
            run("Clear Results");
        }

        if (roiManager("count") > 0) {
            roiManager("Reset");
        }

        // Run Analyze Particles
        run("Analyze Particles...", 
    "size=0-Infinity circularity=0.00-1.00 show=Nothing display add");

        // Build CSV filename
        csvName = replace(filename, "IBAClean", "Particle_results");
        csvName = replace(csvName, ".tif", ".csv");

        // Save Results table
        if (isOpen("Results")) {
            selectWindow("Results");
            saveAs("Results", dir + csvName);
        }

        // Close all windows without saving
        run("Close All");
    }
}
