/*This script is written to analysis single cell intensity and background value.
*/

output = "D:/Shuqin/Clover/Microscopy/20190916/Analysis/Mask/"

//get two channels images
title=getTitle();
run("Duplicate...", "duplicate channels=3");
DAPI=getTitle();
selectWindow(title);
run("Duplicate...", "duplicate channels=2");
FITC=getTitle();
selectWindow(title);
close();
selectWindow(DAPI);

//Clear MicroManager
 roiManager("reset");

//Operate on Duplicate
run("Duplicate...", "duplicate channels=1");

//Filter
run("Bandpass Filter...", "filter_large=10 filter_small=3 suppress=None tolerance=5 autoscale saturate");

//Threshold
run("Threshold...");
setThreshold(27700, 65535);

//Ask User to reposition ROI
waitForUser("Are you happy with the Threshold?", "Please select the desired range and then click OK" )

//Make a Binary Mask
run("Convert to Mask");

//Fill Holes
run("Fill Holes");

//Watershed
run("Watershed");

//Prepare to Analyse Particles
run("Set Measurements...", "area mean min shape median display add redirect=["+DAPI+"] decimal=4");

//Analyse Particles
run("Analyze Particles...", "size=80-700 circularity=0.50-1.00 show=[Overlay Masks] display exclude summarize add");
run("Summarize");
close()

selectWindow("Results")
resultsname = replace(DAPI, ".tif", "_DAPI_Results.csv");
saveAs("Results", output+resultsname);
run("Close")

//calculate FITC channel
selectWindow(FITC)
run("Set Measurements...", "area mean min shape median display add redirect=["+FITC+"] decimal=4");
roiManager("multi-measure append");
run("Summarize");
measure = replace(FITC, ".tif", "_FITC_Results.csv");
saveAs("Results", output+measure);
run("Close");

//generating Mask
run("Select All");
run("Create Mask");
roiManager("fill");

maskname= replace(DAPI, ".tif", "_Mask.tif");
saveAs("Tiff", output+maskname);

//calculate background
selectWindow(maskname)
run("Minimum...", "radius=5");
run("Divide...", "value=255.0000");
imageCalculator("Multiply creat", FITC, maskname);

//measure the background
run("Set Measurements...", "area mean min shape median limit display redirect=None decimal=4");
setThreshold(1, 65535);
roiManager("reset");
run("Measure");
background = replace(FITC, ".tif", "_FITC_background.csv");
saveAs("Results", output+background);
run('Close');
close();
close();
close();


