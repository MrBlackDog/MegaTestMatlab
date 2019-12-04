function [ wn, tow ] = gpstimeconvert( gps_time )
    % ������� �� ������� gps � �������� � wn + tow � ����������� �� �����
    % �������
    % gps_time �����������
    % wn - ����� ������
    % tow - ����� ������
    
    gps_time = gps_time/1e9;
    wn = fix(gps_time/604800);
    tow = (gps_time - wn*604800);


end

