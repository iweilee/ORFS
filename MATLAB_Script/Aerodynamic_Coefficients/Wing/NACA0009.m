function Wing = NACA0009(Wing)
    %% NACA0009.m function
    % provides the 2-dimensional lift and drag coefficient of a NACA0009
    % airfoil.
    
    file_C_l = 'NACA0009_CL_Re036.csv';
    file_C_d = 'NACA0009_CD_Re036.csv';

    %% C_l
    alpha_C_l_1 = readmatrix(file_C_l, 'range', 'A1:A53');
    alpha_C_l_2 = -alpha_C_l_1(2:53);
    C_l_1 = readmatrix(file_C_l, 'range', 'B1:B54');
    C_l_2 = -C_l_1(2:53);
    Wing.alpha_C_l = deg2rad([flip(alpha_C_l_2); alpha_C_l_1]);
    Wing.C_l = [flip(C_l_2); C_l_1];

    %% C_d
    alpha_C_d_21 = readmatrix(file_C_d, 'range', 'A1:A24');
    alpha_C_d_22 = 180 - alpha_C_d_21(1:23);
    alpha_C_d_2 = [alpha_C_d_21; flip(alpha_C_d_22)];
    alpha_C_d_1 = -180 + alpha_C_d_2(1:46);
    C_d_21 = readmatrix(file_C_d, 'range', 'B1:B24');
    C_d_22 = flip(C_d_21(1:23));
    C_d_2 = [C_d_21; C_d_22];
    C_d_1 = C_d_2(1:46);
    Wing.alpha_C_d = deg2rad([alpha_C_d_1; alpha_C_d_2]);
    Wing.C_d = [C_d_1; C_d_2];
    
    %% Plot
    % figure('Name', 'NACA0009 Coefficients');    
    % plot(rad2deg(alpha_C_l), C_l, "LineWidth", 1.1);
    % hold on;
    % plot(rad2deg(alpha_C_d), C_d, "LineWidth", 1.1);
    % xlabel('\alpha');
    % grid on;
    % hold off;

end