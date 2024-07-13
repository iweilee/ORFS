function Wing = Flat_Plate_CFD(Wing)
    %% Flat_Plate_CFD.m function
    %  provides the 2-dimensional lift and drag coefficient of a flat
    %  plate from a computational fluid dynamic (CFD) simulation.

    file_FlatPlate = 'FlatPlate_V5.csv';
    %file_FlatPlate = 'FlatPlate_V10.csv';
    
    alpha_Pos = readmatrix(file_FlatPlate, 'range', 'A2:A92');
    L_Pos = readmatrix(file_FlatPlate, 'range', 'C2:C92');
    D_Pos = readmatrix(file_FlatPlate, 'range', 'D2:D92');
    
    % wing's MAC of 0.285 [m] and wingspan of 0.01 [m] are used in CFD
    C_l_Pos = L_Pos / (0.5 * 1.225 * 25 * 0.285 * 0.01);
    C_d_Pos = D_Pos / (0.5 * 1.225 * 25 * 0.285 * 0.01);

    Wing.alpha_C_l = deg2rad([-flip(alpha_Pos(2:end)); alpha_Pos]);
    Wing.alpha_C_d = deg2rad([-flip(alpha_Pos(2:end)); alpha_Pos]);
    Wing.C_l = [-flip(C_l_Pos(2:end)); C_l_Pos];
    Wing.C_d = [flip(C_d_Pos(2:end)); C_d_Pos];
    
    %% visualisation

    % figure('Name', 'Flat Plate with CFD Coefficients')
    % plot(alpha_C_l, C_l, '.')
    % hold on
    % plot(alpha_C_d, C_d, '*')
    % hold off

end