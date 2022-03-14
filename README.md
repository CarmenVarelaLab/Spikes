# Spikes

Group of matlab Functions for Spike analysis.

General guidelines:  

1.- Do not use analysis code as a black box. Look at the raw data and processed data. 

2.- Use scripts as a starting point. E.g., event detection scripts may require parameters to be adjusted for different brain regions, subjects, etc.


periEvHistogram :  calculate the average peri-event histogram in spikes/sec given the spike times and event times 
 width -- determines the x-axis of the histogram (from - width to  + width)
 bin -- bin size
