function [ Bases, bases ] = Solver( Name, ephemeris, OBS, Smartphones_list, phone )
    
    
    N = str2num(Name(end));
    Bases = zeros(3,4);
    bases = zeros(3,4);
    if Smartphones_list(N)
        for i = 1:4
            if Smartphones_list(phone(i))
                [ base ] = GoRealTime( OBS{N}, OBS{phone(i)}, ephemeris );
                Bases(:,i) = base;
                bases(:,i) = OBS{N}.Position - OBS{phone(i)}.Position;
            end
        end
    end
        
    


end

