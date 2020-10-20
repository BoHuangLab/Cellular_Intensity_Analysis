## ImageJ-macro-for-cellular-intensity-analysis
### Introduction
These macros were generated to analyze overall intensity of each cell from fluorescent images in Fiji or ImageJ.
The parameters here were setted for 10x images, and can be modified to suit your needs. Image example was taken:channel1_BF,channel2_FITC, channel3_DAPI. In both fluorescent channel, nuclears were labeled.


### Requirements
1. ImageJ macros need to install ImageJ or Fiji.
2. python scripts need to install python pandas, numpy, matplotlib, scipy packages

### Setup
1. Download macros
2. Open "nuclear and background.ijm" and edit the output file location to your computer. Better to readthrough the script.
3. Put the "nuclear and background.ijm" into fiji's macro location, for example
>C:\Program Files\Fiji.app\macros
4. Open "batch analysis" in Fiji, and run macro, then you can choose the file folder you want to analyze.
5. Adjust the parameters till you feel happy.
6. After analyze images, all intermediate results were saved, intensity of cells was saved in csv file. 
7. Use python script "mNG_Intensity_distribution_plot" to open csv file and analyze or plot Intensity. And use "Median_Intensity_plot_and_statistical_tests" to plot Median Intensity and perform their statistical test. 
