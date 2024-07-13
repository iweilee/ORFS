function Tail = Tail_Coefficients(Tail)
    %% Tail_Coefficients.m function
    %  gives the lift, drag, and pitch moment coefficients and the
    %  correspoding angle of attack of the tail from our own CFD simulation
    %  or from Guzman et. al. as outputs.


    doContinue = true;

    disp("set 1: CFD");
    disp("set 2: Guzmán et al.");
    %disp('Type "stop" to terminate.')
    num_set = input("Please choose a coefficient set of tail: ", "s");
    
    while doContinue        
        switch lower(num_set)
            case {"1", "set 1", "set1"}
                Tail = Tail_CFD(Tail);
                break;
            case {"2", "set 2", "set2"}
                Tail = Tail_Guzman(Tail);
                break;
            case "stop"
                error("Stop execution.")
            otherwise
                num_set = input("Error. Please choose a coefficient set 1 or 2: ", "s");
        end
    end

    disp(" ");

end