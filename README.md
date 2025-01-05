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

- **RTL Design (Register Transfer Level)**
- **RTL Synthesis**
- **Floor and Power Planning**
- **Placement**
- **Clock Tree Synthesis**
- **Routing**
- **Sign-off**
- **GDSII File Generation**

### OpenLane Working Directory
<img src="https://github.com/user-attachments/assets/3ec95137-f37c-4fa3-880f-a379a3ded464" width="800" style="border-radius: 10px">

### OpenLane Design Directory
<img src="https://github.com/user-attachments/assets/0da9b1ae-3201-4621-b65a-8791ef1819ca" width="800" style="border-radius: 10px">

### Sky130 PDK Directory
<img src="https://github.com/user-attachments/assets/8222465a-70af-43f3-8d70-6f5ec304bae2" width="800" style="border-radius: 10px">

### OpenLane Docker Initialization
```bash
docker
```
<img src="https://github.com/user-attachments/assets/218b5f8f-9596-4ccb-88b4-f23be317c8c8" width="800" style="border-radius: 10px">

### OpenLane Design Preperation
Start openlane interactive flow
```bash
./flow.tcl -interactive
```
Create Design Flow Folders 
```bash
prep -design picorv32a
```
<img src="https://github.com/user-attachments/assets/e32383fb-b609-4a35-ba71-97bfbb18c7ed" width="800" style="border-radius: 10px">

### OpenLane RTL Synthesis
RTL synthesis using Yoysis & abc
```bash
run_synthesis
```
<img src="https://github.com/user-attachments/assets/9da21fd4-aa5a-4efc-a3ed-a02f87296047" width="800" style="border-radius: 10px">

**Caclculation of Flop Ratio**
```bash
Number of cells = 14876
Number of D-FF = 1613
Chip area for module 'picorv32a' = 147712.918400
Flop Ratio = Number of D-FF / Number of Cells = 0.108
                                              = 10.8 %
```

<img src="https://github.com/user-attachments/assets/b4725a11-34dc-47fd-97cb-f117bb869e16" width="800" style="border-radius: 10px">

## Day - 2 Good Floorplan Vs Bad Floorplan and Introduction to Library Cells)
###  Core & Die of an Integrated Ciruit/Chip
**The Core** refers to the functional part of the chip where the actual processing takes place. It consists of transistors, logic gates, memory units, and other circuit components that perform computations, data storage, and control functions. In multi-core processors, there are multiple processing cores on a single chip, each capable of executing tasks independently or in parallel. The core is designed based on the required functionality, whether it is a CPU, GPU, FPGA, or ASIC.

**The Die** is the physical piece of silicon that contains the entire circuitry of the chip, including one or more cores, memory, input/output (I/O) interfaces, and other supporting components. It is the small, rectangular silicon wafer cut from a larger wafer during the semiconductor manufacturing process. The size of the die depends on the complexity of the design and the technology node used. The die is later packaged into a protective casing with external pins or pads, allowing it to be integrated into electronic devices.
<div align="center">
  <img src="https://github.com/user-attachments/assets/7011cdb2-1877-422c-bbaf-07cf7d761f3a" width="400"></div>

**Core utilization Factor** refers to the percentage of the core area in a chip that is occupied by logic gates and circuits. It indicates how efficiently the available space is used in the design. Higher utilization means more components are packed in, while lower utilization leaves more empty space for routing and cooling. Optimizing core utilization helps balance performance, power, and manufacturability.

$$ \Huge \text{Core Utilization Factor} = \left( \frac{\text{Area occupied by logic}}{\text{Total core area}} \right) \times 100 $$

The **Aspect Ratio** of a chip refers to the ratio of its width to its height. It is a critical factor in chip design, as it affects the layout, performance, and manufacturability of the integrated circuit (IC). A balanced aspect ratio ensures efficient use of space, optimal routing, and thermal management. If the aspect ratio is too high or too low, it can lead to complications such as longer interconnections, increased power consumption, and difficulties in cooling. Designers typically aim for an aspect ratio that allows for a compact layout while maintaining a good balance between functionality and manufacturability.

$$ \Huge \text{Aspect Ratio} = \frac{\text{Core width}}{\text{Core height}} $$

A **Pre-placed cell** refers to a standard cell or component that is already positioned on the chip layout during the design process, before the placement step in the physical design flow. These cells are often critical components, such as input/output (I/O) pads, power cells, or clock buffers, which are placed manually or semi-automatically in a specific location to meet the design requirements.
Pre-placing these cells helps ensure proper chip functionality and may also be necessary for meeting certain design constraints like signal integrity, power distribution, or physical area requirements. Once pre-placed, the remaining cells in the design are then placed and routed around these fixed components during the subsequent steps of the design flow.

<div align="center">
  <img src="https://github.com/user-attachments/assets/d1139780-8810-4fe9-bd48-b079f335dcb1" width="400"></div>

**Decoupling capacitors (decaps)** are placed around pre-placed cells in VLSI design to ensure power stability, reduce noise, and mitigate IR drop. These cells, such as clock buffers and power management units, can cause sudden power spikes, and decaps act as local charge reservoirs to prevent voltage drops. They help smooth out fluctuations in the power and ground network, reducing noise and improving signal integrity. By locally storing and supplying charge, decaps minimize IR drop, reduce stress on the global power grid, and enhance overall chip performance and reliability by maintaining stable power delivery and consistent timing.

<div align="center">
  <img src="https://github.com/user-attachments/assets/bdcf9607-74c8-49a1-b496-c70c6390df53" width="400"></div>

**Power planning** in design ensures efficient power distribution across the chip while minimizing IR drop and electromigration. It involves designing a network of power rails, rings, and grids to deliver stable power to all cells. Proper power planning optimizes performance, reduces noise, and enhances chip reliability.

<div align="center">
  <img src="https://github.com/user-attachments/assets/380fe84a-f42d-4503-a03f-6bdb6ad773d8" width="400"></div>

**Pin planning** is the process of strategically placing input, output, and power pins to optimize signal flow and power distribution. Proper pin placement minimizes routing congestion, reduces delays, and improves overall performance. It ensures efficient connectivity between different components, enhancing system reliability.

<div align="center">
  <img src="https://github.com/user-attachments/assets/81eb04b6-846d-4e04-ae97-75ec270370fe" width="400"></div>

### OpenLane Floorplan
Openlane command for running floorplan
```bash
run_floorplan
```

<div align="center">
  <img src="https://github.com/user-attachments/assets/2922c325-d8df-4db8-88d4-a45d63d0a13f" width="800"></div>

Calculate Area of Die from Floorplan
```bash
LOWER LEFT COORDINATE OF DIE = (0,0)
UPPER RIGHT COORDINATE OF DIE = (660685,671405)
DIE AREA = 443,587.21 square microns (µm²)
```

<div align="center">
  <img src="https://github.com/user-attachments/assets/90d926d5-9f00-43bc-87ef-a8c591fbfcb4" width="800"></div>

View Floorplan in Magic Layout
```bash
magic -T home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged_unpadded.lef def read picorv32a.floorplan.def
```

<div align="center">
  <img src="https://github.com/user-attachments/assets/e6085d7f-7804-42b8-ac2f-abbb17c3962a" width="800"></div>

### Place & Route of Standard Cells
**Place and Route (PnR)** is a crucial step in chip design where standard cells and macros are positioned and connected to meet performance, power, and area constraints. Placement involves determining optimal locations for logic cells to minimize wire length and improve timing. Routing then establishes metal interconnections between these cells, ensuring proper signal flow while avoiding congestion and design rule violations. The process includes global and detailed routing, considering factors like power integrity, clock distribution, and signal integrity. Efficient PnR is essential for achieving a well-optimized and manufacturable chip layout.

<div align="center">
  <img src="https://github.com/user-attachments/assets/1d07664b-4879-42ed-a061-c70c90c98727" width="400"></div>

### OpenLane Standard Cell Placement
Cell placement command : 
```bash
run_placement
```
<div align="center">
  <img src="https://github.com/user-attachments/assets/998d0c33-c90f-43cd-a7b3-f4da4c5eea5c" width="800"></div>

View Cell Placement in Magic Layout
```bash
magic -T home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged_unpadded.lef def read picorv32a.placement.def
```

<div align="center">
  <img src="https://github.com/user-attachments/assets/7e2c0b78-e266-4906-ac48-12a52ca6b16e" width="800"></div>

<div align="center">
  <img src="https://github.com/user-attachments/assets/1a95055a-498c-4924-9473-4defc91c3ea4" width="800"></div>

## Day - 3 Design Library Cells using Magic Layout and Ngspice Characterization






























