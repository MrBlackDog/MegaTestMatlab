function [base, nev] = NavSolver_base2(RD, SatPos)
    MaxErr = 1e-3;
    MaxIter = 40;
    stopflag = 1;
    y = RD;
    X = SatPos;
        for i = 1:size(X,2)
            [ x, y, h ] = geo2local( X(1,i), X(2,i), X(3,i), 2 );
            SatPos(:,i) = [x;y;h];
        end
    PRN1 = [0;0;0];
    H = matrixH(SatPos, PRN1);
%     y = rawData1.D - rawData2.D;
    y(end+1) = 0;
    X = [0;0;0;0;];
    k = 0;
    while stopflag
        y_oc = H(:,1)*X(1) + H(:,2)*X(2) + H(:,3)*X(3) + H(:,4) ;
        nev = y - y_oc;
        X_prev = X;
        X = X + ((H'*H)^(-1))*H'*nev;
        k = k + 1;
        if norm(X-X_prev)<=MaxErr
            stopflag=0; %Выход из цикла, если достигнута требуемая точность
        elseif k>=MaxIter
            stopflag=0; %Выход из цикла, если достигнуто предельное число итераций
        end
    end
    base = X(1:3);
end

    function [H] = matrixH(SatPos, PRN1)
        for i = 1:length(SatPos)
            H(i,:) = [(SatPos(:,i) - PRN1)'/norm(SatPos(:,i) - PRN1) 1 ];
        end
        H(i+1,:) = [0 0 1 0];
    end
