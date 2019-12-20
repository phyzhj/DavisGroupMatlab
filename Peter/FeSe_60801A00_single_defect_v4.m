obj_60801a00_G_crop = clfdata;
obj_60801A00_T_crop = clftopo;
obj_60801A00_I_crop = clfidata;

obj_60801a00_F_crop = feenstra_map(obj_60801a00_G_crop, obj_60801A00_I_crop);


%% try to suppress atomic contrast
obj_60801a00_G_crop_FT = fourier_transform2d(  obj_60801a00_G_crop  ,'none','complex','ft');
obj_60801a00_F_crop_FT = fourier_transform2d(  obj_60801a00_F_crop  ,'none','complex','ft');

[nx, ny, nz] = size(obj_60801a00_F_crop_FT.map);

% mask = double( circle_mask( nx, 56, 56, 10 ) );

[X,Y]=meshgrid(1:1:nx,1:1:ny,1);
xdata(:,:,1)=X;
xdata(:,:,2)=Y;

 x0 = [1; 56; 7; 56; 7; 0; 0];

mask=twodgauss(x0,xdata);
figure, imagesc(mask)

repmask = repmat(mask, 1, 1, nz);

obj_60801a00_F_crop_FT.cpx_map = obj_60801a00_F_crop_FT.cpx_map .* repmask;
obj_60801a00_G_crop_FT.cpx_map = obj_60801a00_G_crop_FT.cpx_map .* repmask;

obj_60801a00_G_crop_filtered = fourier_transform2d(  obj_60801a00_G_crop_FT  ,'none','real','ift');
obj_60801a00_F_crop_filtered = fourier_transform2d(  obj_60801a00_F_crop_FT  ,'none','real','ift');

% background subtracted
obj_60801a00_G_crop_bs = polyn_subtract2(obj_60801a00_G_crop,0);
obj_60801a00_F_crop_bs = polyn_subtract2(obj_60801a00_F_crop,0);

obj_60801a00_G_crop_bs_FT = fourier_transform2d(  obj_60801a00_G_crop_bs  ,'sine','amplitude','ft');
obj_60801a00_F_crop_bs_FT = fourier_transform2d(  obj_60801a00_F_crop_bs  ,'sine','amplitude','ft');

% rotate
img = obj_60801a00_G_crop_bs_FT.map;
obj_60801a00_G_crop_bs_FT_rot = obj_60801a00_G_crop_bs_FT;
obj_60801a00_G_crop_bs_FT_rot.map = imrotate(img,-45,'crop');  

img = obj_60801a00_F_crop_bs_FT.map;
obj_60801a00_F_crop_bs_FT_rot = obj_60801a00_F_crop_bs_FT;
obj_60801a00_F_crop_bs_FT_rot.map = imrotate(img,-45,'crop'); 

% crop

obj_60801a00_G_crop_bs_FT_rot.map = obj_60801a00_G_crop_bs_FT_rot.map(41:71, 41:71, :);
obj_60801a00_G_crop_bs_FT_rot.r = obj_60801a00_G_crop_bs_FT_rot.r(41:71);

obj_60801a00_F_crop_bs_FT_rot.map = obj_60801a00_F_crop_bs_FT_rot.map(41:71, 41:71, :);
obj_60801a00_F_crop_bs_FT_rot.r = obj_60801a00_F_crop_bs_FT_rot.r(41:71);
%% calculate the real space FT from the simulation with equal quasiparticle weights

obj_allsim_JDOS.cpx_map = obj_allsim_JDOS.map;

[nx, ny, nz] = size(obj_allsim_JDOS.map);

obj_allsim_JDOS_rspace = fourier_transform2d(  obj_allsim_JDOS  ,'none','real','ift');

% 
for k = 1 : nz
    obj_allsim_JDOS_rspace.map(:,:,k) = ifftshift( obj_allsim_JDOS_rspace.map(:,:,k)  );
end

%% crop, interpolate, rotate, and interpolate in order to align defect
%% 60801A00 and the simulation to each other

% crop
obj_allsim_JDOS_rspace.map = obj_allsim_JDOS_rspace.map(150:228, 150:228, :);
obj_allsim_JDOS_rspace.r = obj_allsim_JDOS_rspace.r(1: (228-150)+1);

% interpolate
obj_allsim_JDOS_rspace_int = pix_dim(obj_allsim_JDOS_rspace,401);

% rotate
img = obj_allsim_JDOS_rspace_int.map;
obj_allsim_JDOS_rspace_int_rot = obj_allsim_JDOS_rspace_int;
obj_allsim_JDOS_rspace_int_rot.map = imrotate(img,45,'crop');    

% crop
obj_allsim_JDOS_rspace_int_rot.map = obj_allsim_JDOS_rspace_int_rot.map(165:237, 165:237, :);
obj_allsim_JDOS_rspace_int_rot.r = obj_allsim_JDOS_rspace_int_rot.r(1: (237-165)+1);

% interpolate
obj_allsim_JDOS_rspace_int_rot_int = pix_dim(obj_allsim_JDOS_rspace_int_rot,111);



%% calculate the real space FT from the simulation with equal quasiparticle weights

obj_allsim_JDOS_os.cpx_map = obj_allsim_JDOS_os.map;

[nx, ny, nz] = size(obj_allsim_JDOS_os.map);

obj_allsim_JDOS_os_rspace = fourier_transform2d(  obj_allsim_JDOS_os  ,'none','real','ift');

% 
for k = 1 : nz
    obj_allsim_JDOS_os_rspace.map(:,:,k) = ifftshift( obj_allsim_JDOS_os_rspace.map(:,:,k)  );
end


%% crop, interpolate, rotate, and interpolate in order to align defect
%% 60801A00 and the simulation to each other

% crop
obj_allsim_JDOS_os_rspace.map = obj_allsim_JDOS_os_rspace.map(150:228, 150:228, :);
obj_allsim_JDOS_os_rspace.r = obj_allsim_JDOS_os_rspace.r(1: (228-150)+1);

% interpolate
obj_allsim_JDOS_os_rspace_int = pix_dim(obj_allsim_JDOS_os_rspace,401);

% rotate
img = obj_allsim_JDOS_os_rspace_int.map;
obj_allsim_JDOS_os_rspace_int_rot = obj_allsim_JDOS_os_rspace_int;
obj_allsim_JDOS_os_rspace_int_rot.map = imrotate(img,45,'crop');    

% crop
obj_allsim_JDOS_os_rspace_int_rot.map = obj_allsim_JDOS_os_rspace_int_rot.map(165:237, 165:237, :);
obj_allsim_JDOS_os_rspace_int_rot.r = obj_allsim_JDOS_os_rspace_int_rot.r(1: (237-165)+1);

% interpolate
obj_allsim_JDOS_os_rspace_int_rot_int = pix_dim(obj_allsim_JDOS_os_rspace_int_rot,111);



%% repeat for simulation that contains high q

%% calculate the real space FT from the simulation with equal quasiparticle weights

obj_allsim_JDOS_wBZ.cpx_map = obj_allsim_JDOS_wBZ.map;

[nx, ny, nz] = size(obj_allsim_JDOS_wBZ.map);

obj_allsim_JDOS_wBZ_rspace = fourier_transform2d(  obj_allsim_JDOS_wBZ  ,'none','real','ift');

% 
for k = 1 : nz
    obj_allsim_JDOS_wBZ_rspace.map(:,:,k) = ifftshift( obj_allsim_JDOS_wBZ_rspace.map(:,:,k)  );
end

%% crop, interpolate, rotate, and interpolate in order to align defect
%% 60801A00 and the simulation to each other

% crop
obj_allsim_JDOS_wBZ_rspace.map = obj_allsim_JDOS_wBZ_rspace.map(76:226, 76:226, :);
obj_allsim_JDOS_wBZ_rspace.r = obj_allsim_JDOS_wBZ_rspace.r(1: (226-76)+1);

% interpolate
obj_allsim_JDOS_wBZ_rspace_int = pix_dim(obj_allsim_JDOS_wBZ_rspace,401);

% rotate
img = obj_allsim_JDOS_wBZ_rspace_int.map;
obj_allsim_JDOS_wBZ_rspace_int_rot = obj_allsim_JDOS_wBZ_rspace_int;
obj_allsim_JDOS_wBZ_rspace_int_rot.map = imrotate(img,45,'crop');    

% crop
obj_allsim_JDOS_wBZ_rspace_int_rot.map = obj_allsim_JDOS_wBZ_rspace_int_rot.map(164:238, 164:238, :);
obj_allsim_JDOS_wBZ_rspace_int_rot.r = obj_allsim_JDOS_wBZ_rspace_int_rot.r(1: (238-164)+1);

% interpolate
obj_allsim_JDOS_wBZ_rspace_int_rot_int = pix_dim(obj_allsim_JDOS_wBZ_rspace_int_rot,111);



%% calculate the real space FT from the simulation with equal quasiparticle weights

obj_allsim_JDOS_wBZ_os.cpx_map = obj_allsim_JDOS_wBZ_os.map;

[nx, ny, nz] = size(obj_allsim_JDOS_wBZ_os.map);

obj_allsim_JDOS_wBZ_os_rspace = fourier_transform2d(  obj_allsim_JDOS_wBZ_os  ,'none','real','ift');

% 
for k = 1 : nz
    obj_allsim_JDOS_wBZ_os_rspace.map(:,:,k) = ifftshift( obj_allsim_JDOS_wBZ_os_rspace.map(:,:,k)  );
end


%% crop, interpolate, rotate, and interpolate in order to align defect
%% 60801A00 and the simulation to each other

% crop
obj_allsim_JDOS_wBZ_os_rspace.map = obj_allsim_JDOS_wBZ_os_rspace.map(76:226, 76:226, :);
obj_allsim_JDOS_wBZ_os_rspace.r = obj_allsim_JDOS_wBZ_os_rspace.r(1: (226-76)+1);

% interpolate
obj_allsim_JDOS_wBZ_os_rspace_int = pix_dim(obj_allsim_JDOS_wBZ_os_rspace,401);

% rotate
img = obj_allsim_JDOS_wBZ_os_rspace_int.map;
obj_allsim_JDOS_wBZ_os_rspace_int_rot = obj_allsim_JDOS_wBZ_os_rspace_int;
obj_allsim_JDOS_wBZ_os_rspace_int_rot.map = imrotate(img,45,'crop');    

% crop
obj_allsim_JDOS_wBZ_os_rspace_int_rot.map = obj_allsim_JDOS_wBZ_os_rspace_int_rot.map(164:238, 164:238, :);
obj_allsim_JDOS_wBZ_os_rspace_int_rot.r = obj_allsim_JDOS_wBZ_os_rspace_int_rot.r(1: (238-164)+1);

% interpolate
obj_allsim_JDOS_wBZ_os_rspace_int_rot_int = pix_dim(obj_allsim_JDOS_wBZ_os_rspace_int_rot,111);


%%%%%%%%%%%%
%%%%%%%%%%%%%
%%%%%%%%%%%%
%% assemble all files in the +- 25 meV energy range for possible publication

% FT of many defects dI/dV
obj_60721a00_G_FT_pub = obj_60721a00_G_FT_all;


% FT of many defects dI/dV / I <=> FEENSTRA
obj_60721a00_F_FT_pub = obj_60721a00_K_FT_all;


% defect 60801 with atomic contrast, crop so that in center
obj_60801a00_G_pub = obj_60801a00_G_crop;


% defect 60801 without atomic contrast (Gaussian filter), crop so that in center
obj_60801a00_G_filtered_pub = obj_60801a00_G_crop_filtered;


% defect 60801 in q-space crop from -pi to +pi
obj_60801a00_G_pub_FT = obj_60801a00_G_crop_bs_FT_rot;


% FEENSTRA - defect 60801 with atomic contrast, crop so that in center
obj_60801a00_F_pub = obj_60801a00_F_crop;


% FEENSTRA - defect 60801 without atomic contrast (Gaussian filter), crop so that in center
obj_60801a00_F_filtered_pub = obj_60801a00_F_crop_filtered;


% FEENSTRA - defect 60801 in q-space crop from -pi to +pi
obj_60801a00_F_pub_FT = obj_60801a00_F_crop_bs_FT_rot;


% real space from T-matrix - equal quasiparticle weights
JDOS_rspace_pub = obj_allsim_JDOS_rspace_int_rot_int;


% real space from T-matrix - orbital selective quasiparticle weights
JDOS_rspace_os_pub = obj_allsim_JDOS_os_rspace_int_rot_int;


% real space from T-matrix - equal quasiparticle weights using -pi to +pi
JDOS_rspace_pi_pub = obj_allsim_JDOS_wBZ_rspace_int_rot_int;


% real space from T-matrix - orbital selective quasiparticle weights using -pi to +pi
JDOS_rspace_pi_os_pub = obj_allsim_JDOS_wBZ_os_rspace_int_rot_int;


% q-space from T-matrix - equal quasiparticle weights
JDOS_qspace_pub = obj_allsim_JDOS;


% q-space from T-matrix - orbital selective quasiparticle weights
JDOS_qspace_os_pub = obj_allsim_JDOS_os;


% q-space from T-matrix - equal quasiparticle weights -pi tp +pi
JDOS_qspace_wbz_pub = obj_allsim_JDOS_wBZ;


% q-space from T-matrix - orbital selective quasiparticle weights -pi to
% +pi
JDOS_qspace_wbz_os_pub = obj_allsim_JDOS_wBZ_os;



