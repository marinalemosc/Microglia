// =======================================================
// Macro: Open all images for a specific ROI
// =======================================================

// Ask for directory containing the images
Dir = getDirectory("Choose directory");

// Define ROI number to open (change this number to open another ROI)
roiNumber = getNumber("ROI", "ROIX");
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
  
