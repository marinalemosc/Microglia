// =======================================================
// Macro: Save cleaned binary images as "Clean"
// =======================================================

// Get the directory associated with the file
        dir = getDirectory("current");
        
// Ask for image name 
imageName = getString("Image name (with ROI, without sufix)", "GH 1 E 2 2 - T=0 C=2 ROI");

// Build expected filenames for input
dapiBinary = imageName + " DAPIBinary.tif";
ibaBinary  = imageName + " IBABinary.tif";

// Build new names for saving
dapiClean = replace(dapiBinary, "DAPIBinary", "DAPIClean");
ibaClean  = replace(ibaBinary, "IBABinary", "IBAClean");

//Save DAPI image
    selectWindow(dapiBinary);
    saveAs("Tiff", dir + dapiClean);

//Save IBA image
	selectWindow(ibaBinary);
    saveAs("Tiff", dir + ibaClean);

// Macro to close all open images
run("Close All");
