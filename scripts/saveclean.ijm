// =======================================================
// Macro: Save cleaned binary images as "Clean"
// =======================================================

// Get the directory associated with the file
        dir = getDirectory("current");
        
// Define ROI number (change this value when needed!!!)
roiNumber = getNumber("ROI", "ROIX");
roiString = "ROI" + roiNumber;

// Build expected filenames for input
dapiBinary = "Jovem 1 E 2 - T=0 C=2 " + roiString + " DAPIBinary.tif";
ibaBinary  = "Jovem 1 E 2 - T=0 C=2 " + roiString + " IBABinary.tif";

// Build new names for saving
dapiClean = replace(dapiBinary, "DAPIBinary", "DAPIClean");
ibaClean  = replace(ibaBinary, "IBABinary", "IBAClean");

//Save DAPI image
    selectWindow(dapiBinary);
    saveAs("Tiff", dir + dapiClean);

//Save IBA image
	selectWindow(ibaBinary);
    saveAs("Tiff", dir + ibaClean);
