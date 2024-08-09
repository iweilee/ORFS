%% Specifictaions.m script
%  contains all the parameters of the drone, which includes mass, intertia,
%  wing and tail geometry, and physical control limitation.

%% mass and inertia
Drone.m = 0.501;                                        % [kg] with battery, 0.397 without battery
Drone.I = [   0.01347,        0, 6.28582*10^-4;
                    0, 0.009579,             0;
           6.28582e-4,        0,       0.02251];        % [kg* m^2]
Drone.CG = [202.332; 0; 19.565];                        % [mm]

%% blade element number
doContinue = true;
while doContinue
    Wing.num_Blade = input("Please enter the blade number: ", "s");
    if lower(Wing.num_Blade) == "stop"
        error("Stop execution.");
    elseif mod(str2double(Wing.num_Blade), 1) ~= 0 || str2double(Wing.num_Blade) <= 0 || isnan(str2double(Wing.num_Blade))
        disp("The Blade number has to be a positive integer.");
    elseif str2double(Wing.num_Blade) < 30
        disp("Please consider a larger number for better performance.");
    else
        doContinue = false;
        Wing.num_Blade = str2double(Wing.num_Blade);
    end
end

disp(" ");

%% wing
Wing.b = 1.4;                                                       % [m]
Wing.thickness = 0.001;                                             % [m]
Wing.S = 0.374;                                                     % [m^2]
Wing.AR = Wing.b^2 / Wing.S;                                        % [-]
Wing.dr = Wing.b / (2* Wing.num_Blade);                             % [m]
Wing.r = Wing.dr / 2 : Wing.dr : (Wing.b - Wing.dr) / 2;            % [m]
Wing.c = BE_Chord_Length(Wing.r, Wing.num_Blade);                   % [m]
Wing.dS = Wing.dr .* Wing.c;                                        % [m^2]
Wing.MAC = sum(Wing.c .* Wing.dS) / sum(Wing.dS);                   % [m]
Wing.Position = [113.5; 0; 43.483];                                 % [mm]
Wing.l = (Drone.CG - Wing.Position - [350* 0.25;0 ; 0]) / 1000;     % [m]

%% tail
Tail.alpha_mount_degree = -18;              % [˚]
Tail.alpha_mount = deg2rad(Tail.alpha_mount_degree); % [rad]
Tail.b = 0.356;                             % [m]
Tail.S = 0.0511;                            % [m^2]
Tail.AR = Tail.b^2 / Tail.S;                % [-]
Tail.Position = [539.99; 0; 29.203];        % [mm]
Tail.l = (Drone.CG - Tail.Position) / 1000; % [m]
Tail.MAC = 0.168;                           % [m]

%% control limits based on hardware
Flapping.Phi_max = 55/2;         % [˚]
Flapping.Phi_off = -55/2+15;     % [˚]
Flapping.Theta_max = 35;         % [˚]
Flapping.Theta_min = -35;        % [˚]
Flapping.K_Theta = 2.7;
Flapping.f_max = 5;              % [Hz]

delta_R_max = 70;       % [˚]
delta_R_min = 70;       % [˚]
delta_E_max = 38;       % [˚]
delta_E_min = 42;       % [˚]

%% clear variable
clear doContinue
