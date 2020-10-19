/*This script is written to analysis single cell intensity value in low magnitute image. It needs to be put in C:\Program Files\Fiji.app\macros to enable batch analysis
*/

output = "C:/WorkStudy/mNG_Clover_paper/20200512_sample threshold/no_fft/"

//subtract background and duplicate images
title=getTitle();
run("Subtract Background...", "rolling=20 sliding disable");
run("Duplicate...", " ");
title2 =getTitle();
selectWindow(title);
//adjust contrast
setMinAndMax(0,300);

//Clear MicroManager
roiManager("reset");
selectWindow(title2);
//Filter to enhance cell edges for better segmentation
run("Bandpass Filter...", "filter_large=20 filter_small=5 suppress=None tolerance=5 autoscale saturate");

//Threshold
run("Threshold...");
setThreshold(200, 65535);

//Ask User to adjust threshold to get perfect cell segmentation
waitForUser("Are you happy with cell Threshold?", "Please select the desired range and then click OK" )

//Make a Binary Mask
run("Convert to Mask");
run("Watershed");

//Analyse Particles value in the original image
run("Set Measurements...", "area mean min shape median display add redirect=["+title+"] decimal=4");

//Analyse Particles value of certain size and circularity
run("Analyze Particles...", "size=80-2000 circularity=0.10-1.00 show=[Overlay Masks] display exclude summarize add");
run("Summarize");
close()

//save result
selectWindow("Results")
resultsname = replace(title, ".tif", "_Results.csv");
saveAs("Results", output+resultsname);
run("Close");

//generating Mask
run("Select All");
run("Create Mask");
roiManager("fill");

//save mask
maskname= replace(title, ".tif", "_Mask.tif");
saveAs("Tiff", output+maskname);

//save ROI
ROIname= replace(title, ".tif", "Roi.zip");
roiManager("Save", output+ROIname);
run("Close");
run("Close");

//clear threshold
selectWindow("Threshold");
run("Close");

