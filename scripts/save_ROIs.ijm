// =======================================================
// Macro: Save and close all ROI images in the original directory
// Only images containing "ROI" in the title will be processed
// =======================================================

// List all currently open images
titles = getList("image.titles");

// Loop through all open images
for (i = 0; i < titles.length; i++) {

    selectWindow(titles[i]);

    // Check if the file name contains "ROI"
    if (indexOf(titles[i], "ROI") >= 0) {

        // Get the directory associated with the file
        dir = getDirectory("current");

        // Full save path keeping the same filename
        savePath = dir + titles[i];

        // Save as TIFF
        saveAs("Tiff", savePath);

        // Print confirmation
        print("Saved and closed: " + savePath);

        // Close the ROI window
        close();
    }
}

// =======================================================
// End of macro
// =======================================================
