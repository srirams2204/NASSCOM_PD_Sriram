# NASSCOM_PD_Sriram

## Table of Contents
- [Overview](#overview)
- [Prerequisite](#Prerequisite)
- [Introduction](#Introduction)
- [Day - 1 Inception of Open-Source EDA, OpenLane and Sky130 PDK](#day---1-inception-of-open-source-eda-openlane-and-sky130-pdk)
- [Day - 2 Good Floor plan Vs Bad floorplan & intro to Library Cells](#day---2-good-floorplan-vs-bad-floorplan-and-introduction-to-library-cells)
- [Day - 3 Design Library Cells using Magic Layout and Ngspice Characterization](#day--3-design-library-cell-using-magic-layout-and-ngspice-charcterization)
- [Day - 4 Pre-Layout Timing Analysis and Importance of good Clock Tree](#day-4-pre-layout-timing-analysis-and-importance-of-good-clock-tree)
- [Day - 5 Final Steps in RTL2GDS using tritonRoute and openSTA](#day-5--final-steps-in-rtl2gds-using-tritonroute-and-opensta)
- [Acknowledgement](#acknowledgement)
- [References](#references)

## Overview
This repository documents the Digital VLSI SoC Design and Planning course, a two-week program conducted by VSD-IAT. The course focuses on advanced physical design using open-source EDA tools like OpenLANE and the Sky130 PDK. In this workshop VSD provides overall training through interactive tutorials on the fundamentals of physical design as well as in hand experience on the use of the openLANE/sky130 flow.
The course covers OpenLANE, an automated RTL-to-GDSII flow that integrates various open-source tools like OpenROAD, Yosys, Magic, Netgen, NGspice, and OpenSTA. It enables a complete ASIC implementation process, from RTL to GDSII.

OpenLane Github Repository - https://github.com/efabless/openlane

## Prerequisite
The only requirement for the workshop is a registered email ID. VSD-IAT is a well-designed cloud training platform with no time zone restrictions. The workshop is structured to help participants freely use open-source tools for their own designs even after it ends.
However, for a local use of the open source tools a set of instructions are to be followed for proper installation of all required tools. The basic requirement is a linux-based operating system, preferably the Ubuntu OS as it is user friendly compared to other linux distributions. The minimum space to setup the Ubuntu OS is 20GB but i would recommend alloting a minimimum of 80GB to install all the open source tools and dependencies for them.

After setting up the Ubuntu OS, the necessary dependencies must be installed before proceeding with the installation of the EDA tools. 
To install the dependencies run the command :
```bash
chmod +x openEDA_dependencies.sh
./openEDA_dependencies.sh
```
