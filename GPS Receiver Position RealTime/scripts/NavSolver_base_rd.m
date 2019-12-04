function [ X0 ] = NavSolver_base_rd( RD, SatPos, ref )

        dR_oc = RD;
        X = SatPos;
        for i = 1:size(X,2)
%             [ x, y, h ] = geo2local( X(1,i), X(2,i), X(3,i), 2 );
            [ x, y, h ] = geo2local_v2( X(:,i), ref );
            X(:,i) = [x;y;h];
        end
%     end
%     length(rawData1.D)
%     Xp1 = [2834946.82631387; 2165472.38206624; 5269722.20852235];
    Xp1 = [0; 0; 0];
    
    for i = 1:length(RD)
    R(i) = norm(Xp1 - SatPos(:,i));
    end
    % Вектор базыfo
    bx(1) = 0;
    by(1) = 0;
    bz(1) = 0;
    % Начальное приближение
    X0 = [bx; by; bz];
    % Интерационное решение МНК
    E = 1e-8;
    k = 1;
    while (1)
        k = k + 1;
        Xk = X0 + ((gradient(X,Xp1,R))' * gradient(X,Xp1,R))^(-1)...
            * (gradient(X,Xp1,R))' * (dR_oc - matrixF(X,X0,Xp1,R));
        if ((abs(Xk(1) - X0(1)) < E) && (abs(Xk(2) - X0(2)) < E)) || k > 12
            break
        end
        X0 = Xk;
    end
    nev = (dR_oc - matrixF(X,X0,Xp1,R));


end

