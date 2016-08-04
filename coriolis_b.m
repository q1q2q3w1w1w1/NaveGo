function cor_b = coriolis_b(lat, vel, h, DCMnb)
% coriolis_b: projects Coriolis forces from navigation frame to the body frame
%
%   Copyright (C) 2014, Rodrigo Gonzalez, all rights reserved. 
%     
%   This file is part of NaveGo, an open-source MATLAB toolbox for 
%   simulation of integrated navigation systems.
%     
%   NaveGo is free software: you can redistribute it and/or modify
%   it under the terms of the GNU Lesser General Public License (LGPL) 
%   version 3 as published by the Free Software Foundation.
% 
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU Lesser General Public License for more details.
% 
%   You should have received a copy of the GNU Lesser General Public 
%   License along with this program. If not, see 
%   <http://www.gnu.org/licenses/>.
%
% Reference: 
%			R. Gonzalez, J. Giribet, and H. Patiño. NaveGo: a 
% simulation framework for low-cost integrated navigation systems, 
% Journal of Control Engineering and Applied Informatics}, vol. 17, 
% issue 2, pp. 110-120, 2015. Eq. 11.
%
% Version: 001
% Date:    2014/09/11
% Author:  Rodrigo Gonzalez <rodralez@frm.utn.edu.ar>
% URL:     https://github.com/rodralez/navego 

kn = max(size(lat)); 

cor_b = zeros(kn, 3);

for i = 1:kn
   
    dcm = reshape(DCMnb(i,:), 3, 3); 
    omega_en_N = transportrate(lat(i), vel(i,1), vel(i,2), h(i));
    omega_ie_N = earthrate(lat(i));

    S = skewm(vel(i,:));
    cor_n = S * (omega_en_N + 2*omega_ie_N);

    corb =  dcm * cor_n; 
    cor_b(i,:) = (corb);
end
