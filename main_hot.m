%% main_hot.m script
%  provides a short cut to the settings. If the user has more experience on
%  ORFS, it is recommended to use main_hot.m to avoid long and repeated
%  user input questions.
%  It includes 7 parts: folder and path setting, license and heading,
%  specifications and parameters, aerodynamic coefficients,
%  simulation parameters, simulation, and post processing.

clear
clc

%% folders
addpath(genpath("MATLAB_Script"));
addpath("Simulink_Block");
if ~isfolder("Simulink_Cache")
    mkdir Simulink_Cache
end

%% heading
ORFS_License;

%% specifications and parameters
Enviroment;

Drone.m = 0.501;                                         % [kg] with battery
Drone.I = [       0.01347,        0, 6.28582*10^-4;
                        0, 0.009579,             0;
           6.28582*10^-4 ,        0,      0.02251];      % [kg*m^2]
%CG = [202.332; 0; 19.565];                              % [mm]
Drone.CG = [182.332; 0; 19.565];                         % [mm]

Wing.num_Blade = 200;
Wing.b = 1.4;                               % [m]
Wing.thickness = 0.001;                     % [m]
Wing.S = 0.374;                             % [m^2]
Wing.AR = Wing.b^2 / Wing.S;                % [-]
Wing.dr = Wing.b / (2* Wing.num_Blade);     % [m]
Wing.r = Wing.dr / 2 : Wing.dr : (Wing.b - Wing.dr) / 2;        % [m]
Wing.c = BE_Chord_Length(Wing.r, Wing.num_Blade);% [m]
Wing.dS = Wing.dr .* Wing.c;                % [m^2]
Wing.MAC = sum(Wing.c .* Wing.dS) / sum(Wing.dS);               % [m]
Wing.Position = [113.5; 0; 43.483];         % [mm]
Wing.l = (Drone.CG - Wing.Position - [350* 0.25;0 ; 0]) / 1000; % [m]

Tail.alpha_mount_degree = -18;              % [˚]
Tail.alpha_mount = deg2rad(Tail.alpha_mount_degree);            % [rad]
Tail.b = 0.356;                             % [m]
Tail.S = 0.0511;                            % [m^2]
Tail.Position = [539.99; 0; 29.203];        % [mm]
Tail.l = (Drone.CG - Tail.Position) / 1000; % [m]
Tail.MAC = 0.168;                           % [m]

Flapping.Phi_max = 55/2;                    % [˚]
Flapping.Phi_off = -55/2+15;                % [˚]
Flapping.Theta_max = 30;                    % [˚]
Flapping.Theta_min = -30;                   % [˚]
Flapping.K_Theta = 2.7;                     % [-]
Flapping.f_max = 5;                         % [Hz] max. flapping frequency DOI: 10.1109/IROS45743.2020.9341741

delta_R_max = 70;                           % [˚]
delta_R_min = 70;                           % [˚]
delta_E_max = 38;                           % [˚]
delta_E_min = 42;                           % [˚]

%% aerodynamic coefficients
Wing = Flat_Plate(Wing);
% Wing = Flat_Plate_CFD(Wing);
% Wing = NACA0009_Coefficients(Wing);

Tail = Tail_CFD(Tail);
% Tail = Tail_Guzman(Tail);

%% simulation parameters
t_Total = 50;
dt = 0.01;

X_0 = [5.5; 0; 1.5;  % [m/s m/s m/s]
       0; 0; 0;      % [rad/s rad/s rad/s]
       0; deg2rad(15); 0;  % [rad rad rad]
       0; 0; 0]; % [m m m]

u_0 = [deg2rad(0); deg2rad(0); 1]; % [rad; rad; -]

%% simulink
load_system("ORFS_Model.slx");

out = sim("ORFS_Model.slx");

%% post processing
Post_Processing(out, nu, Wing);

