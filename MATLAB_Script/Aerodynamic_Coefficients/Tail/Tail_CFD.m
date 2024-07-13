function Tail = Tail_CFD(Tail)
    %% Tail_CFD.m function
    %  provides the lift, drag and pitch moment cofficients of the tail
    %  based on a computational fluid dynamic (CFD) simulation.
    
    file_Tail = 'Tail_V5_Trans_180.csv';

    %% forces from CFD
    L = 2 * readmatrix(file_Tail, 'range', 'C8:C188');
    D = 2 * readmatrix(file_Tail, 'range', 'D8:D188');
    M = 2 * readmatrix(file_Tail, 'range', 'E8:E188');

    %% alpha
    alpha_Tail_Pos = readmatrix(file_Tail, 'range', 'B8:B188');
    Tail.alpha = deg2rad([-flip(alpha_Tail_Pos(2:(end))); alpha_Tail_Pos]);

    %% C_L
    C_L_Pos = L / (0.5* 1.225* Tail.S* 5^2);
    Tail.C_L = [-flip(C_L_Pos(2:end)); C_L_Pos];
    %C_L_alpha_Tail = fit(aoa_Tail, C_L_Tail, 'sin8');

    %% C_D
    C_D_Pos = D / (0.5* 1.225* Tail.S* 5^2);
    Tail.C_D = [flip(C_D_Pos(2:end)); C_D_Pos];
    %C_D_alpha_Tail = fit(aoa_Tail, C_D_Tail, 'sin8');
    
    %% C_M
    C_M_Pos = M / (0.5* 1.225* Tail.S* Tail.b* 5^2);
    Tail.C_M = [-flip(C_M_Pos(2:end)); C_M_Pos];
    %C_M_alpha_Tail = fit(aoa_Tail, C_M_Tail, 'fourier8');


    %% Plot
    % blue = [ 16, 119, 243] / 255;
    % pink = [249, 133,  23] / 255;
    % 
    % aoa_Tail = [-flip(aoa_Tail_Pos(2:(end))); aoa_Tail_Pos];
    % 
    % figure('Name', 'Tail Coefficient', 'NumberTitle', 'off', 'Position', [0, 0, 650, 280])
    % f = plot(C_M_alpha_Tail);
    % f.Color = blue;
    % f.LineWidth = 2;
    % hold on
    % plot(aoa_Tail, C_M_Tail, '.', 'Color', pink)
    % grid on
    % %legend({'C_L', 'C_L (fit sin8)', 'C_D', 'C_D (fit sin8)', 'C_M', 'C_M (fit fourier8)'}, 'Location', 'southwest', 'NumColumns', 3)
    % hold off
    % 
    % fontname(gca, 'CMU Serif');
    % xlabel(['$\alpha$', '\textrm{ [$^\circ$]}'], 'interpreter', 'latex', 'FontSize', 10);
    % xlim([-180 180])
    % xticks([-180 -120 -60 0 60 120 180])
    % ylabel('$\mathit{{C_L}_{Tail}}$ [$-$]', 'interpreter', 'latex', 'FontSize', 10);
    % legend('fit with $fourier8$', 'CFD Values', 'interpreter', 'latex', 'FontSize', 10);

end