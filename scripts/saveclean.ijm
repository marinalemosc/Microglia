// =======================================================
// Macro: Save manually cleaned binary images as "Clean"
// =======================================================

// Define base directory
dir = "C:\\Users\\marin\\Documents\\LabIF\\Analise 4\\Imagens\\Controle\\Idoso - CTRL 1 E - T=0\\";

// Define ROI number (change this value when needed)
roiNumber = 1;
roiString = "ROI" + roiNumber;

// Build expected filenames for input
dapiBinary = "Idoso - CTRL 1 E - T=0 C=2 " + roiString + " DAPIBinary.tif";
ibaBinary  = "Idoso - CTRL 1 E - T=0 C=2 " + roiString + " IBABinary.tif";

// Build new names for saving
dapiClean = replace(dapiBinary, "DAPIBinary", "DAPIClean");
ibaClean  = replace(ibaBinary, "IBABinary", "IBAClean");

//Save DAPI image
    selectWindow(dapiBinary);
    saveAs("Tiff", dir + dapiClean);

//Save IBA image
	selectWindow(ibaBinary);
    saveAs("Tiff", dir + ibaClean);
