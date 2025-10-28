// =======================================================
// Macro: Open all images for a specific ROI
// =======================================================

// Define folder path
dir = "C:\\Users\\marin\\Documents\\LabIF\\Analise 4\\Imagens\\Controle\\Idoso - CTRL 1 E - T=0\\";

// Define ROI number to open (change this number to open another ROI)
roiNumber = 1;  // e.g., ROI1
roiString = "ROI" + roiNumber;

// Build filenames
mergedFile = dir + "Idoso - CTRL 1 E - T=0 C=2 " + roiString + ".tif";
ibaFile    = dir + "Idoso - CTRL 1 E - T=0 C=2 " + roiString + " IBABinary.tif";
dapiFile   = dir + "Idoso - CTRL 1 E - T=0 C=2 " + roiString + " DAPIBinary.tif";

// Open merged image
    open(mergedFile);

// Open IBA binary image
    open(ibaFile);
   
// Open DAPI binary image
    open(dapiFile);
  
