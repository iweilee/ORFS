function Wing = Flat_Plate(Wing)
    %% Flat_Plate.m function
    %  provides the 2-dimensional lift and drag coefficient of a flat
    %  plate.
    
    alpha_Wing = (-pi:0.01:pi)';
    
    a_0 = 3.93; % DOI: 10.1186/s42774-021-00089-4

    % DOI: 10.1016/j.ast.2014.01.011. 
    Wing.C_l = pi* Wing.AR/ (2* (1 + sqrt((pi * Wing.AR / a_0)^2 + 1))) * sin(2 * alpha_Wing);
    
    C_D_0 = 0;
    % NASA url: https://www.grc.nasa.gov/www/k-12/VirtualAero/BottleRocket/airplane/shaped.html
    C_D_max = 1.28; 
       
    Wing.C_d = C_D_0 * cos(alpha_Wing).^2 + C_D_max * sin(alpha_Wing).^2;

    Wing.alpha_C_l = alpha_Wing;
    Wing.alpha_C_d = alpha_Wing;
    
    %% Plot

    % blue = [ 16, 119, 243] / 255;
    % pink = [249, 133,  23] / 255;
    % 
    % figure('Position', [0, 0, 600, 190], 'Name', 'Flat Plate');
    % plot(rad2deg(alpha_Wing), C_l, 'LineStyle','-', 'Color', blue, 'LineWidth', 1.5)
    % hold on
    % plot(rad2deg(alpha_Wing), C_d, 'LineStyle','--', 'Color', pink, 'LineWidth', 1.5)
    % hold off
    % 
    % grid on
    % axes = set(gca, 'FontSize', 10);
    % fontname(gca, 'CMU Serif');
    % xlabel('$\alpha$ [ $^\circ$]', 'interpreter', 'latex', 'FontSize', 10);
    % xlim([-180, 180])
    % xticks([-180 -120 -60 0 60 120 180])
    % ylabel({'$C_l$ [$-$]' ; '$C_d$ [$-$]'}, 'interpreter', 'latex', 'FontSize', 10);
    % legend('$C_l$', '$C_d$', 'interpreter', 'latex', 'FontSize', 10);

end