function autoCommentBlock(manualFlag)
    %% autoCommentBlock.m function
    %  can automatically comment "Joystick" and "Simlation Pace" block from
    %  simulink, depends on the user input.
    
    if manualFlag
        set_param("ORFS_Model/Inputs/Joystick", "Commented", "off");
        set_param("ORFS_Model/Simulation Pace", "Commented", "off");
    else
        set_param("ORFS_Model/Inputs/Joystick", "Commented", "on");
        set_param("ORFS_Model/Simulation Pace", "Commented", "on");
    end

    clear manualFlag
    
end