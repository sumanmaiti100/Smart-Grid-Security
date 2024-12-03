# Smart-Grid-Security

This repository contains tools, artifacts, and models used for smart grid security research at the HiPRC Research Laboratory, IIT Kharagpur.

## 1. Learning-based Attack Synthesis For Safety Falsification of Smart Grid

The tool is designed to find attack vectors for smart grid models that remain undiscovered by the detection units present in the grid. The vectors tamper the sensor and actuator data of Smart Grid. These attack vectors target specific components of the grid causing abnormal behavior like brown-outs, without getting discovered by the anomaly detectors present in the grid. We use a methodology that synthesizes attack vectors using a learning-based probabilistic engine (Reinforcement Learning (RL)) and a stochastic optimization-based formal engine (S-TaLiRo). As a first phase, an RL-based attacker agent learns to inject the most effective input load-altering attack (LAA) sequences to push the system to its transient states for an elongated period as quickly as possible without raising any alarm. The probabilistic LAA sequences thus recovered are automatically augmented in the system model. This is given as input to a well-known simulation-based falsification engine S-TaLiRo that synthesizes false data injection attack (FDIA) sequences intending to falsify the set points of the generation unit. These additional FDIA perturbations thus uncovered, are formally guaranteed to send the generator units out of synchrony with the rest of the power grid exploiting the transient characteristics induced by the RL agent while maintaining stealth.

<p align="center">
<img src="https://user-images.githubusercontent.com/103938112/213892560-a93829cb-b429-47e9-86c2-8daefbc27ccc.png" width="90%" height="90%"></br>
<em>Figure: Work Flow of the Attack Vector Synthesis Framework</em>
</p>


### Prerequisites (for running the tool):

* Platform: 32/64 bit Windows Operating System.
* External Tools: Matlab R2021a.
* Other Requirements: S-taliro tool-box https://sites.google.com/a/asu.edu/s-taliro/s-taliro , Matlab Reinforcement Learning Toolbox.
* For uploading the designed power grid model for an attack to the Graphical User Interface (GUI) tool the user is required to insert an RL agent block in his/her Simulink model.
* Choose the attack points in the model. To obtain individual attack vectord, connect a inport to demux, first index is LAA attack vector followed by FDIA attack vectors.
* Connect all the observations for RL-agent to a mux and then to outport 1
* Connect the variables need to be plotted/observed to mux(name the mux as outputs) and connect to outport 2. Name the signals connected to mux using signal properties.
### Installation guide:

* Setup S-taliro toolbox by pasting "setup_staliro.m" command in the Matlab command window.
* Copy all the .mat files from folder mat_files and simulink models from folder rl_models_simulink in the repository to the path C:\trunk\demos\SystemModelsAndData.
* Copy powershark_gui.m, load_mat.m and powershark_gui.fig to the path C:\trunk.
* Run "H = powershark_gui" in matlab command window to open the Graphical User Interface (GUI).


### Demonstration of the GUI of our tool:
Please refer to the folder LearningBasedAttackSynthesis for performing the below steps.

#### **Step 1**:
The user uploads his/her power grid simulink model (in .mdl format) (eg. IEEE5bus.mdl, IEEE9bus.mdl, IEEE14bus.mdl, IEEE39bus.mdl) to the tool by pressing the Select Model button. The file explorer button pops up from where the user can select his/her power grid simulink model.<br />

![Presentation_gui_tool pptx (5)](https://user-images.githubusercontent.com/96375883/213904029-e02e67cf-60c4-42d9-bf18-a3856160e31d.svg) <br />

#### **Step 2:**
Next in the specification tab, the user enters the safety properties for the power grid (i.e, the upper and lower bound limit for power grid frequency) and set the point value for the detection unit in the grid in the form of the MTL equation. <br />
![Presentation_gui_tool pptx (6)](https://user-images.githubusercontent.com/96375883/213904027-d48d7b17-e395-48fd-aed1-5d12633d8ffa.svg)<br />

In the above figure, r1 represents the upper safety limit for grid frequency and r2 represents the lower safety limit for grid frequency. r3 represents the threshold value for the residue-based detection unit.

#### **Step 3:**
In the predicate settings tab, the user specifies the constraint(greater than, less than etc) and compares with a constant number specified by the user
 
![presentation_gui_3](https://user-images.githubusercontent.com/96375883/235578147-04479e9b-d4d7-4d82-96df-47994c1b3cb7.svg)<br />
 
 #### **Step 4:**
 The user specifies which IEEE bus architecture did he/she upload by clicking the appropriate button. 
 
![Presentation_gui_tool pptx (8)](https://user-images.githubusercontent.com/96375883/213904024-bca0481e-962a-411a-9f56-1eac85d403ca.svg) <br />

#### **Step 5:**
The user specifies how many times the simulink model will execute in the run tab

![Presentation_gui_tool pptx (9)](https://user-images.githubusercontent.com/96375883/213904023-4528cde7-aec1-4d3f-89fe-fcdbbc0272ee.svg)<br />

#### **Step 6:**
The user specifies the time duration in seconds for which the simulation is to be continued in the Simulation Time tab.

![Presentation_gui_tool pptx (10)](https://user-images.githubusercontent.com/96375883/213904020-58ef7622-6119-41dd-9367-281a07a954e3.svg)<br />

#### **Step 7:**
The user choses a solver for the simulink model using this tab.<br />

![Presentation_gui_tool pptx (11)](https://user-images.githubusercontent.com/96375883/213904019-bc738d9c-016e-468f-8a5b-272d836c1235.svg)<br />

#### **Step 8:**
Time time step at which the model will be executed is specified in the Sample Time tab.<br />

![Presentation_gui_tool pptx (12)](https://user-images.githubusercontent.com/96375883/213904018-c0ef76fb-85d6-4ebd-bc26-91d50d81fae3.svg)<br />

#### **Step 9:**
The initial value for false data generation is specified by the user in this tab.<br />

![Presentation_gui_tool pptx (13)](https://user-images.githubusercontent.com/96375883/213904016-62b644ef-7068-4bc4-9814-f733293c2e4e.svg)<br />

#### **Step 10:**
Here in InputMin and InputMax the user specifies the input range for false-data injection, in the Control Points tab the samples points for false-data injection, are selected by the user, in interpolation type the user specifies how to insert false-data in the simulation time.<br />

![Presentation_gui_tool pptx (14)](https://user-images.githubusercontent.com/96375883/213904015-2c6ee61f-fca1-40a1-a183-14581db112c1.svg)<br />

#### **Step 11:**
Finally the user starts the simulation by clicking the run simulation button.</br>

![Presentation_gui_tool pptx (15)](https://user-images.githubusercontent.com/96375883/213904013-0e62f5a7-362f-452c-891e-b12382fe7110.svg)<br />

### Result plot

![frequency_comparison_9_bus](https://user-images.githubusercontent.com/96375883/213973704-ecfa6f10-b98d-47bd-8b10-2a8b001d41fa.svg)

A sample output plot for IEEE 9 Bus case is provided above.



### Demo Video
[https://youtu.be/V6PoH3omt38](https://www.youtube.com/watch?v=eIeCV0w4F08)

## 2. Targeted Attack Vector Synthesis Framework for Smart grid Vulnerability Analysis

This part of the repository contains the grid models used in our CCS paper Targeted Attack Synthesis for Smart grid Vulnerability Analysis (https://dl.acm.org/doi/10.1145/3576915.3623155).

Modern smart grids utilize advanced sensors and digital communication to manage the flow of electricity from generation source to consumption points. They also employ anomaly detection units and phasor measurement units (PMUs) for security and monitoring of grid behavior. However, as smart grids are distributed, vulnerability analysis is necessary to identify and mitigate potential security threats targeting the sensors and communication links. We propose a novel algorithm that uses measurement parameters, such as power flow or load flow, to identify the smart grid's most vulnerable operating intervals. Our methodology uses a formal tool STaliro to incorporate a Monte Carlo simulation approach to identify these intervals and deploys a deep reinforcement learning agent to generate attack vectors during the identified intervals that can compromise the grid's safety and stability in the minimum possible time, while remaining undetected by local anomaly detection units and PMUs. Our approach provides a structured methodology for effective smart grid vulnerability analysis, enabling system operators to analyze the impact of attack parameters on grid safety and stability and facilitating suitable design changes in grid topology and operational parameters.


Our framework assumes a stronger grid safety and security model by considering that 1) the generation side is equipped with anomaly based detectors sensitive to transient dynamics, 2) real time PMU measurements are available for the transmission system and 3) suitable  protection schemes exist at the generation, transmission and load side. With such security assumptions, we propose an  attack framework that simultaneously targets Automatic Generation Controlers and PMUs to maximize the physical impact of attacks on the grid in minimum possible attack duration, while remaining stealthy all the while.

<p align="center">
  <img src="https://github.com/sumanmaiti100/Attack-Vector-Synthesis-Framework-for-Smart-Grids/assets/103938112/ec0c5b80-a2b7-4f68-95c5-0711b691706b" alt="monte_carlo_intro_1" width="700">
  <br>
  <em>Figure: Work Flow of the Attack Vector Synthesis Framework</em>
</p>

### Prerequisites:

* Platform: 32/64 bit Windows Operating System.
* External Tools: Matlab R2022b or later versions.
* Other Requirements: S-taliro tool-box https://sites.google.com/a/asu.edu/s-taliro/s-taliro , Matlab Reinforcement Learning Toolbox.

### Installation guide:
Please access the folder named TargetedAttackVectorSynthesis
* Setup S-taliro toolbox by pasting "setup_staliro.m" command in the Matlab command window.
* Copy all the .mat files from folder mat_files and simulink models from folder rl_models_simulink in the repository to the path C:\trunk\demos\SystemModelsAndData.

### Simulation guide:
* To find out vulnerable operating periods of a smart grid model open any slx file from the folders IEEE 14 BUS ATTACK MODEL, IEEE 37 BUS ATTACK MODEL and IEEE 39 BUS ATTACK MODEL. Next, attach goto ports on the tie lines in the models (indicated inside the model), and run the code in "MonteCarloSimulationAlgorithmCode.txt" in the maatlab command window to get the most vulnerable operating periods in the matlab workspace.
* To simulate False Data injection (FDI) attacks during the identified vulnerable operating periods, for an IEEE 14 bus model, load all the mat files in folder IEEE 14 BUS ATTACK MODEL into matlab workspace.
* Run the matlab slx file in folder IEEE 14 BUS ATTACK MODEL for desired time duration, to observe the effect of attack on the grid operating frequency through the scopes provided in the model.
* To simulate the attack in presence of protection systems in the grid, load all the mat files in the folder IEEE 14 BUS ATTACK MITIGATION into the matlab workspace and run the slx file in the same folder for the desired time duration.
* To simulate False Data injection (FDI) attacks during the identified vulnerable operating periods, for an IEEE 37 bus model, load all the mat files in folder IEEE 37 BUS ATTACK MODEL into matlab workspace.
* Run the matlab slx file in folder IEEE 37 BUS ATTACK MODEL for desired time duration, to observe the effect of attack on the grid operating frequency through the scopes provided in the model.
* To simulate the attack in presence of protection systems in the grid, load all the mat files in the folder IEEE 37 BUS ATTACK MITIGATION into the matlab workspace and run the slx file in the same folder for the desired time duration.
* To simulate False Data injection (FDI) attacks during the identified vulnerable operating periods, for an IEEE 39 bus model, load all the mat files in folder IEEE 37 BUS ATTACK MODEL into matlab workspace.
* Run the matlab slx file in folder IEEE 39 BUS ATTACK MODEL for desired time duration, to observe the effect of attack on the grid operating frequency through the scopes provided in the model.
* To simulate the attack in presence of protection systems in the grid, load all the mat files in the folder IEEE 39 BUS ATTACK MITIGATION into the matlab workspace and run the slx file in the same folder for the desired time duration.

## 3. Enhancing Smart Grid Security Using Reinforcement Learning and Formal Verification of Agents

 The distributed nature of smart grids, combined with sophisticated sensors, control algorithms, and data collection facilities at Supervisory Control and Data Acquisition (SCADA) centers, makes them vulnerable to strategically crafted cyber-physical attacks. These malicious attacks can manipulate power demands using high-wattage Internet of Things (IoT) botnet devices, such as refrigerators and air conditioners, or introduce false values into transmission line power flow sensor readings. Consequently, grids experience blackouts and high power flow oscillations. Existing grid protection mechanisms, originally designed to tackle natural faults in transmission lines and generator short circuits, are ineffective against such intelligently crafted attacks. This is because grid operators overlook potential scenarios of cyber-physical attacks during their design phase. 


In this work, we propose a safe Deep Reinforcement Learning (DRL)-based framework (refer to the figure below) for mitigating attacks on smart grids. The DRL agent effectively neutralizes cyber-physical attacks on grid surfaces by triggering appropriate sequences of existing protection schemes. The safety of the DRL agent is formally verified through a reachability analysis method. Additionally, our framework is designed for deployment on CUDA-enabled GPU systems, which enables faster execution of these protection sequences and their real-time validation. Our framework establishes a new set of protection rules for grid models, successfully thwarting existing cyber-physical attacks. The paper draft related to this work can be found at: https://arxiv.org/abs/2409.15757\



![formal agent-1](https://github.com/user-attachments/assets/919267a5-3f10-4931-a4cf-30b29be16b1a)
<p align="center">
<em>Figure: Work Flow of the Attack Mitigation Framework</em>
</p>

### Prerequisites:

* Platform: 32/64 bit Windows Operating System.
* External Tools: Matlab R2022b or later versions.
* Other Requirements: Matlab Reinforcement Learning Toolbox.

### Simulation Guide
Please access the folder named EnhancingSmartGridSecurity

* The folder EnhancingSmartGridSecurity contains several subfolders, each representing different attack scenarios with .mat files and Simulink (.slx) files. To view the attack scenarios and their mitigation by our RL agent, load the .mat files into the MATLAB workspace, open the corresponding Simulink (.slx) files, and simulate the models to observe the attack scenarios and the results of the mitigation strategies.

## 4. Smart Grid Profit Exploitation Through Tie-Line Power Flow Manipulation

 The exponential growth in electricity demand has necessitated transforming legacy power grids into smart grids. Modern smart grids incorporate advanced sensors for real-time grid monitoring and capabilities for forecasting power generation and demand to better manage consumer electricity needs. These advancements ensure reliable grid operation while enabling electric utility organizations, such as generation companies, to participate in the electricity market. Utilities bid on electricity prices based on forecasted demand, fostering competition that helps ensure consumers receive electricity at reasonable prices. However, the distributed nature of smart grids allows adversaries to strategically disrupt the power supply-demand balance, to exploit the electricity market for profit. In this work, we introduce a novel optimization based attack model targeting the electricity market (refer to the figure below) by disrupting the grid's power flow, a critical vulnerability overlooked by grid security researchers. Our attack model maximizes profits in the market by manipulating power flow sensor measurements of specific transmission lines. It maintains the grid's operating frequency within permissible limits, thus evading detection by operators at Load Dispatch Centers (LDCs). We also propose and demonstrate effective countermeasures against this attack in a testbed environment. To our knowledge, this is the first attack that maximizes market profits while maintaining grid parameters within safety limits.

![SPECTER2](https://github.com/user-attachments/assets/5b6d38ba-90db-441b-a438-2e0b6147f0c6)
<p align="center">
<em>Figure: Work Flow of the Market Manipulation  Attack Framework</em>
</p>

### Prerequisites:

* Platform: 32/64 bit Windows Operating System.
* External Tools: Matlab R2022b or later versions, YALMIP tool: https://yalmip.github.io/ (version R20230622) or later.


### Installation Guide:
* Download the YALMIP software and extract it from the ZIP file. Open MATLAB, click on the "Set Path" option, and add the extracted YALMIP folder to the MATLAB directory to ensure it is accessible in the current workspace.


### Simulation Guide:
Please access the folder named SmartGridProfitExploitation. The folder contains MATLAB code that integrates electricity market data from the Australian energy market, collected on September 17th, 2024, between 12 AM and 12 PM. The data is organized into folders for different regions: New South Wales (NSW), Tasmania (TAS), Queensland (QLD), and South Australia (SA). Each folder contains MATLAB scripts that implement the market manipulation attack to gain profits and their subsequent mitigation strategies. To run the optimization codes provided, ensure you have installed the latest version of the YALMIP solver (link provided above) and are using MATLAB version R2022b or later.




















