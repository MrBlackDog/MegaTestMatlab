function [ obs, obs1 ] = comparison_v2( obs, obs1 )
    k = 0;
    for i = 1:size(obs,1)
        for j = 1:size(obs1,1)
            if obs(i,2) == obs1(j,2) && obs(i,3) == obs1(j,3)
                  k = k + 1;
                  o1(k,:) = obs(i,:);
                  o2(k,:) = obs1(j,:);
            end
        end
    end
    obs = o1;
    obs1 = o2;

end

