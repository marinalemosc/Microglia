// =======================================================
// Macro: Analyze Particles on IBAClean and DAPIClean ROIs
// Exports separate CSVs for IBA and DAPI
// =======================================================

// Directory containing the images
dir = "C:\\Users\\marin\\Documents\\LabIF\\Analise 4\\Imagens\\Controle\\Idoso - CTRL 1 E 2 - T=0\\";

// Get list of files
list = getFileList(dir);

// Loop through all files
for (i = 0; i < list.length; i++) {

    filename = list[i];

    // Process IBAClean images
    if (indexOf(filename, "ROI") != -1 &&
        indexOf(filename, "IBAClean") != -1 &&
        (endsWith(filename, ".tif") || endsWith(filename, ".tiff"))) {

        processParticles(dir, filename, "IBAClean", "IBAParticle_results");
    }

    // Process DAPIClean images
    if (indexOf(filename, "ROI") != -1 &&
        indexOf(filename, "DAPIClean") != -1 &&
        (endsWith(filename, ".tif") || endsWith(filename, ".tiff"))) {

        processParticles(dir, filename, "DAPIClean", "DAPIParticle_results");
    }
}

// =======================================================
// Creating a function for Analyze Particles and save CSV
// =======================================================
function processParticles(dir, filename, inputTag, outputTag) {

    print("Processing: " + filename);
    open(dir + filename);

    // Clear previous Results table
    if (isOpen("Results")) {
        selectWindow("Results");
        run("Clear Results");
    }

    // Reset ROI Manager
    if (roiManager("count") > 0) {
        roiManager("Reset");
    }

    // Run Analyze Particles
    run("Analyze Particles...",
        "size=0-Infinity circularity=0.00-1.00 show=Nothing display add");

    // Build CSV filename
    csvName = replace(filename, inputTag, outputTag);
    csvName = replace(csvName, ".tif", ".csv");

    // Save Results table
    if (isOpen("Results")) {
        selectWindow("Results");
        saveAs("Results", dir + csvName);
    }

    // Close all windows without saving
    run("Close All");
}

