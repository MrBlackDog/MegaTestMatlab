warning off
addpath('C:\MatlabWebSocket','C:\MatlabWebSocket\src','C:\MatlabWebSocket\examples');
sm = SimpleClient('ws://mrblackdog.ddns.net:5000/ws');
sm.send('State:Matlab');
load('���������0412.mat');
Name = 'Smartphone1';
addpath('scripts');
timestr = datestr(datetime);
timestr = [timestr(1:2) timestr(4:6) timestr(8:11) timestr(13:14) timestr(16:17) timestr(19:20)];
file = fopen([timestr '.txt'],'w');
N = str2num(Name(end));
    k = 0;
    for i = 1:5
        if N ~= i
            k = k + 1;
            phone(k) = i;
        end
    end
% sm.send('GetEphemeris:test test');
% a = sm.RawMeas;
% sm.RawMeasFlag = 0;
Database = [];
k = 0;
    while k < 100
%         k = k + 1;
%         sm.RawMeas
%         sm.RawMeasFlag
        if sm.RawMeasFlag
            % ����� ������ � GPS ������� �����
            TOW = GPSdatetime(datetime('now','TimeZone','Europe/London')); 
            % ����� ��������� ���������
            mes = sm.RawMeas;
            % ���� � ��������� ������ 9 ��������� (������ ���� ��), �� ���
            % ������� ��������� � �� ��� �������  � ����
            if length(split(mes)) > 9
            k = k + 1;
            out = decode_mes( mes, TOW );
            [ Database ] = DatabaseUPDATE( Database, out );
            fprintf(file,[num2str(TOW) ' ' mes '\r\n']); 
            if Database.flag
                OBS = Database.current_obs;
                Smartphones_list = Database.current_list;
                if sum(Smartphones_list) > 1
                [Bases, bases] = Solver( Name, ephemeris, OBS, Smartphones_list, phone );
                bases
                Bases
                end
            end
            
            end
            sm.RawMeasFlag = 0;
        end
        pause(0.001)
    end
sm.close();
fclose(file);
 