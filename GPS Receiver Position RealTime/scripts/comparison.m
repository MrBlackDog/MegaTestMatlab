function [obs,obs1] = comparison(obs,obs1)

i = 1;
while i <= length(obs)
    f = 0;
    for j = 1 : length(obs1)
        if obs(i,2) == obs1(j,2) && obs(i,3) == obs1(j,3)
%         if obs(i,2) == obs1(j,2)
            f = 1;
        end
    end
    if f == 0
        obs(i,:) = [];
        i = i - 1;
    end
    i = i + 1;
end

end

