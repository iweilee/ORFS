function Wing = Wing_Coefficients(Wing)

    
    doContinue = true;

    disp("set 1: Flat Plate");
    disp("set 2: Flat Plate from CFD");
    disp("set 3: NACA 0009");
    num_set = input("Please choose a coefficient set of wing blade elements: ", "s");
    
    while doContinue
        switch lower(num_set)
            case {"1", "set 1", "set1"}
                Wing = Flat_Plate(Wing);
                break;
            case {"2", "set 2", "set2"}
                Wing = Flat_Plate_CFD(Wing);
                break;
            case {"3", "set 3", "set3"}
                Wing = NACA0009(Wing);
                break;
            case "stop"
                warning("Stop execution.")
            otherwise
                num_set = input("Error. Please choose a coefficient set from 1 to 3: ", "s");
        end
    end

    disp(" ");

end