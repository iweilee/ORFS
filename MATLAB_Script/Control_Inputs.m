function [input_signal_timetable, manualFlag] = Control_Inputs
    %% Control_Inputs.m function
    %  reads the input signals from an exsisting file, here 
    %  Control_Inputs.xlsx.

    inputs_table = "Control_Inputs.xlsx";
    inputs_table_path = mlreportgen.utils.findFile(inputs_table);

    if isfile(inputs_table_path)
        input_signals = readtable(inputs_table);
        input_signal_timetable = table2timetable(input_signals(:,2:4), "RowTimes", seconds(input_signals.t));
    else
        error("Input file does not exist.")
    end

    doContinue = true;
    while doContinue
        if size(input_signal_timetable, 1) == 1
            manualFlag = input("Do you want to flight manually? ", "s");
            switch lower(manualFlag)
                case {"1", "y", "yes"}
                    manualFlag = true;
                    break;
                case{"0", "n", "no"}
                    onlyInitial = input("Do you want to fly with initial input signal only? ", "s");
                    switch lower(onlyInitial)
                        case {"1", "y", "yes"}
                            manualFlag = false;
                            break;
                        case {"0", "n", "no"}
                            error("Please assign the control inputs in the provided Control_Inputs.xlsx file");
                        case "stop"
                            error("Stop execution.");
                        otherwise
                            disp("Syntax error.");
                    end
                case "stop"
                    error("Stop executaion.")
                otherwise
                    disp("Syntax error.")
            end
        else
            manualFlag = false;
            doContinue = false;
        end
    end

end