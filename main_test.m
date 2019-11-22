% sm = SimpleClient('ws://mrblackdog.ddns.net:5000/ws');
% sm.send('State:Matlab');
k = 0;
    while k < 1
%         k = k + 1;
%         sm.RawMeas
%         sm.RawMeasFlag
        if sm.RawMeasFlag
            k = k + 1;
            mes = sm.RawMeas
            sm.RawMeasFlag = 0;
        end
        pause(0.2)
    end
sm.close();
 