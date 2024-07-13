function Tail = Tail_Guzman(Tail)
    %% Tail_Guzman.m function
    %  provides the forces and moments coefficient of a delta tail. This
    %  tail model is based on Guzmán et al, and it is limited between +/-
    %  30 degrees of angle of attack.

    delta_E = 0;                        % [rad]
    delta_R = 0;                        % [rad]
    Tail.alpha = -30:0.01:30 .* 180/pi; % [rad]
    alpha_mount = 0/ 180 * pi;          % [rad]
    
    a = 2.92;
    b = 4.23;
    c = 2.26;
    d = 2.3;
    e = 1.9;
    f = 1.94;

    C_Y_max = -1.02;
    C_D_0 = 0.04;
    C_D_max = 0.36;
    C_ML_max = 0.08;
    C_MM_max = -0.65;
    C_MN_max = 0.65;

    Tail.C_L = sin(a * (alpha_Tail + delta_E + alpha_mount))* cos(delta_R);
    Tail.C_D = C_D_max - (C_D_max - C_D_0) * cos(b* (alpha_Tail + delta_E + alpha_mount))* cos(delta_R);
    Tail.C_M = C_MM_max * sin(c* (alpha_Tail + delta_E + alpha_mount))* cos(delta_R);

    % C_Y = C_Y_max * sin(d* (alpha + delta_E + alpha_mount)) * sin(delta_R);
    % C_ML = C_ML_max * sin(e* (alpha + delta_E + + alpha_mount))* sin(delta_R);
    % C_MN = C_MN_max * sin(f* (alpha + delta_E + alpha_mount))* sin(delta_R);

    %% plots

    % plot(rad2deg(alpha), C_L, 'color', 'b');
    % hold on
    % plot(rad2deg(alpha), C_D, 'color', 'r');
    % plot(rad2deg(alpha), C_MM, 'color', 'g');
    % 
    % plot(rad2deg(alpha), C_L_alpha_Tail(rad2deg(alpha)), 'color', 'c');
    % 
    % plot(rad2deg(alpha),C_D_alpha_Tail(rad2deg(alpha)), 'color', 'm');
    % plot(rad2deg(alpha),C_M_alpha_Tail(rad2deg(alpha)), 'color', 'k');
    % 
    % legend({'C_L','C_D', 'C_M'}, 'Location', 'southeast')
    % hold off
end