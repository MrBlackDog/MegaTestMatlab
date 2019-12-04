function [ base ] = GoRealTime( obs1, obs2, ephemeris )
    
    if (size(obs1.data,1) >= 3) && (size(obs2.data,1) >= 3)
    [obs1.data,obs2.data] = comparison_v2(obs1.data,obs2.data);
%     [obs2.data,obs1.data] = comparison(obs2.data,obs1.data);
    for i = 1:size(obs1.data,1)
        OBS.col = obs1.col;
        OBS.data = obs1.data(i,:);
        out = get_broadcast_orbits(OBS,ephemeris,obs1.Position');
        SatPos(:,i) = [out.data(out.col.XS);out.data(out.col.YS);out.data(out.col.ZS);];
    end
    RD = obs1.data(:,4) - obs2.data(:,4);
    delta = norm(obs1.Position - obs2.Position);
    nums = find(abs(RD) < 2*delta);
    RD(nums)
    if length(nums) >= 3
    base  = NavSolver_base_rd( RD(nums), SatPos(:,nums), obs1.Position );
    else
        base = [0;0;0];
    end
    else
        base = [0;0;0];
    end
end



