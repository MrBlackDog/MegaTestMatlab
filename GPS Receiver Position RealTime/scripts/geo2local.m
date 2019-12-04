function [ x, y, h ] = geo2local( lat, lon, h, flag )
    
    X_VP=[56.0820857606193; 37.3743780242523];
    [Xp0c(1),Xp0c(2),Xp0c(3)] = BLh2XYZ(X_VP(1),X_VP(2),210);
    if flag == 1
        [Xc(1),Xc(2),Xc(3)] = BLh2XYZ(lat,lon,h);
    elseif flag == 2
        Xc = [lat, lon, h];
    end
    X = global2localPos_V(Xc', Xp0c');
    x = X(1);
    y = X(2);
    h = X(3);
    

end

function [X,Y,Z] = BLh2XYZ(LAT,LON,h) 

% Example:
%(BLh)WGS84-(XYZ)WGS84
% LAT = 40.9987167395335;
% LON = 39.7652393428761;
% h = 51.403;

refell = 1;

switch refell
    case 1
        % IERS 2003 numerical standards
        % ellipsoid parameters for xyz2ellip.m
        a_tidefree = 6378136.6; %m      Equatorial radius of the Earth
        f_tidefree = 1/298.25642;     % Flattening factor of the Earth
        a = a_tidefree;  %m      Equatorial radius of the Earth
        f = f_tidefree;       % Flattening factor of the Earth
    case 2
        % GRS 80 (http://www.bkg.bund.de/nn_164850/geodIS/EVRS/EN/References/...
        %  Definitions/Def__GRS80-pdf,templateId=raw,property=publication...
        %  File.pdf/Def_GRS80-pdf.pdf)
        a_grs80    = 6378137;
        f_grs80    = 0.00335281068118;
        a = a_grs80;   %m      Equatorial radius of the Earth
        f = f_grs80;        % Flattening factor of the Earth
    case 3
        % WGS84
        a=6378137;
        f=1/298.25722356;
    case 4
        % Hayford
        a=6378388;
        f=1/297;
end

b = a-f*a;

lat=LAT*pi/180;
lon=LON*pi/180;
e2=(a^2-b^2)/a^2;
N=a/sqrt(1-e2*(sin(lat)^2));
X=(N+h)*cos(lat)*cos(lon);
Y=(N+h)*cos(lat)*sin(lon);
Z=(N*(1-e2)+h)*sin(lat);
end

function [y] = global2localPos_V(x, X)

% SYNTAX:
%   [y] = global2localPos(x, X);
%
% INPUT:
%   x = global position vector(s)
%   X = origin vector(s)
%
% OUTPUT:
%   y = local position vector(s)
%
% DESCRIPTION:
%   Rototraslation from Earth-fixed reference frame to local-level reference frame

%--- * --. --- --. .--. ... * ---------------------------------------------
%               ___ ___ ___
%     __ _ ___ / __| _ | __
%    / _` / _ \ (_ |  _|__ \
%    \__, \___/\___|_| |___/
%    |___/                    v 0.5.2 beta 1
%
%--------------------------------------------------------------------------
%  Copyright (C) 2009-2017 Mirko Reguzzoni, Eugenio Realini
%  Written by:
%  Contributors:     ...
%  A list of all the historical goGPS contributors is in CREDITS.nfo
%--------------------------------------------------------------------------
%
%   This program is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You should have received a copy of the GNU General Public License
%   along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%--------------------------------------------------------------------------
% 01100111 01101111 01000111 01010000 01010011
%--------------------------------------------------------------------------

%initialize new position vector
y = zeros(size(x));

for i = 1 : size(X,2)

    %geodetic coordinates
%     [phi, lam] = cart2geod(X(1,i), X(2,i), X(3,i));% old text
    [phi, lam] = cart2geod_V(X(1,i), X(2,i), X(3,i));% from VP!!

    %rotation matrix from global to local reference system
    R = [-sin(lam) cos(lam) 0;
         -sin(phi)*cos(lam) -sin(phi)*sin(lam) cos(phi);
         +cos(phi)*cos(lam) +cos(phi)*sin(lam) sin(phi)];

    %rototraslation
    y(:,i) = R * (x(:,i)-X(:,i));
end
end

function [phi, lam, h, phiC] = cart2geod_V(X, Y, Z)

% SYNTAX:
%   [phi, lam, h, phiC] = cart2geod(X, Y, Z);
%
% INPUT:
%   X = X axis cartesian coordinate
%   Y = Y axis cartesian coordinate
%   Z = Z axis cartesian coordinate
%
% OUTPUT:
%   phi = latitude
%   lam = longitude
%   h = ellipsoidal height
%   phiC = geocentric latitude
%
% DESCRIPTION:
%   Conversion from cartesian coordinates to geodetic coordinates.

%--- * --. --- --. .--. ... * ---------------------------------------------
%               ___ ___ ___
%     __ _ ___ / __| _ | __
%    / _` / _ \ (_ |  _|__ \
%    \__, \___/\___|_| |___/
%    |___/                    v 0.5.1 beta 3
%
%--------------------------------------------------------------------------
%  Copyright (C) 2009-2017 Mirko Reguzzoni, Eugenio Realini
%  Written by:
%  Contributors:     ...
%  A list of all the historical goGPS contributors is in CREDITS.nfo
%--------------------------------------------------------------------------
%
%   This program is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You should have received a copy of the GNU General Public License
%   along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%--------------------------------------------------------------------------
% 01100111 01101111 01000111 01010000 01010011
%--------------------------------------------------------------------------

%global a_GPS e_GPS

% a = goGNSS.ELL_A_GPS; % old text
% e = goGNSS.ELL_E_GPS; % old text
a = 6378137;
f_GPS = 1/298.257223563;
e = sqrt(1-(1-f_GPS)^2);

%radius computation
r = sqrt(X.^2 + Y.^2 + Z.^2);

%longitude
lam = atan2(Y,X);

%geocentric latitude
phiC = atan(Z./sqrt(X.^2 + Y.^2));

%coordinate transformation
psi = atan(tan(phiC)/sqrt(1-e^2));

phi = atan((r.*sin(phiC) + e^2*a/sqrt(1-e^2) * (sin(psi)).^3) ./ ...
    			(r.*cos(phiC) - e^2*a * (cos(psi)).^3));

N = a ./ sqrt(1 - e^2 * sin(phi).^2);

%height
h = r .* cos(phiC)./cos(phi) - N;
end