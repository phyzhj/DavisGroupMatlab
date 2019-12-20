function H = Hirschfeld_tb_hamiltonian_soc_test_OO2(px, py, p1, p2, kz, oos, oodfe, soc)

H = zeros(20,20,1);
Hpp = zeros(10,10,1);
Hpm = zeros(10,10,1);

% % z = 6;
% % zc = 6.2;
% % z = 6.2;
% 
% zc = 5;
% z = 5;
% 
% % t1111 = 0.086/z + 0.0005; changed June 25 2016
% t1111 = 0.086/z + 0.0005 - 0.001;
% 
% t1016 = -0.063/z -0.0211;
% t2011 = -0.028/z + 0.00283;
% 
% t2116 = 0.017/z;
% 
% % t1113 = -0.056*1i/z; changed June 25 2016
% t1113 = -0.056*1i/z + 0.006*1i;
% 
% t1018 = 0.305*1i/z + 0.07625*1i;
% 
% t1115 = -0.109/z;
% t1027 = -0.412/z + 0.02289;
% 
% t1122 = -0.066/z + 0.0037;
% 
% t1029 = -0.364*1i/z - 0.034*1i;
% t1123 = 0.089*1i/z;
% t102ten = 0.338/z - 0.01877;
% t104ten = 0.180*1i/z;
% 
% 
% 
% %% H++33 and H++44
% t2033 = 0.009/z;
% t0233 = -0.045/z;
% 
% t20133 = -0.008/zc;
% t02133 = 0.020/zc;
% 
% % the following three hopping integrals are symmetric in 33 and 44 
% t2233 = 0.027/z;
% t1133 = 0.232/z;
% t00133 = 0.011/zc;
% %% H+-38 and H+-39
% t1038 = 0.080/z + 0.00344;
% t1049 = 0.311/z + 0.01224;
% 
% t2138 = 0.016/z;
% t2149 = -0.019/z;
% 
% t10138 = 0.006/zc + 0.00253;
% t10149 = 0.025/zc - 0.00203;
% 
% t12138 = -0.003/zc;
% t12149 = 0.006/zc;
% %% H++34
% t1134 = 0.099/z;
% %% H++35
% t1135 = 0.146*1i/z;
% %% H+-39
% t10139 = 0.015/zc;
% 
% %%
% % po1 = 0.0125-0.0075;
% % po2 = 0.0025-0.0075;
% % po3 = 0.0025-0.0075;
% % po4 = 0.0025-0.0075;
% % po5 = 0.0025-0.0075;
% % po1 = 0.03; changed June 25 2016
% po1 = 0.0;
% po2 = 0.0;
% po3 = 0.0;
% po4 = 0.0;
% po5 = 0.0;
% 
% e1 = 0.014/z -0.0004 + po1;
% 
% e2 = -0.539/z + 0.0299 + po2;
% 
% e3 = 0.020/z -0.000043 + po3;
% 
% e4 = 0.020/z -0.000043 + po4;
% 
% e5 = -0.581/z +0.03224 + po5;
% 
% %% 
% t10116 = 0 + 0.00275;
% 
% t00111 = 0;
% t12116 = -0.017/zc;
% t11111 = 0;
% t10118 = 0.009*1i/zc;
% 
% t20111 = 0.017/zc - 0.002753;
% 
% t10119 = 0.020*1i/zc;
% t20114 = 0.0030*1i/zc + 0.0045*1i;
% t12119 = -0.0031*1i/zc;


%%
z = 6;
%% changed after checking original parameters by Kreisel
t1111 = 0.086/z + 0.0005;

t1016 = -0.063/z -0.0211;
%% changed after checking original parameters by Kreisel
t2011 = -0.028/z + 0.00283;

t2116 = 0.017/z;
t1113 = -0.056*1i/z;
%% changed after checking original parameters by Kreisel
t1018 = 0.305*1i/z + 0.07625*1i;

t1115 = -0.109/z;
%% changed after checking original parameters by Kreisel
t1027 = -0.412/z + 0.02289;

%% changed after checking original parameters by Kreisel
t1122 = -0.066/z + 0.0037;

t1029 = -0.364*1i/z - 0.034*1i;
t1123 = 0.089*1i/z;
%% changed after checking original parameters by Kreisel
t102ten = 0.338/z - 0.01877;

t1133 = 0.232/z;
%% changed after checking original parameters by Kreisel
t1038 = 0.080/z + 0.00344;

t2033 = 0.009/z;
t2138 = 0.016/z;
t0233 = -0.045/z;
%% changed after checking original parameters by Kreisel
t1049 = 0.311/z + 0.01224;

t2233 = 0.027/z;
t2149 = -0.019/z;
t1134 = 0.099/z;
t104ten = 0.180*1i/z;
t1135 = 0.146*1i/z;

%%
% po2 = -0.04;
% po3 = -0.025;
% po4 = 0.005;
% po1 = -0.04;
po1 = 0.0225;
po2 = 0.0225;
po3 = 0.0225;
po4 = 0.0225;
% po3 = 0;
% po4 = 0;
po5 = 0.0225;

%% changed after checking original parameters by Kreisel
% e1 = 0.014/z -0.0004 + po1;
e1 = -0.0204698 +po1;
%% changed after checking original parameters by Kreisel
% e2 = -0.539/z + 0.0299 + po2;
e2 = -0.00615695 + po2;
%% changed after checking original parameters by Kreisel
% e3 = 0.020/z -0.000043 + po3;
e3 = -0.01169006 + po3;
%% changed after checking original parameters by Kreisel
% e4 = 0.020/z -0.000043 + po4;
e4 = -0.01169006 + po4;
%% changed after checking original parameters by Kreisel
% e5 = -0.581/z +0.03224 + po5;
e5 = -0.06004106 + po5;
%% changed after checking original parameters by Kreisel
t10116 = 0 + 0.00275;

t00111 = 0;
t12116 = -0.017/z;
t11111 = 0;
t10118 = 0.009*1i/z;

%% changed after checking original parameters by Kreisel
t20111 = 0.017/z - 0.002753;

t10119 = 0.020*1i/z;
t20114 = 0.0030*1i/z + 0.0045*1i;
t12119 = -0.0031*1i/z;
t00133 = 0.011/z;
%% changed after checking original parameters by Kreisel
t10138 = 0.006/z + 0.00253;

t20133 = -0.008/z;
t12138 = -0.003/z;
t02133 = 0.020/z;
t10139 = 0.015/z;
%% changed after checking original parameters by Kreisel
t10149 = 0.025/z - 0.00203;

t12149 = 0.006/z;



%%








% s-wave orbital order
% oos = 0.0125;
% oos = 0.0096;
% d-wave orbital order through Se
oodse = 0.0;
% ood = -0.015;
% d-wave orbital order FeFe-bond
% oodfe = -0.0175;
% oodfe = -0.0089;
% spin orbit coupling
% soc = 0.01;
% soc = 0.02;
% a and b are to adjust for using imaginary orbitals
a = 1;
b = -1;

%% |xy,+> |xy,->, + <=> spin up, - <=> spin down


%% Hpp (H++) from suppl. inf. Mukherjee paper modified to include spin orbit
%% dxy
        %% Hpp (H++) from suppl. inf. Mukherjee paper
        %% |xy,+> |xy,+> + <=> spin up
        Hpp(1,1,1) = e1 + 2*t1111*( cos(p1)+ cos(p2) )+...
            2*t2011*( cos(2*px) + cos(2*py) )+...
            (2*t00111 + 4*t11111 * ( cos(p1)+ cos(p2)) + 4*t20111 * ...
            (cos(2*px) + cos(2*py)))* cos(kz);

        %% |xy,-> |xy,-> - <=> spin down
        Hpp(2,2,1) = e1 + 2*t1111*( cos(p1)+ cos(p2) )+...
            2*t2011*( cos(2*p1) + cos(2*p2) )+...
            (2*t00111 + 4*t11111 * ( cos(p1)+ cos(p2)) + 4*t20111 * ...
            (cos(2*px) + cos(2*py)))* cos(kz);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |xy,->
        Hpp(1,2,1) = 0;
        
        Hpp(2,1,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |x^2-y^2,+>
        Hpp(1,3,1) = 1i*soc;
        
        Hpp(3,1,1) = conj(Hpp(1,3,1));
        
        %% |xy,-> |x^2-y^2,+>
        Hpp(2,3,1) = 0;
        
        Hpp(3,2,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |x^2-Y^2,->
        Hpp(1,4,1) = 0;
        
        Hpp(4,1,1) = 0;
        
        %% |xy,-> |x^2-y^2,->
%         Hpp(2,4,1) = 1i*soc;
        Hpp(2,4,1) = -1i*soc;
        Hpp(4,2,1) = conj(Hpp(2,4,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |xz,+>
        Hpp(1,5,1) = 2*1i*t1113 * (sin(p1) - sin(p2)) - ...
            4*t20114 * sin(2*py)*sin(kz);
        
        Hpp(5,1,1) = conj(Hpp(1,5,1));
        
        %% |xy,-> |xz,+>
%         Hpp(2,5,1) = 1i*soc/2*1i*a;
        Hpp(2,5,1) = -1i*soc/2*1i*a;
        Hpp(5,2,1) = conj(Hpp(2,5,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |xz,->
        Hpp(1,6,1) = -1i*soc/2*1i*a;
        
        Hpp(6,1,1) = conj(Hpp(1,6,1));
        
        %% |xy,-> |xz,->
        Hpp(2,6,1) = 2*1i*t1113 * (sin(p1) - sin(p2)) - ...
            4*t20114 * sin(2*py)*sin(kz);
        
        Hpp(6,2,1) = conj(Hpp(2,6,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |yz,+>
        Hpp(1,7,1) = 2*1i*t1113 * (sin(p1) + sin(p2)) - ...
            4*t20114 * sin(2*px) * sin(kz);
        
        Hpp(7,1,1) = conj(Hpp(1,7,1));
        
        %% |xy,-> |yz,+>
        Hpp(2,7,1) = soc/2*1i*a;
        
        Hpp(7,2,1) = conj(Hpp(2,7,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |yz,->
%         Hpp(1,8,1) = soc/2*1i*a;
        Hpp(1,8,1) = -soc/2*1i*a;
        Hpp(8,1,1) = conj(Hpp(1,8,1));
        
        %% |xy,-> |yz,->
        Hpp(2,8,1) = 2*1i*t1113 * (sin(p1) + sin(p2)) - ...
            4*t20114 * sin(2*px) * sin(kz);
        
        Hpp(8,2,1) = conj(Hpp(2,8,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |z^2,+>
        Hpp(1,9,1) = 2*t1115 * (cos(p1) - cos(p2));
        
        Hpp(9,1,1) = conj(Hpp(1,9,1));
        
        %% |xy,-> |z^2,+>
        Hpp(2,9,1) = 0;
        
        Hpp(9,2,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |z^2,->
        Hpp(1,10,1) = 0;
        
        Hpp(10,1,1) = 0;
        
        %% |xy,-> |z^2,->
        Hpp(2,10,1) = 2*t1115 * (cos(p1) - cos(p2));
        
        Hpp(10,2,1) = conj(Hpp(2,10,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |x^2-y^2,+>
        Hpp(3,3,1) = e2 + 2*t1122 * (cos(p1) + cos(p2));
        
        %% |x^2-y^2,-> |x^2-y^2,->
        Hpp(4,4,1) = e2 + 2*t1122 * (cos(p1) + cos(p2));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |x^2-Y^2,->
        Hpp(3,4,1) = 0;
        
        Hpp(4,3,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |xz,+>
        Hpp(3,5,1) = 2*1i*t1123 * (sin(p1) + sin(p2));
        
        Hpp(5,3,1) = conj(Hpp(3,5,1));
        
        %% |x^2-y^2,-> |xz,+>
        Hpp(4,5,1) = soc/2*1i*a;
        
        Hpp(5,4,1) = conj(Hpp(4,5,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |xz,->
%         Hpp(3,6,1) = soc/2*1i*a;
        Hpp(3,6,1) = -soc/2*1i*a;
        Hpp(6,3,1) = conj(Hpp(3,6,1));
        
        %% |x^2-Y^2,-> |xz,->
        Hpp(4,6,1) = 2*1i*t1123 * (sin(p1) + sin(p2));
        
        Hpp(6,4,1) = conj(Hpp(4,6,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |yz,+>
        Hpp(3,7,1) = 2*1i*t1123 * (-sin(p1) + sin(p2));
        
        Hpp(7,3,1) = conj(Hpp(3,7,1));
        
        %% |x^2-y^2,-> |yz,+>
%         Hpp(4,7,1) = -1i*soc/2*1i*a;
        Hpp(4,7,1) = 1i*soc/2*1i*a;
        Hpp(7,4,1) = conj(Hpp(4,7,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |yz,->
        Hpp(3,8,1) = 1i*soc/2*1i*a;
        
        Hpp(8,3,1) = conj(Hpp(3,8,1));
        
        %% |x^2-y^2,-> |yz,->
        Hpp(4,8,1) = 2*1i*t1123 * (-sin(p1) + sin(p2));
        
        Hpp(8,4,1) = conj(Hpp(4,8,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |z^2,+>
        Hpp(3,9,1) = 0;
        
        Hpp(9,3,1) = 0;
        
        %% |x^2-y^2,-> |z^2,+>
        Hpp(4,9,1) = 0;
        
        Hpp(9,4,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |z^2,->
        Hpp(3,10,1) = 0;
        
        Hpp(10,3,1) = 0;
        
        %% |x^2-y^2,-> |z^2,->
        Hpp(4,10,1) = 0;
        
        Hpp(10,4,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |xz,+>
        Hpp(5,5,1) = e3 + 2*t1133 * (cos(p1) + cos(p2)) +...
            2*t2033 * cos(2*px) + 2*t0233 * cos(2*py) +...
            4*t2233 *cos(2*px)*cos(2*py)+...
            (2*t00133 + 4*t20133 *cos(2*px) + 4*t02133 *cos(2*py))*cos(kz) -...
            oos + oodse * ( cos(p1) - cos(p2) );
        
        %% |xz,-> |xz,->
        Hpp(6,6,1) = e3 + 2*t1133 * (cos(p1) + cos(p2)) +...
            2*t2033 * cos(2*px) + 2*t0233 * cos(2*py) +...
            4*t2233 *cos(2*px)*cos(2*py)+...
            (2*t00133 + 4*t20133 *cos(2*px) + 4*t02133 *cos(2*py))*cos(kz) -...
            oos + oodse * ( cos(p1) - cos(p2) );
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |xz,->
        Hpp(5,6,1) = 0;
        
        Hpp(6,5,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |yz,+>
        Hpp(5,7,1) = 2*t1134 * (cos(p1) - cos(p2)) -1i*soc/2;
        
        Hpp(7,5,1) = conj(Hpp(5,7,1));
        
        %% |xz,-> |yz,+>
        Hpp(6,7,1) = 0;
        
        Hpp(7,6,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |yz,->
        Hpp(5,8,1) = 0;
        
        Hpp(8,5,1) = 0;
        
        %% |xz,-> |yz,->
%         Hpp(6,8,1) = 2*t1134 * (cos(p1) - cos(p2)) -1i*soc/2;
        Hpp(6,8,1) = 2*t1134 * (cos(p1) - cos(p2)) +1i*soc/2;
        Hpp(8,6,1) = conj(Hpp(6,8,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |z^2,+>
        Hpp(5,9,1) = 2*1i*t1135 * (sin(p1) + sin(p2));
        
        Hpp(9,5,1) = conj(Hpp(5,9,1));
        
        %% |xz,-> |z^2,+>
        Hpp(6,9,1) = sqrt(3)/2*soc*1i*b;
        
        Hpp(9,6,1) = conj(Hpp(6,9,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |z^2,->
%         Hpp(5,10,1) = sqrt(3)/2*soc*1i*b;
        Hpp(5,10,1) = -sqrt(3)/2*soc*1i*b;
        Hpp(10,5,1) = conj(Hpp(5,10,1));
        
        %% |xz,-> |z^2,->
        Hpp(6,10,1) = 2*1i*t1135 * (sin(p1) + sin(p2));
        
        Hpp(10,6,1) = conj(Hpp(6,10,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+> |yz,+>
        Hpp(7,7,1) = e4 + 2*t1133 * (cos(p1) + cos(p2)) +...
            2*t0233 * cos(2*px) +2*t2033 * cos(2*py) +...
            4*t2233 * cos(2*px) * cos(2*py) +...
            (2*t00133 + 4*t02133 * cos(2*px)+4*t20133 * cos(2*py))*cos(kz) +...
            oos + oodse * ( cos(p1) - cos(p2) );
        
        %% |yz,-> |yz,->
        Hpp(8,8,1) = e4 + 2*t1133 * (cos(p1) + cos(p2)) +...
            2*t0233 * cos(2*px) +2*t2033 * cos(2*py) +...
            4*t2233 * cos(2*px) * cos(2*py) +...
            (2*t00133 + 4*t02133 * cos(2*px)+4*t20133 * cos(2*py))*cos(kz) +...
            oos + oodse * ( cos(p1) - cos(p2) );
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+> |yz,->
        Hpp(7,8,1) = 0;
        
        Hpp(8,7,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+> |z^2,+>
        Hpp(7,9,1) = 2*1i*t1135 * (sin(p1) - sin(p2));
        
        Hpp(9,7,1) = conj(Hpp(7,9,1));
        
        %% |yz,-> |z^2,+>
%         Hpp(8,9,1) = 1i*soc*sqrt(3)/2*1i*b;
        Hpp(8,9,1) = -1i*soc*sqrt(3)/2*1i*b;
        Hpp(9,8,1) = conj(Hpp(8,9,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+> |z^2,->
        Hpp(7,10,1) = -1i*soc*sqrt(3)/2*1i*b;
        
        Hpp(10,7,1) = conj(Hpp(7,10,1));
        
        %% |yz,-> |z^2,->
        Hpp(8,10,1) = 2*1i*t1135 * (sin(p1) - sin(p2));
        
        Hpp(10,8,1) = conj(Hpp(8,10,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |z^2,+> |z^2,+>
        Hpp(9,9,1) = e5;
        
        %% |z^2,-> |z^2,->
        Hpp(10,10,1) = e5;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |z^2,+> |z^2,->
        Hpp(9,10,1) = 0;
        
        Hpp(10,9,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%
        
        
        %% Hpp (H++) from suppl. inf. Mukherjee paper modified to include spin orbit
%% dxy
        %% Hpp (H++) from suppl. inf. Mukherjee paper
        %% |xy,+> |xy,+> + <=> spin up
        Hppsoc(1,1,1) = conj( e1 + 2*t1111*( cos(p1)+ cos(p2) )+...
            2*t2011*( cos(2*px) + cos(2*py) )+...
            (2*t00111 + 4*t11111 * ( cos(p1)+ cos(p2)) + 4*t20111 * ...
            (cos(2*px) + cos(2*py)))* cos(kz) );

        %% |xy,-> |xy,-> - <=> spin down
        Hppsoc(2,2,1) = conj( e1 + 2*t1111*( cos(p1)+ cos(p2) )+...
            2*t2011*( cos(2*p1) + cos(2*p2) )+...
            (2*t00111 + 4*t11111 * ( cos(p1)+ cos(p2)) + 4*t20111 * ...
            (cos(2*px) + cos(2*py)))* cos(kz) );
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |xy,->
        Hppsoc(1,2,1) = 0;
        
        Hppsoc(2,1,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |x^2-y^2,+>
        Hppsoc(1,3,1) = 1i*soc;
        
        Hppsoc(3,1,1) = conj(Hppsoc(1,3,1));
        
        %% |xy,-> |x^2-y^2,+>
        Hppsoc(2,3,1) = 0;
        
        Hppsoc(3,2,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |x^2-Y^2,->
        Hppsoc(1,4,1) = 0;
        
        Hppsoc(4,1,1) = 0;
        
        %% |xy,-> |x^2-y^2,->
%         Hppsoc(2,4,1) = 1i*soc;
        Hppsoc(2,4,1) = -1i*soc;
        Hppsoc(4,2,1) = conj(Hppsoc(2,4,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |xz,+>
        Hppsoc(1,5,1) = conj( 2*1i*t1113 * (sin(p1) - sin(p2)) - ...
            4*t20114 * sin(2*py)*sin(kz) );
        
        Hppsoc(5,1,1) = conj(Hppsoc(1,5,1));
        
        %% |xy,-> |xz,+>
%         Hppsoc(2,5,1) = 1i*soc/2*1i*-a;
        Hppsoc(2,5,1) = -1i*soc/2*1i*-a;
        Hppsoc(5,2,1) = conj(Hppsoc(2,5,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |xz,->
        Hppsoc(1,6,1) = -1i*soc/2*1i*-a;
        
        Hppsoc(6,1,1) = conj(Hppsoc(1,6,1));
        
        %% |xy,-> |xz,->
        Hppsoc(2,6,1) = conj( 2*1i*t1113 * (sin(p1) - sin(p2)) - ...
            4*t20114 * sin(2*py)*sin(kz) );
        
        Hppsoc(6,2,1) = conj(Hppsoc(2,6,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |yz,+>
        Hppsoc(1,7,1) = conj( 2*1i*t1113 * (sin(p1) + sin(p2)) - ...
            4*t20114 * sin(2*px) * sin(kz) );
        
        Hppsoc(7,1,1) = conj(Hppsoc(1,7,1));
        
        %% |xy,-> |yz,+>
        Hppsoc(2,7,1) = soc/2*1i*-a;
        
        Hppsoc(7,2,1) = conj(Hppsoc(2,7,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |yz,->
%         Hppsoc(1,8,1) = soc/2*1i*-a;
        Hppsoc(1,8,1) = -soc/2*1i*-a;
        Hppsoc(8,1,1) = conj(Hppsoc(1,8,1));
        
        %% |xy,-> |yz,->
        Hppsoc(2,8,1) = conj( 2*1i*t1113 * (sin(p1) + sin(p2)) - ...
            4*t20114 * sin(2*px) * sin(kz) );
        
        Hppsoc(8,2,1) = conj(Hppsoc(2,8,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |z^2,+>
        Hppsoc(1,9,1) = conj( 2*t1115 * (cos(p1) - cos(p2)) );
        
        Hppsoc(9,1,1) = conj(Hppsoc(1,9,1));
        
        %% |xy,-> |z^2,+>
        Hppsoc(2,9,1) = 0;
        
        Hppsoc(9,2,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+> |z^2,->
        Hppsoc(1,10,1) = 0;
        
        Hppsoc(10,1,1) = 0;
        
        %% |xy,-> |z^2,->
        Hppsoc(2,10,1) = conj( 2*t1115 * (cos(p1) - cos(p2)) );
        
        Hppsoc(10,2,1) = conj(Hppsoc(2,10,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |x^2-y^2,+>
        Hppsoc(3,3,1) = conj( e2 + 2*t1122 * (cos(p1) + cos(p2)) );
        
        %% |x^2-y^2,-> |x^2-y^2,->
        Hppsoc(4,4,1) = conj( e2 + 2*t1122 * (cos(p1) + cos(p2)) );
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |x^2-Y^2,->
        Hppsoc(3,4,1) = 0;
        
        Hppsoc(4,3,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |xz,+>
        Hppsoc(3,5,1) = conj( 2*1i*t1123 * (sin(p1) + sin(p2)) );
        
        Hppsoc(5,3,1) = conj(Hppsoc(3,5,1));
        
        %% |x^2-y^2,-> |xz,+>
        Hppsoc(4,5,1) = soc/2*1i*-a;
        
        Hppsoc(5,4,1) = conj(Hppsoc(4,5,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |xz,->
%         Hppsoc(3,6,1) = soc/2*1i*-a;
        Hppsoc(3,6,1) = -soc/2*1i*-a;
        Hppsoc(6,3,1) = conj(Hppsoc(3,6,1));
        
        %% |x^2-Y^2,-> |xz,->
        Hppsoc(4,6,1) = conj( 2*1i*t1123 * (sin(p1) + sin(p2)) );
        
        Hppsoc(6,4,1) = conj(Hppsoc(4,6,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |yz,+>
        Hppsoc(3,7,1) = conj( 2*1i*t1123 * (-sin(p1) + sin(p2)) );
        
        Hppsoc(7,3,1) = conj(Hppsoc(3,7,1));
        
        %% |x^2-y^2,-> |yz,+>
%         Hppsoc(4,7,1) = -1i*soc/2*1i*-a;
        Hppsoc(4,7,1) = 1i*soc/2*1i*-a;
        Hppsoc(7,4,1) = conj(Hppsoc(4,7,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |yz,->
        Hppsoc(3,8,1) = 1i*soc/2*1i*-a;
        
        Hppsoc(8,3,1) = conj(Hppsoc(3,8,1));
        
        %% |x^2-y^2,-> |yz,->
        Hppsoc(4,8,1) = conj( 2*1i*t1123 * (-sin(p1) + sin(p2)) );
        
        Hppsoc(8,4,1) = conj(Hppsoc(4,8,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |z^2,+>
        Hppsoc(3,9,1) = 0;
        
        Hppsoc(9,3,1) = 0;
        
        %% |x^2-y^2,-> |z^2,+>
        Hppsoc(4,9,1) = 0;
        
        Hppsoc(9,4,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+> |z^2,->
        Hppsoc(3,10,1) = 0;
        
        Hppsoc(10,3,1) = 0;
        
        %% |x^2-y^2,-> |z^2,->
        Hppsoc(4,10,1) = 0;
        
        Hppsoc(10,4,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |xz,+>
        Hppsoc(5,5,1) = conj( e3 + 2*t1133 * (cos(p1) + cos(p2)) +...
            2*t2033 * cos(2*px) + 2*t0233 * cos(2*py) +...
            4*t2233 *cos(2*px)*cos(2*py)+...
            (2*t00133 + 4*t20133 *cos(2*px) + 4*t02133 *cos(2*py))*cos(kz) +...
            oos + oodse * ( cos(p1) - cos(p2) ) );
        
        %% |xz,-> |xz,->
        Hppsoc(6,6,1) = conj( e3 + 2*t1133 * (cos(p1) + cos(p2)) +...
            2*t2033 * cos(2*px) + 2*t0233 * cos(2*py) +...
            4*t2233 *cos(2*px)*cos(2*py)+...
            (2*t00133 + 4*t20133 *cos(2*px) + 4*t02133 *cos(2*py))*cos(kz) +...
            oos + oodse * ( cos(p1) - cos(p2) ) );
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |xz,->
        Hppsoc(5,6,1) = 0;
        
        Hppsoc(6,5,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |yz,+>
        Hppsoc(5,7,1) = conj( 2*t1134 * (cos(p1) - cos(p2)) ) -1i*soc/2;
        
        Hppsoc(7,5,1) = conj(Hppsoc(5,7,1));
        
        %% |xz,-> |yz,+>
        Hppsoc(6,7,1) = 0;
        
        Hppsoc(7,6,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |yz,->
        Hppsoc(5,8,1) = 0;
        
        Hppsoc(8,5,1) = 0;
        
        %% |xz,-> |yz,->
%         Hppsoc(6,8,1) = conj( 2*t1134 * (cos(p1) - cos(p2)) ) -1i*soc/2;
        Hppsoc(6,8,1) = conj( 2*t1134 * (cos(p1) - cos(p2)) ) +1i*soc/2;
        Hppsoc(8,6,1) = conj(Hppsoc(6,8,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |z^2,+>
        Hppsoc(5,9,1) = conj( 2*1i*t1135 * (sin(p1) + sin(p2)) );
        
        Hppsoc(9,5,1) = conj(Hppsoc(5,9,1));
        
        %% |xz,-> |z^2,+>
        Hppsoc(6,9,1) = sqrt(3)/2*soc*1i*-b;
        
        Hppsoc(9,6,1) = conj(Hppsoc(6,9,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+> |z^2,->
%         Hppsoc(5,10,1) = sqrt(3)/2*soc*1i*-b;
        Hppsoc(5,10,1) = -sqrt(3)/2*soc*1i*-b;
        Hppsoc(10,5,1) = conj(Hppsoc(5,10,1));
        
        %% |xz,-> |z^2,->
        Hppsoc(6,10,1) = conj( 2*1i*t1135 * (sin(p1) + sin(p2)) );
        
        Hppsoc(10,6,1) = conj(Hppsoc(6,10,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+> |yz,+>
        Hppsoc(7,7,1) = conj( e4 + 2*t1133 * (cos(p1) + cos(p2)) +...
            2*t0233 * cos(2*px) +2*t2033 * cos(2*py) +...
            4*t2233 * cos(2*px) * cos(2*py) +...
            (2*t00133 + 4*t02133 * cos(2*px)+4*t20133 * cos(2*py))*cos(kz) -...
            oos + oodse * ( cos(p1) - cos(p2) ) );
        
        %% |yz,-> |yz,->
        Hppsoc(8,8,1) = conj( e4 + 2*t1133 * (cos(p1) + cos(p2)) +...
            2*t0233 * cos(2*px) +2*t2033 * cos(2*py) +...
            4*t2233 * cos(2*px) * cos(2*py) +...
            (2*t00133 + 4*t02133 * cos(2*px)+4*t20133 * cos(2*py))*cos(kz) -...
            oos + oodse * ( cos(p1) - cos(p2) ) );
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+> |yz,->
        Hppsoc(7,8,1) = 0;
        
        Hppsoc(8,7,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+> |z^2,+>
        Hppsoc(7,9,1) = conj( 2*1i*t1135 * (sin(p1) - sin(p2)) );
        
        Hppsoc(9,7,1) = conj(Hppsoc(7,9,1));
        
        %% |yz,-> |z^2,+>
%         Hppsoc(8,9,1) = 1i*soc*sqrt(3)/2*1i*-b;
        Hppsoc(8,9,1) = -1i*soc*sqrt(3)/2*1i*-b;
        Hppsoc(9,8,1) = conj(Hppsoc(8,9,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+> |z^2,->
        Hppsoc(7,10,1) = -1i*soc*sqrt(3)/2*1i*-b;
        
        Hppsoc(10,7,1) = conj(Hppsoc(7,10,1));
        
        %% |yz,-> |z^2,->
        Hppsoc(8,10,1) = conj( 2*1i*t1135 * (sin(p1) - sin(p2)) );
        
        Hppsoc(10,8,1) = conj(Hppsoc(8,10,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |z^2,+> |z^2,+>
        Hppsoc(9,9,1) = conj( e5 );
        
        %% |z^2,-> |z^2,->
        Hppsoc(10,10,1) = conj( e5 );
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |z^2,+> |z^2,->
        Hppsoc(9,10,1) = 0;
        
        Hppsoc(10,9,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%
        
        
        
        %% |xy,+,1> |xy,+,2>  1 and 2 are the 2 Fe-positions
        %%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Hpm (H+-) from suppl. inf. Mukherjee paper modified to inclide soc
%         Hpm(1,1,1) = 100 +100 * 1i;
        %% |xy,+,1> |xy,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(1,1,1) = 2*t1016 * (cos(px) + cos(py))+...
            2*t2116 * ( (cos(p1)+cos(p2))*(cos(px)+cos(py)) - ...
            sin(p1) *(sin(px)+sin(py)) + sin(p2) *(sin(px)-sin(py)) ) +...
            4*t10116 * (cos(px) + cos(py))*cos(kz) +...
            2*t12116 * ( (cos(p1+py)+cos(p1+px)) *exp(1i*kz) +...
            (cos(p2+py) + cos(p2-px)) * exp(-1i*kz) );
        
        %% |xy,-,1> |xy,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(2,2,1) = 2*t1016 * (cos(px) + cos(py))+...
            2*t2116 * ( (cos(p1)+cos(p2))*(cos(px)+cos(py)) - ...
            sin(p1) *(sin(px)+sin(py)) + sin(p2) *(sin(px)-sin(py)) ) +...
            4*t10116 * (cos(px) + cos(py))*cos(kz) +...
            2*t12116 * ( (cos(p1+py)+cos(p1+px)) *exp(1i*kz) +...
            (cos(p2+py) + cos(p2-px)) * exp(-1i*kz) );
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+,1> |xy,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(1,2,1) = 0;
        
        Hpm(2,1,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+,1> |x^2-y^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(1,3,1) = 0;
        
        Hpm(3,1,1) = 0;
        
        %% |xy,-,1> |x^2-y^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(2,3,1) = 0;
        
        Hpm(3,2,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+,1> |x^2-y^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(1,4,1) = 0;
        
        Hpm(4,1,1) = 0;
        
        %% |xy,-,1> |x^2-y^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(2,4,1) = 0;
        
        Hpm(4,2,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+,1> |xz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(1,5,1) = 2*1i*t1018 *sin(px) -...
            4*(t10118 * sin(px) + t10119 * sin(py))*sin(kz) +...
            2*1i*t12119 *(sin(p1+py)*exp(1i*kz)-sin(p2+py)*exp(-1i*kz));
        
        Hpm(5,1,1) = conj(Hpm(1,5,1));
        
        %% |xy,-,1> |xz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(2,5,1) = 0;
        
        Hpm(5,2,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+,1> |xz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(1,6,1) = 0;
        
        Hpm(6,1,1) = 0;
        
        %% |xy,-,1> |xz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(2,6,1) = 2*1i*t1018 *sin(px) -...
            4*(t10118 * sin(px) + t10119 * sin(py))*sin(kz) +...
            2*1i*t12119 *(sin(p1+py)*exp(1i*kz)-sin(p2+py)*exp(-1i*kz));
        
        Hpm(6,2,1) = conj(Hpm(2,6,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+,1> |yz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(1,7,1) = 2*1i*t1018 * sin(py) -...
            4*(t10119 * sin(px) +t10118 * sin(py))* sin(kz) +...
            2*1i*t12119 *( sin(p1+px)*exp(1i*kz)+sin(p2-px)*exp(-1i*kz) );
        
        Hpm(7,1,1) = conj(Hpm(1,7,1));
        
        %% |xy,-,1> |yz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(2,7,1) = 0;
        
        Hpm(7,2,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+,1> |yz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(1,8,1) = 0;
        
        Hpm(8,1,1) = 0;
        
        %% |xy,-,1> |yz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(2,8,1) = 2*1i*t1018 * sin(py) -...
            4*(t10119 * sin(px) +t10118 * sin(py))* sin(kz) +...
            2*1i*t12119 *( sin(p1+px)*exp(1i*kz)+sin(p2-px)*exp(-1i*kz) );
        
        Hpm(8,2,1) = conj(Hpm(2,8,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+,1> |z^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(1,9,1) = 0;
        
        Hpm(9,1,1) = 0;
        
        %% |xy,-,1> |z^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(2,9,1) = 0;
        
        Hpm(9,2,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xy,+,1> |z^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(1,10,1) = 0;
        
        Hpm(10,1,1) = 0;
        
        %% |xy,-,1> |z^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(2,10,1) = 0;
        
        Hpm(10,2,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+,1> |x^2-y^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(3,3,1) = 2*t1027 * (cos(px) + cos(py));
        
        %% |x^2-y^2,-,1> |x^2-y^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(4,4,1) = 2*t1027 * (cos(px) + cos(py));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+,1> |x^2-y^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(3,4,1) = 0;
        
        Hpm(4,3,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+,1> |xz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(3,5,1) = -2*1i*t1029 * sin(py);
        
        Hpm(5,3,1) = conj(Hpm(3,5,1));
        
        %% |x^2-y^2,-,1> |xz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(4,5,1) = 0;
        
        Hpm(5,4,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+,1> |xz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(3,6,1) = 0;
        
        Hpm(6,3,1) = 0;
        
        %% |x^2-y^2,-,1> |xz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(4,6,1) = -2*1i*t1029 * sin(py);
        
        Hpm(6,4,1) = conj(Hpm(4,6,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+,1> |yz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(3,7,1) = 2*1i*t1029 * sin(px);
        
        Hpm(7,3,1) = conj(Hpm(3,7,1));
        
        %% |x^2-y^2,-,1> |yz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(4,7,1) = 0;
        
        Hpm(7,4,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+,1> |yz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(3,8,1) = 0;
        
        Hpm(8,3,1) = 0;
        
        %% |x^2-y^2,-,1> |yz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(4,8,1) = 2*1i*t1029 * sin(px);
        
        Hpm(8,4,1) = conj(Hpm(4,8,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+,1> |z^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(3,9,1) = 2*t102ten *(cos(px) - cos(py));
        
        Hpm(9,3,1) = conj(Hpm(3,9,1));
        
        %% |x^2-y^2,-,1> |z^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(4,9,1) = 0;
        
        Hpm(9,4,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |x^2-y^2,+,1> |z^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(3,10,1) = 0;
        
        Hpm(10,3,1) = 0;
        
        %% |x^2-y^2,-,1> |z^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(4,10,1) = 2*t102ten *(cos(px) - cos(py));
        
        Hpm(10,4,1) = conj(Hpm(4,10,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+,1> |xz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(5,5,1) = 2*t1038 *cos(px) + 2*t1049 *cos(py) +...
            2*t2138 *( (cos(p1)+cos(p2))*cos(px) - (sin(p1)-sin(p2)) *...
            sin(px) ) +...
            2*t2149 *( (cos(p1)+cos(p2))*cos(py) - (sin(p1)+sin(p2)) *...
            sin(py) )+...
            4*(t10138 *cos(px) + t10149 * cos(py) )*cos(kz) +...
            2*t12138 *( cos(p1+px)*exp(1i*kz) + cos(p2-px)*exp(-1i*kz) )+...
            2*t12149 *( cos(p1+py)*exp(1i*kz) + cos(p2+py)*exp(-1i*kz) ) -...
            oodfe * ( cos(px) + cos(py) );
        
        %% |xz,-,1> |xz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(6,6,1) = 2*t1038 *cos(px) + 2*t1049 *cos(py) +...
            2*t2138 *( (cos(p1)+cos(p2))*cos(px) - (sin(p1)-sin(p2)) *...
            sin(px) ) +...
            2*t2149 *( (cos(p1)+cos(p2))*cos(py) - (sin(p1)+sin(p2)) *...
            sin(py) )+...
            4*(t10138 *cos(px) + t10149 * cos(py) )*cos(kz) +...
            2*t12138 *( cos(p1+px)*exp(1i*kz) + cos(p2-px)*exp(-1i*kz) )+...
            2*t12149 *( cos(p1+py)*exp(1i*kz) + cos(p2+py)*exp(-1i*kz) ) -...
            oodfe * ( cos(px) + cos(py) );
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+,1> |xz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(5,6,1) = 0;
        
        Hpm(6,5,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+,1> |yz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(5,7,1) = 4*1i* t10139 * (cos(px) + cos(py)) * sin(kz);
        
        Hpm(7,5,1) = conj(Hpm(5,7,1));
        
        %% |xz,-,1> |yz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(6,7,1) = 0;
        
        Hpm(7,6,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+,1> |yz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(5,8,1) = 0;
        
        Hpm(8,5,1) = 0;
        
        %% |xz,-,1> |yz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(6,8,1) = 4*1i* t10139 * (cos(px) + cos(py)) * sin(kz);
        
        Hpm(8,6,1) = conj(Hpm(6,8,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+,1> |z^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(5,9,1) = 2*1i*t104ten *sin(py);
        
        Hpm(9,5,1) = conj(Hpm(5,9,1));
        
        %% |xz,-,1> |z^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(6,9,1) = 0;
        
        Hpm(9,6,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |xz,+,1> |z^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(5,10,1) = 0;
        
        Hpm(10,5,1) = 0;
        
        %% |xz,-,1> |z^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(6,10,1) = 2*1i*t104ten *sin(py);
        
        Hpm(10,6,1) = conj(Hpm(6,10,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+,1> |yz,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(7,7,1) = 2*t1049 * cos(px) + 2*t1038 * cos(py) +...
            2*t2149 *( (cos(p1)+cos(p2))*cos(px) - (sin(p1)-sin(p2)) *...
            sin(px) ) +...
            2*t2138 *( (cos(p1)+cos(p2))*cos(py) - (sin(p1)+sin(p2)) *...
            sin(py) ) +...
            4*(t10149 * cos(px) +t10138 *cos(py)) * cos(kz) +...
            2*t12149 *( cos(p1+px)*exp(1i*kz) + cos(p2-px)*exp(-1i*kz) )+...
            2*t12138 *(cos(p1+py)*exp(1i*kz) + cos(p2+py)*exp(-1i*kz) ) +...
            oodfe * ( cos(px) + cos(py) );
        
        %% |yz,-,1> |yz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(8,8,1) = 2*t1049 * cos(px) + 2*t1038 * cos(py) +...
            2*t2149 *( (cos(p1)+cos(p2))*cos(px) - (sin(p1)-sin(p2)) *...
            sin(px) ) +...
            2*t2138 *( (cos(p1)+cos(p2))*cos(py) - (sin(p1)+sin(p2)) *...
            sin(py) ) +...
            4*(t10149 * cos(px) +t10138 *cos(py)) * cos(kz) +...
            2*t12149 *( cos(p1+px)*exp(1i*kz) + cos(p2-px)*exp(-1i*kz) )+...
            2*t12138 *(cos(p1+py)*exp(1i*kz) + cos(p2+py)*exp(-1i*kz) ) +...
            oodfe * ( cos(px) + cos(py) );
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+,1> |yz,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(7,8,1) = 0;
        
        Hpm(8,7,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+,1> |z^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(7,9,1) = 2*1i*t104ten * sin(px);
        
        Hpm(9,7,1) = conj(Hpm(7,9,1));
        
        %% |yz,-,1> |z^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(8,9,1) = 0;
        
        Hpm(9,8,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |yz,+,1> |z^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(7,10,1) = 0;
        
        Hpm(10,7,1) = 0;
        
        %% |yz,-,1> |z^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(8,10,1) = 2*1i*t104ten * sin(px);
        
        Hpm(10,8,1) = conj(Hpm(8,10,1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |z^2,+,1> |z^2,+,2>  1 and 2 are the 2 Fe-positions
        Hpm(9,9,1) = 0;
        
        %% |z^2,-,1> |z^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(10,10,1) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% |z^2,+,1> |z^2,-,2>  1 and 2 are the 2 Fe-positions
        Hpm(9,10,1) = 0;
        
        Hpm(10,9,1) = 0;
         %%
        % assemble H
        H(1:10, 1:10, 1) = Hpp(:, :, 1);
        H(1:10, 11:20, 1) = Hpm(:, :, 1);
        H(11:20, 1:10, 1) = conj(Hpm(:,:,1));
        H(11:20, 11:20, 1) = Hppsoc(:,:,1);
        
        test=1;
        
end
        