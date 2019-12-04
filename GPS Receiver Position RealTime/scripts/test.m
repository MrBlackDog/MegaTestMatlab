k = 1;
a = zeros(100,1);
while k < 100
    tic
    [ base ] = GoRealTime( OBS1, OBS2, ephemeris );
    a(k) = toc;
    k = k + 1;
end