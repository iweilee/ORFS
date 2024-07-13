function x = BE_Chord_Length(y, num_Blade)
    %% BE_Chord_Length.m function
    %  takes the spanwise postion, y, the blade number, num_Blade, as
    %  inputs and provides the chord length of the corresponding blade 
    %  elements, x, as output.
    %  The coordinate system used here is according to the CAD model.

    %% geometry of the wing
    % LE: leading edge, TE: trailing edge
    file_Pointset = 'Pointset_Wing.xlsx';

    pointset_LE_4 = readmatrix(file_Pointset, 'Range', 'B20:C27');
    pointset_TE_3 = readmatrix(file_Pointset, 'Range', 'B2:C12');
    pointset_TE_4 = readmatrix(file_Pointset, 'Range', 'B14:C18');
    pointset_TE_5 = readmatrix(file_Pointset, 'Range', 'B29:C31');
    
    spline_LE_1 = 80;
    spline_LE_2 = @(a) -0.96* (a - 10) + 80;
    spline_LE_3 = 0;
    spline_LE_4 = fit(pointset_LE_4(:,2), pointset_LE_4(:,1), 'cubicinterp');
    spline_TE_1 = 307;
    spline_TE_2 = @(a) 2.072289157* (a - 9.25) + 307;
    spline_TE_3 = fit(pointset_TE_3(:,2), pointset_TE_3(:,1), 'cubicinterp');
    spline_TE_4 = fit(pointset_TE_4(:,2), pointset_TE_4(:,1), 'cubicinterp');
    spline_TE_5 = fit(pointset_TE_5(:,2), pointset_TE_5(:,1), 'cubicinterp');

    %% chord length of the blade elements
    x_mm = zeros(1, num_Blade);
    y_mm = 1000* y;

    for iBlade = 1:1:num_Blade
        if y_mm(iBlade) >= 0 && y_mm(iBlade) < 9.25
            x_mm(iBlade) = spline_TE_1 - spline_LE_1;

        elseif y_mm(iBlade) >= 9.25 && y_mm(iBlade) < 10
            x_mm(iBlade) = spline_TE_2(y_mm(iBlade)) - spline_LE_1;

        elseif y_mm(iBlade) >=10 && y_mm(iBlade) < pointset_TE_3(1, 2)
            x_mm(iBlade) = spline_TE_2(y_mm(iBlade)) - spline_LE_2(y_mm(iBlade));
        
        elseif y_mm(iBlade) >= pointset_TE_3(1, 2) && y_mm(iBlade) < 72.5
            x_mm(iBlade) = spline_TE_3(y_mm(iBlade)) - spline_LE_2(y_mm(iBlade));
        
        elseif y_mm(iBlade) >= 72.5 && y_mm(iBlade) < pointset_TE_3(end)
            x_mm(iBlade) = spline_TE_3(y_mm(iBlade)) - spline_LE_3;
        
        elseif y_mm(iBlade) >= pointset_TE_3(end) && y_mm(iBlade) < pointset_LE_4(1, 2)
            x_mm(iBlade) = spline_TE_4(y_mm(iBlade)) - spline_LE_3;
        
        elseif y_mm(iBlade) >= pointset_LE_4(1, 2) && y_mm(iBlade) < pointset_TE_4(end)
            x_mm(iBlade) = spline_TE_4(y_mm(iBlade)) - spline_LE_4(y_mm(iBlade));

        elseif y_mm(iBlade) >= pointset_TE_4(end) && y_mm(iBlade) <= pointset_TE_5(end)
            x_mm(iBlade) = spline_TE_5(y_mm(iBlade)) - spline_LE_4(y_mm(iBlade));
        end
    end

    x = x_mm / 1000;    % [m]

%     %% CG Position of the Wing Strip
%     P_BE = zeros(3, num_Blade);
% 
%     for iBlade = 1:1:num_Blade
%         if y_mm(iBlade) >= 0 && y_mm(iBlade) < 9.25
%             P_BE(1,iBlade) = 80 + x_mm(iBlade) / 2;
% 
%         elseif y_mm(iBlade) >= 9.25 && y_mm(iBlade) < 10
%             P_BE(1,iBlade) = 80 + x_mm(iBlade) / 2;
% 
%         elseif y_mm(iBlade) >=10 && y_mm(iBlade) < pointset_TE_3(1, 2)
%             P_BE(1,iBlade) = spline_LE_2(y_mm(iBlade)) + x_mm(iBlade) / 2;
%         
%         elseif y_mm(iBlade) >= pointset_TE_3(1, 2) && y_mm(iBlade) < 72.5
%             P_BE(1,iBlade) = spline_LE_2(y_mm(iBlade)) + x_mm(iBlade) / 2;
%         
%         elseif y_mm(iBlade) >= 72.5 && y_mm(iBlade) <= pointset_TE_5(end)
%             P_BE(1,iBlade) = x_mm(iBlade);
%         end
%     end
% 
%     P_BE = P_Wing + P_BE;   % [mm]
%     P_BE(2,:) = y_mm;       % [mm]

    %% visualization
%     figure('Name', 'Wing Geometry', 'NumberTitle', 'off')
%     line([0, 10] , [80, 80])% spline_LE_1
%     hold on
%     fplot(spline_LE_2, [10 72.5])
%     line([72.5, pointset_LE_4(1,2)] , [0, 0])% spline_LE_3
%     plot(spline_LE_4, 'k', pointset_LE_4(:,2), pointset_LE_4(:,1))
%     line([0, 9.25] , [307, 307])% spline_TE_1
%     fplot(spline_TE_2, [9.25 30])
%     plot(spline_TE_3, 'r', pointset_TE_3(:,2), pointset_TE_3(:,1))
%     plot(spline_TE_4, 'g', pointset_TE_4(:,2), pointset_TE_4(:,1))
%     plot(spline_TE_5, pointset_TE_5(:,2), pointset_TE_5(:,1))
%     legend off
%     hold off
%     
%     title('Wing Geometry')
%     xlabel('y [mm] in CAD or r [mm]')
%     xlim([0, 720])
%     ylabel('x [mm] in CAD or c [mm]')
%     ylim([-20,370])
end