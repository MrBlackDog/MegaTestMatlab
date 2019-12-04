function [ wn, tow ] = gpstimeconvert( gps_time )
    % перевод из времени gps в секундах в wn + tow с округлением до целой
    % секунды
    % gps_time наносекунды
    % wn - число недель
    % tow - число секунд
    
    gps_time = gps_time/1e9;
    wn = fix(gps_time/604800);
    tow = (gps_time - wn*604800);


end

