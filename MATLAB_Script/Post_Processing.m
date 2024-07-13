function Post_Processing(out, nu, Wing)
    %% Post_Processeing.m function
    %  is devided into two parts:
    %  1. to put the chache files to the desired folder, which keeps the 
    %     working folder clean.
    %  2. plots.

    %% simulink chache
    slxcList = dir("*.slxc");

    %% colours
    % colours with Leonardo (url: https://github.com/adobe/leonardo) and
    % colorbrewer (url: https://github.com/axismaps/colorbrewer/)
    blue   = [ 16, 119, 243]/ 255;
    orange = [249, 133,  23]/ 255;
    green  = [ 30,  54,   4]/ 255;

    %% font
    fontSize = 14;
    font     = 'CMU Serif';

    %% output data
    % Bar: time averaging value
    % B: in body frame
    % time
    time = out.tout;
    % states
    x     = squeeze(out.states);
    x_Bar = squeeze(out.states_Bar);
    % inputs
    u     = squeeze(out.inputs);
    % outputs
    y     = squeeze(out.outputs);
    y_Bar = squeeze(out.outputs_Bar);
    % reorder forces (3D matrix to 2D matrix)
    F_Cir     = squeeze(out.F_Cir);
    F_Vis     = squeeze(out.F_Vis);
    F_AM      = squeeze(out.F_AM);
    F_Rot     = squeeze(out.F_Rot);
    F_Aero_B  = squeeze(out.F_Aero_B);
    % F_Cir_Bar = squeeze(out.F_Cir_Bar);
    % F_Vis_Bar = squeeze(out.F_Vis_Bar);
    % F_AM_Bar  = squeeze(out.F_AM_Bar);
    % F_Rot_Bar = squeeze(out.F_Rot_Bar);
    % F_Aero_B_Bar  = squeeze(out.F_Aero_B_Bar);
    % magnitude of the forces
    F_Cir(4,:)    = vecnorm(F_Cir);
    F_Vis(4,:)    = vecnorm(F_Vis);
    F_AM(4,:)     = vecnorm(F_AM);
    F_Rot(4,:)    = vecnorm(F_Rot);
    F_Aero_B(4,:) = vecnorm(F_Aero_B);
    % F_Cir_Bar(4,:) = vecnorm(F_Cir_Bar);
    % F_Vis_Bar(4,:) = vecnorm(F_Vis_Bar);
    % F_AM_Bar(4,:)  = vecnorm(F_AM_Bar);
    % F_Rot_Bar(4,:) = vecnorm(F_Rot_Bar);
    % F_Aero_B_Bar(4,:) = vecnorm(F_Aero_B_Bar);
    F = zeros(size(F_Cir, 1) ,size(time, 1), 5);
    % F_Bar = zeros(size(F_Cir_Bar, 1) ,size(time, 1), 5);
    F(:, :, 1) = F_Cir;
    F(:, :, 2) = F_Vis;
    F(:, :, 3) = F_AM;
    F(:, :, 4) = F_Rot;
    F(:, :, 5) = F_Aero_B;
    % F_Bar(:, :, 1) = F_Cir_Bar;
    % F_Bar(:, :, 2) = F_Vis_Bar;
    % F_Bar(:, :, 3) = F_AM_Bar;
    % F_Bar(:, :, 4) = F_Rot_Bar;
    % F_Bar(:, :, 5) = F_Aero_B_Bar;
    % angle of attack
    alpha = squeeze(out.alpha_Blade);
    alpha_wo_Twist = squeeze(out.alapha_Blade_woTheta);
    % velocity of blade elements
    V_Blade = squeeze(out.V_Blade);
    V_Blade_Bar = squeeze(out.V_Blade_Bar);
    V_Blade(4, :, :) = vecnorm(V_Blade);
    V_Blade_Bar(4, :, :) = vecnorm(V_Blade_Bar);

    %% state plots
    x_List = {'u'; 'v'; 'w'; 'p'; 'q'; 'r'; '\phi'; '\theta'; '\psi'; 'x'; 'y'; 'z'};
    x_Unit = {'m/s'; 'm/s'; 'm/s'; ' $^\circ$/s'; ' $^\circ$/s'; ' $^\circ$/s'; ' $^\circ$'; ' $^\circ$'; ' $^\circ$'; 'm'; 'm'; 'm'};
    % x_unit = {'m/s'; 'm/s'; 'm/s'; 'deg/s'; 'deg/s'; 'deg/s'; 'deg'; 'deg'; 'deg'; 'm'; 'm'; 'm'};
    x_subplot_index = reshape(1: 12, 4, 3)'; % change subplot index from "first row then column" to "first column then rows"

    figure('Name', 'States', 'NumberTitle', 'off');
    for iStates = 1: 1: size(x, 1)
        subplot(3, 4, x_subplot_index(iStates))
        plot(time, x(iStates, :), 'Color', blue, 'LineStyle', '-', 'LineWidth', 1);
        hold on;
        plot(time, x_Bar(iStates, :), 'Color', orange, 'LineStyle', '--', 'LineWidth', 1);
        hold off;
        grid on;
        axes = set(gca, 'FontSize', fontSize);
        fontname(gca, font);
        xlabel(['$t$', '\textrm{ [s]}'], 'interpreter', 'latex', 'FontSize', fontSize);
        xlim([0 time(end)]);
        ylabel('$\mathit{'+ string(x_List(iStates)) + '}$' + ' [' + string(x_Unit(iStates)) + ']', 'interpreter', 'latex', 'FontSize', fontSize);
        legend('$\mathit{'+ string(x_List(iStates)) + '}$', '$\bar{\mathit{'+ string(x_List(iStates)) + '}}$','interpreter', 'latex', 'FontSize', fontSize);
    end

    %% inputs
    u_List = {'Elevator'; 'Rudder'; 'Throttle'};
    u_Unit = {' $^\circ$'; ' $^\circ$'; '-'};
    % u_Unit = {'deg'; 'deg', '-'};

    figure('Name', 'Inputs', 'NumberTitle', 'off');
    for iInputs = 1: 1: size(u, 2)
        subplot(3, 1, iInputs)
        plot(time, u(:, iInputs), 'Color', blue, 'LineStyle', '-', 'LineWidth', 1);
        axes = set(gca, 'FontSize', fontSize);
        fontname(gca, font);
        xlabel(['$t$', '\textrm{ [s]}'], 'interpreter', 'latex', 'FontSize', fontSize);
        xlim([0 time(end)]);
        ylabel(string(u_List(iInputs)) + ' [' + string(u_Unit(iInputs)) + ']', 'interpreter', 'latex', 'FontSize', fontSize);
    end

    %% outputs
    y_List = {'s', 'h'};
    y_Label_List = {'Flight Distance'; 'Altitude'};
    y_Unit = {'m'; 'm'};

    figure('Name', 'Outputs', 'NumberTitle', 'off');
    for iOutputs = 1: 1: size(y, 1)
        subplot(size(y,1), 1, iOutputs)
        plot(time, y(iOutputs, :), 'Color', blue, 'LineStyle', '-', 'LineWidth', 1);
        hold on;
        plot(time, y_Bar(iOutputs, :), 'Color', orange, 'LineStyle', '--', 'LineWidth', 1);
        hold off;
        grid on;
        axes = set(gca, 'FontSize', fontSize);
        fontname(gca, font);
        xlabel(['$t$', '\textrm{ [s]}'], 'interpreter', 'latex', 'FontSize', fontSize);
        xlim([0 time(end)]);
        ylabel(string(y_Label_List(iOutputs)) + ' $\mathit{' + string(y_List(iOutputs)) + '}$ [' + string(y_Unit(iOutputs)) + ']', 'interpreter', 'latex', 'FontSize', fontSize);
        legend('$\mathit{' + string(y_List(iOutputs)) + '}$', '$\mathit{\bar{' + string(y_List(iOutputs)) + '}}$','interpreter', 'latex', 'FontSize', fontSize);
    end

    %% Forces
    F_List = {'F_{Cir}', 'F_{Vis}', 'F_{AM}', 'F_{Rot}', 'F_{Aero}'};
    F_Bar_List = {'\bar{F}_{Cir}', '\bar{F}_{Vis}', '\bar{F}_{AM}', '\bar{F}_{Rot}', '\bar{F}_{Aero}'};
    F_Unit = 'N';
    Axes_W = {'in $\mathit{x_W}$'; 'in $\mathit{y_W}$'; 'in $\mathit{z_W}$'; ' '};
    Axes_B = {'in $\mathit{x_B}$'; 'in $\mathit{y_B}$'; 'in $\mathit{z_B}$'; ' '};
    F_subplot_index = reshape(1: 20, 5, 4)'; % change subplot index from "first row then column" to "first column then rows"

    figure('Name', 'Forces', 'NumberTitle', 'off');
    for iF = 1: 1: size(F, 3)
        if iF < size(F, iF)
            Axes = Axes_W;
        else
            Axes = Axes_B;
        end
        for iFAxes = 1: 1: 4
            subplot(4, 5, F_subplot_index((iF - 1)* size(F, 1) + iFAxes))
            plot(time, F(iFAxes, :, iF), 'Color', blue, 'LineStyle', '-', 'LineWidth', 1);
            hold on;
            plot(time, F_Bar(iFAxes, :, iF), 'Color', orange, 'LineStyle', '--', 'LineWidth', 1);
            hold off;
            grid on;
            axes = set(gca, 'FontSize', fontSize);
            fontname(gca, font);
            xlabel(['$t$', '\textrm{ [s]}'], 'interpreter', 'latex', 'FontSize', fontSize);
            xlim([0 time(end)]);
            ylabel('$\mathit{'+ string(F_List(iF)) + '}$' + ' [' + string(F_Unit) + '] ' + Axes(iFAxes), 'interpreter', 'latex', 'FontSize', fontSize);
            legend('$\mathit{'+ string(F_List(iF)) + '}$', '$\mathit{'+ string(F_Bar_List(iF)) + '}$','interpreter', 'latex', 'FontSize', fontSize);
        end
    end


    %% velocity
    % nearest chord length to MAC (c_MAC) and the index of corresponding wing strip (ic_MAC)
    c_MAC = interp1(Wing.r, Wing.r, Wing.MAC, 'nearest');
    ic_MAC = find(Wing.r == c_MAC);

    figure('Name', 'Velocity of the Wing Strip with Mean Aerodynamic Chord', 'NumberTitle', 'off');
    for iV = 1: 1: size(V_Blade, 1)
        subplot(4, 1, iV)
        plot(time, squeeze(V_Blade(iV, ic_MAC, :)), 'Color', blue, 'LineStyle', '-', 'LineWidth', 1);
        hold on;
        plot(time, squeeze(V_Blade_Bar(iV, ic_MAC, :)), 'Color', orange, 'LineStyle', '--', 'LineWidth', 1);
        hold off;
        grid on;
        axes = set(gca, 'FontSize', fontSize);
        fontname(gca, font);
        xlabel(['$t$', '\textrm{ [s]}'], 'interpreter', 'latex', 'FontSize', fontSize);
        xlim([0 time(end)]);
        ylabel('$\mathit{V}$ \textrm{ [m/s]} ' + string(Axes_W(iV)), 'interpreter', 'latex', 'FontSize', fontSize);
        legend('$\mathit{V}$', '$\bar{\mathit{V}}$','interpreter', 'latex', 'FontSize', fontSize);
    end

    %% Reynolds number
    Re = squeeze(V_Blade(4, ic_MAC, :)) * c_MAC / nu;
    Re_Bar = squeeze(V_Blade_Bar(4, ic_MAC, :)) * c_MAC / nu;
    subplot(5, 1, 5)
    plot(time, Re, 'Color', blue, 'LineStyle', '-', 'LineWidth', 1);
    hold on
    plot(time, Re_Bar, 'Color', orange, 'LineStyle', '--', 'LineWidth', 1);
    hold off
    grid on;
    axes = set(gca, 'FontSize', fontSize);
    fontname(gca, font);
    xlabel(['$t$', '\textrm{ [s]}'], 'interpreter', 'latex', 'FontSize', fontSize);
    xlim([0 time(end)]);
    ylabel('$\mathit{Re}$ \textrm{ [-]}', 'interpreter', 'latex', 'FontSize', fontSize);
    legend('$\mathit{Re}$', '$\bar{\mathit{Re}}$','interpreter', 'latex', 'FontSize', fontSize);

    %% angle of attack
    c_List = {'at Wing Root'; 'at Mean Aerodynamic Chord Length'; 'at Wing Tip'};
    ic = [1, ic_MAC, size(Wing.c, 2)];
    alpha_Unit = '$^\circ$';
    % alpha_Unit = '$deg$';

    figure('Name', 'Angle of Attack', 'NumberTitle', 'off');
    for iic = 1: 1: size(ic, 2)
        subplot(3, 1, iic)
        plot(time, alpha_wo_Twist(ic(iic), :), 'Color', orange, 'LineStyle', '-', 'LineWidth', 1);
        hold on;
        plot(time, alpha(ic(iic), :), 'Color', blue, 'LineStyle', '--', 'LineWidth', 1.5);
        hold off;
        grid on;
        axes = set(gca, 'FontSize', fontSize);
        fontname(gca, font);
        title(c_List(iic))
        xlabel(['$t$', '\textrm{ [s]}'], 'interpreter', 'latex', 'FontSize', fontSize);
        xlim([0 time(end)]);
        ylabel('$\alpha$ \textrm{ [' + string(alpha_Unit) + ']}', 'interpreter', 'latex', 'FontSize', fontSize);
        legend('without wing twist', 'with wing twist','interpreter', 'latex', 'FontSize', fontSize);
    end

end