# Smart-Grid-Security

This repository contains tools, artifacts, and models used for smart grid security research at the HiPRC Research Laboratory, IIT Kharagpur.

## 1. Learning-based Attack Synthesis For Safety Falsification of Smart Grid

The tool is designed to find attack vectors for smart grid models that remain undiscovered by the detection units present in the grid. The vectors tamper the sensor and actuator data of Smart Grid. These attack vectors target specific components of the grid causing abnormal behavior like brown-outs, without getting discovered by the anomaly detectors present in the grid. We use a methodology that synthesizes attack vectors using a learning-based probabilistic engine (Reinforcement Learning (RL)) and a stochastic optimization-based formal engine (S-TaLiRo). As a first phase, an RL-based attacker agent learns to inject the most effective input load-altering attack (LAA) sequences to push the system to its transient states for an elongated period as quickly as possible without raising any alarm. The probabilistic LAA sequences thus recovered are automatically augmented in the system model. This is given as input to a well-known simulation-based falsification engine S-TaLiRo that synthesizes false data injection attack (FDIA) sequences intending to falsify the set points of the generation unit. These additional FDIA perturbations thus uncovered, are formally guaranteed to send the generator units out of synchrony with the rest of the power grid exploiting the transient characteristics induced by the RL agent while maintaining stealth.

<img src="https://user-images.githubusercontent.com/103938112/213892560-a93829cb-b429-47e9-86c2-8daefbc27ccc.png" width="90%" height="90%"></br>

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

## 2. Targeted Attack Synthesis for Smart grid Vulnerability Analysis

This part of the repository contains the grid models used in our CCS paper Targeted Attack Synthesis for Smart grid Vulnerability Analysis (https://dl.acm.org/doi/10.1145/3576915.3623155)















