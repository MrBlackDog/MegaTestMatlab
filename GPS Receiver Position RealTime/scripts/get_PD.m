function [ PD ] = get_PD( out, Name )
    k = 0;
    PD.data = zeros(32,1);
    for i = 1:length(out)
         if strcmp(Name,out(i).Name)
             k = k + 1;
             PD.time(k) = out(i).TOW;
             PD.data(out(i).data(:,3),k) = out(i).data(:,4);
         end
    end

end

