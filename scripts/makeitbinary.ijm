// =======================================================
// Macro: Preprocessing and Binarization for overlapped images
// - Opens each file in the input folder that contains "C=2"
// - Applies Unsharp Mask, split the collor channels, makes binary,
//   performs morphological Close and removes outliers (bright and dark)
// - Saves result with "_Binary.tif" appended to the original base name
// - Closes the processed image
// =======================================================

dir = "C:\\Users\\marin\\Documents\\LabIF\\Analise 4\\Imagens\\Jovem\\Jovem 1 E 2 - T=0\\";

// Get file list
list = getFileList(dir);

// Loop through files
for (i = 0; i < list.length; i++) {

    filename = list[i];

    // Check if name contains "C=2" and ends with tif or tiff
    if (indexOf(filename, "C=2") != -1 && 
        (endsWith(filename, ".tif") || endsWith(filename, ".tiff"))) {

        open(dir + filename);
        print("Opening: " + filename);
        
        // Apply Unsharp Mask
        run("Unsharp Mask...", "radius=3 mask=0.6");
        
        // Split channels
        run("Split Channels");
        
        // Select red channel (IBA)
        selectWindow(filename + " (red)");

        // Convert to Binary
        run("Make Binary");
        
        // Morphological Close (Binary > Close)
        run("Close-"); 

        // Remove bright outliers
        run("Remove Outliers...", "radius=0.1 threshold=50 which=Bright");

        // Remove dark outliers
        run("Remove Outliers...", "radius=2 threshold=50 which=Dark");

        // Save with new suffix
        newNameR = replace(filename, ".tif", " IBABinary.tif");
        saveAs("Tiff", dir + newNameR);
        
        // Select red channel (DAPI)
        selectWindow(filename + " (blue)");

        
        // Convert to Binary
        run("Make Binary");
        
        // Morphological Close (Binary > Close) 
        run("Close-"); 

        // Remove bright outliers
        run("Remove Outliers...", "radius=2.0 threshold=50 which=Bright");
        
        // Save with new suffix
        newNameB = replace(filename, ".tif", " DAPIBinary.tif");
        saveAs("Tiff", dir + newNameB);
        
   }
}