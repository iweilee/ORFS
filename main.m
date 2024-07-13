%% main.m script
%  is the main file of the ORFS, which contains 5 parts: folder and path
%  setting, license and heading, parameter setting, simulation, and post 
%  processing.

clear
clc

%% folders
addpath(genpath("MATLAB_Script"));
addpath("Simulink_Block");
% TODO: move simulink cahce to cache folder
if ~isfolder("Simulink_Cache")
    mkdir Simulink_Cache
end

%% heading
ORFS_License;

disp("Enter ""stop"" to terminate.");
disp(" ");

%% parameters
Enviroment;

Specifications;

Wing = Wing_Coefficients(Wing);

Tail = Tail_Coefficients(Tail);

[t_Total, dt, X_0, u_0] = Simulation_Parameters(Flapping);

[signals_timetable, manualFlag] = Control_Inputs;

%% simulink
load_system("ORFS_Model.slx");
 
autoCommentBlock(manualFlag);

out = sim("ORFS_Model.slx");

%% post processing
Post_Processing(out, nu, Wing);