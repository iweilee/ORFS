function [t_Total, dt, X_0, u_0] = Simulation_Parameters(Flapping)
    %% Simulation_Parameters.m function
    %  contains all the parameters, which Simulink needs to run the flight
    %  simulator.
    %  Coversion from decimal comma to decimal point is included.

    %% time
    doContinue = true;
    while doContinue
        t_Total = strrep(input("Simulation time in second: ", "s"), ",", ".");  % [s]
        if ~isnan(str2double(t_Total)) && ~isempty(t_Total)
            t_Total = str2double(t_Total);
            doContinue = false;
        elseif lower(t_Total) == "stop"
            error("Stop execution.")
        end
    end
    
    doContinue = true;
    while doContinue
        dt = strrep(input("Time step in second: ", "s"), ",", ".");             % [s]
        if ~isnan(str2double(dt)) && ~isempty(dt)
            dt = str2double(dt);
            if dt > t_Total
                disp("Time step should be smaller than the total simulation time.")
            elseif dt > 1/ (2* Flapping.f_max)
                warning("A large time step might lead the model to diverge.");
                doContinue = false;
            else
                doContinue = false;
            end
        elseif lower(dt) == "stop"
            error("Stop execution.");
        end
    end
    
    disp(" ");

    %% initial states
    stateName = {"velocity u, v, and w", "rotation rate p, q, and r", ...
                 "attitude phi, theta, and psi", "position x, y, and h"};
    stateUnit = {"meter per second", "degree per second", "degree", "meter"};
    X_0 = zeros(12, 1); % [u; v; w; p; q; r; phi; theta; psi; x; y; z = -h]

    disp("Pleas seperate each state with spcae.")

    for stateGroup = 1: 1: 4
        doContinue = true;
        while doContinue
            state_promt = "Initail "+ stateName(stateGroup)+ " in "+ stateUnit(stateGroup)+ ": ";
            states = split(strrep(input(state_promt, 's'), ",", "."));
            if all(~isnan(str2double(states))) && size(states, 1) == 3
                states = str2double(states);
                doContinue = false;
            elseif size(states, 1) ~=3 && ~any(strcmpi((states), {'stop'}))
                disp("Dimension error. Each state group should contain three states.");
            elseif any(strcmpi((states), {'stop'}))
                error("Stop execution.");
            end
        end
        for stateNumber = 1: 1: 3
            X_0(3* (stateGroup- 1)+ stateNumber) = states(stateNumber);
            if stateGroup == 2 || stateGroup == 3
                X_0(3* (stateGroup- 1)+ stateNumber) = states(stateNumber)* pi/ 180;
            elseif stateGroup == 4 && stateNumber == 3
                X_0(3* (stateGroup- 1)+ stateNumber) = -states(stateNumber);
            end
        end
    end

    %% initial control inputs
    signalName = {"elevator", "rudder", "throttle"};
    signalUnit = {"degree", "degree", "1"};
    u_0 = zeros(3, 1); % [delta_E, delta_R, delta_T]

    for num_u = 1: 1: size(u_0, 1)
        doContinue = true;
        while doContinue
            signal_promt = "Initial "+ signalName(num_u)+ " in "+ signalUnit(num_u)+ ": ";
            signal = split(strrep(input(signal_promt, 's'), ",", "."));
            if any(~isnan(str2double(signal))) && size(signal, 1) == 1
                u_0(num_u) = signal;
                doContinue = false;
            elseif isnan(str2double(signal))
                disp("Control input should be a number.");
            elseif size(signal, 1) ~= 1 && ~any(strcmpi(signal, {'stop'}))
                disp("Dimension error. Each input should contain only one value.");
            elseif any(strcmpi((signal), {'stop'}))
                error("Stop execution.");
            end
        end
    end

    u_0 = [deg2rad(u_0(1)); deg2rad(u_0(2)); u_0(3)];
    
end