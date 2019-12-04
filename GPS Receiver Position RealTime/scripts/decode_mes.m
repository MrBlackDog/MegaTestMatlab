function [ out ] = decode_mes( mes, TOW )
% декодировка сообщения
    str = strsplit(mes);
    out.Name = str{1};
    gps_time = str2num(str{2});
    [ wn, tow ] = gpstimeconvert( gps_time );
    % время приема в GPS на телефоне
    out.TOW = round(tow);
    out.PING = TOW - tow;
    out.Position = [str2num(str{3});str2num(str{4});str2num(str{5});];
    k = 0;
    for i = 6:2:length(str)
        if i + 1 < length(str)
          if (str2num(str{i+1}) < 1e10) && (str2num(str{i+1}) > 1e6)
          k = k + 1;
          data(k,:) = [wn round(tow) str2num(str{i}) str2num(str{i+1})];
          end
        end
    end
    if k == 0
    out.data = [];
    else
        [A, ia] = unique(data(:,3));
        data = data(ia,:);
        out.data = data;
    end
    out.col.WEEK = 1;
    out.col.TOW = 2;
    out.col.PRN = 3;
    out.col.C1 = 4;
              

end

