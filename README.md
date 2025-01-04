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
### Enable execution permission
Before running a shell script, ensure that it has the appropriate permissions to be executed.
```bash
chmod +x openEDA_dependencies.sh
```
### Execution of Shell script 
Run the shell script to install the dependencies.
```bash
./openEDA_dependencies.sh
```

## Introduction
The RTL-to-GDSII flow is a complete digital ASIC design process that converts a high-level hardware description (RTL) into a final layout (GDSII) ready for fabrication. OpenLANE, an open-source automated flow, simplifies this process by integrating multiple tools for synthesis, floorplanning, placement, clock tree synthesis, routing, and signoff verification.

The Sky130 PDK (Process Design Kit) is an open-source 130nm technology node provided by SkyWater Technology, allowing designers to implement real-world silicon designs without proprietary restrictions. OpenLANE leverages several powerful open-source tools, including Yosys for logic synthesis, OpenROAD for physical design automation, Magic for layout visualization, Netgen for LVS (Layout vs. Schematic) verification, OpenSTA for static timing analysis, and NGspice for circuit simulation.

This open-source RTL-to-GDSII flow enables designers, researchers, and students to create and optimize ASIC designs efficiently, making custom silicon design more accessible and cost-effective.

## Day - 1 Inception of Open-Source EDA, OpenLane and Sky130 PDK
### Introductions to RISC-V
RISC-V is an open-source processor design that anyone can use, modify, and build upon without restrictions. Unlike traditional processors that are controlled by big companies, RISC-V is free and open, making it accessible to students, researchers, and businesses worldwide. What makes RISC-V special is its flexibility. It provides a basic set of instructions for how a computer should work, and additional features can be added as needed. This means RISC-V can be used in everything from small devices like smartwatches and sensors to powerful computers and AI systems. Since RISC-V is open-source, it has a growing community of developers working on improving it. Many companies and universities are adopting RISC-V to create energy-efficient, affordable, and customized processors. This open approach is helping drive innovation in the tech industry, making advanced computing more accessible to everyone.

### Process of Designing an Integrated Circuit (IC) Using Software
Designing an integrated circuit (IC) involves a series of steps where software is used to create, simulate, and finalize the design before it’s physically manufactured. The process typically starts with design entry, where the functionality of the circuit is described using a hardware description language (HDL) like VHDL or Verilog. This description acts as the blueprint for the IC, specifying how different components will interact.
Once the design is written, the next step is synthesis, where the high-level description is converted into a lower-level form that can be implemented in hardware. During this step, the software breaks down the design into logical components, optimizing it for performance and power efficiency. The software ensures that the design adheres to specific rules and constraints, such as timing and area requirements.
After synthesis, the design moves to the placement and routing phase. Here, the software arranges the components on the chip and determines the best paths for the electrical connections between them. This step is crucial for minimizing delays and ensuring that the chip works efficiently.
Next, the verification phase ensures that the design behaves as expected. Simulations are run to check for errors, and software tools analyze the timing and functionality of the design to confirm that it meets all specifications.
Finally, once the design is verified, the software prepares it for fabrication. This includes generating the necessary files that will be used to manufacture the IC, such as the layout for photomasks that define the chip’s structure. Once these steps are complete, the design is sent to a semiconductor foundry, where it will be physically created as an IC.
Throughout this entire process, the software ensures that each step flows smoothly and that the final design meets the desired specifications, whether it's for a simple embedded system or a complex processor.

### How the software applications run on the hardware ?
Every software application we use in our everyday lives depends on hardware to function. The system software translates the application program into binary code, enabling the hardware to comprehend and perform the instructions. The main elements of system software consist of the Operating System (OS), Compiler, and Assembler. The operating system is essential for overseeing different elements of the computer system. It creates a space for the application program to execute and manages functions like memory management, scheduling processes, and input/output tasks. Depending on the architecture in use, like MIPS, x86, x64, or RISC-V, the operating system converts the application program into assembly language commands. The compiler converts high-level programming languages such as C or Java into assembly language instructions. The translation procedure is shaped by the particular architecture that will run the software. Various architectures possess unique instruction sets, and the compiler guarantees that the produced instructions are suitable for the intended architecture. Once the code is in assembly language, the assembler becomes involved. The assembly code is converted into binary code, a series of 0s and 1s that can be directly input into the hardware.

**RTL-IP (Register Transfer Level Intellectual Property)** refers to pre-designed and pre-verified digital hardware blocks that describe a portion of a digital circuit at the Register Transfer Level (RTL). The RTL is a high-level abstraction used to describe the flow of data between registers and the operations performed on that data within a circuit. RTL is typically written using hardware description languages (HDLs) such as Verilog or VHDL. RTL-IP is essentially a reusable component or module that can be integrated into larger designs. These components are designed to perform specific functions, such as arithmetic operations, memory management, data transmission, or interface control. Instead of designing each hardware block from scratch, designers can reuse these pre-built RTL modules, which significantly speeds up the design process, reduces the chance of errors, and improves overall design quality.

**EDA (Electronic Design Automation)** in VLSI (Very Large Scale Integration) design refers to the software tools and methodologies used to design, simulate, verify, and manufacture integrated circuits (ICs) or chips. EDA tools are essential in the complex process of designing VLSI systems, as they automate various tasks and optimize the design process, reducing the time and effort required to create chips.

**PDK (Process Design Kit)** is a collection of files and documentation used in semiconductor design to model a specific fabrication process. It contains the necessary data, models, and parameters that guide the design and ensure that an integrated circuit (IC) can be manufactured according to the foundry's process specifications. The PDK includes technology files, design rules, libraries of standard cells, models for electrical and physical simulations, and other crucial information needed for designing circuits that are compatible with a particular fabrication process. By using a PDK, designers can accurately model the behavior of the IC during the design phase, ensuring that the final product meets the performance, power, and area requirements. Examples of PDKs include Sky130 (an open-source 130nm process), GFU180 (GlobalFoundries’ 180nm process), and ASAP7 (an open-source 7nm process). These kits provide the necessary resources for designing with a specific process node, making the IC design and fabrication process more efficient and predictable.

### Simplified RTL2GDS flow
<img src="https://github.com/user-attachments/assets/2b953944-42ef-43d7-8e70-0578063511b4" width="500" style="border-radius: 10px">














