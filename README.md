# EHTcontraction_analysis

### This is a quick and dirty way of analyzing the contraction of the engineered heart tissue (EHT). Contraction of the EHT leads to changes in the area of the inner sphere. The code tries to track the area of the inner sphere over time. Then some of the metrics (max contraction amplitude, max contraction speed, max relaxation speed) can be calculated to quantify the contraction of the EHT.

### The key is to correctly set the binarization threshold (line 45 in extraccting_area.m) and imclose parameter (line 52 in extraccting_area.m).

### The code is developed in matlab 2023b with image processing toolbox/computer vision toolbox and signal processing toolbox.

![](https://github.com/rkdeng/EHTcontraction_analysis/blob/main/png1.png)
![](https://github.com/rkdeng/EHTcontraction_analysis/blob/main/png2.png)
