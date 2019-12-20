function [prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(lfdata, lftopo, dco, cs, varargin)
% lfdata = LF corrected map
% lftopo = LF corrected topo
% dco = defect center coordinates
% cs = symmetrical crop size around defect center

if isempty(varargin)
    %% plot LF-corrected topo and cross for defect position
    p = 10;
%     change_color_of_STM_maps(lftopo.map,'no')
        figureset_img_plot(lftopo.map)
    hold on 
    plot(dco(1), dco(2),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);
    hold off
else
        ml = varargin{1};
        for i=1:length(ml)
            %% plot layers of map and cross for defect position
            p = 10;
            %change_color_of_STM_maps(lftopo.map(:,:,ml(i)),'no')
                figureset_img_plot(lftopo.map(:,:,m1(i)))
            hold on 
            plot(dco(1), dco(2),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);
            hold off
        end
end


%% using the exact double (not integer) pixel coordinates of the defect / Fe-atom 
%% perform a shift of the data to the origin for the purpose of the FT before 
%% cropping the fov

[nx, ny, nz] = size(lfdata.map);

if mod(nx, 2) == 0
    ndx = nx/2 + 1;
    ndy = ny/2 + 1;
else
    ndx = (nx-1)/2 + 1;
    ndy = (ny-1)/2 + 1;
end

% center / origin in integer pixel coordinates
cx = ndx;
cy = ndy;

% Create meshgrid 
[X,Y]=meshgrid(1:1:nx,1:1:ny,1);

xdata(:,:,1)=X;
xdata(:,:,2)=Y;

% using the exact coordinates of the defect compute the required shift from
% the center
gx = dco(1);
gy = dco(2);
sx = gx - cx;
sy = gy - cy;

%% if else structure depending on whether lftopo is actually a topo or not

% sfctx, sfcty, shift functions in Fourier space
sfctx = exp(1i*2*pi*sx/nx*(X-cx));
sfcty = exp(1i*2*pi*sy/ny*(Y-cx));
    
if isempty(varargin)
    fft_topo = ( fourier_transform2d_vb( ifftshift( lftopo.map ) ,'none','complex','ft') );

    figure, imagesc(real(fft_topo))
    axis image

    figure, imagesc(imag(fft_topo))
    axis image

    % compute shifted topo
    fft_topo = fft_topo .* sfctx .* sfcty;
    
    % compute the inverse FT back to real space
    sft_topo = fourier_transform2d_vb(fft_topo,'none','real','ift');
    figure, imagesc( sft_topo )
    axis image

    figure, imagesc( fftshift( sft_topo ) )
    axis image

    sft_topo = fftshift(sft_topo);
    
else
    % compute shifted layers of current map
    for k = 1 : nz
        fft_map2(:,:,k) = fourier_transform2d_vb( ifftshift( lftopo.map(:,:,k) ) ,'none','complex','ft');
        fft_map2(:,:,k) = fft_map2(:,:,k) .* sfctx .* sfcty;
    end

    for k = 1 : nz
        sft_map2(:,:,k) = fourier_transform2d_vb( fft_map2(:,:,k),'none','real','ift');
        sft_map2(:,:,k) = fftshift( sft_map2(:,:,k) );
    end
    
end

% compute shifted layers of conductance map
for k = 1 : nz
    fft_map(:,:,k) = fourier_transform2d_vb( ifftshift( lfdata.map(:,:,k) ) ,'none','complex','ft');
    fft_map(:,:,k) = fft_map(:,:,k) .* sfctx .* sfcty;
end

for k = 1 : nz
    sft_map(:,:,k) = fourier_transform2d_vb( fft_map(:,:,k),'none','real','ift');
    sft_map(:,:,k) = fftshift( sft_map(:,:,k) );
end



%% crop the LF corrected topo and map after the defect has been shifted to the 
%% center / origin for purpose of FT

% defect should now be exactly in center after having been shifted
dx = ndx;
dy = ndy;

% crop the shifted conductance map and topo or current map

cmap = sft_map(dx-cs : dx + cs, dy -cs : dy + cs, :);

if isempty(varargin)
    ctopo = sft_topo(dx-cs : dx + cs, dy -cs : dy + cs);
else
    cmap2 = sft_map2(dx-cs : dx + cs, dy -cs : dy + cs, :);
end


% compute the size of the cropped map
[nx, ny, nz] = size(cmap);

% compute the new center of cropped map
ndx = (nx-1)/2 + 1;
ndy = (ny-1)/2 + 1;

% plot shifted and cropped topo or chosen layers of current map, and a marker for the defect position

if isempty(varargin)
    %% plot topo and cross for defect position
    p = 10;
    %change_color_of_STM_maps(ctopo,'no')
        figureset_img_plot(ctopo)
    hold on 
    plot(ndx, ndy,'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);
    hold off
else
        ml = varargin{1};
        for i=1:length(ml)
            %% plot layers of curent map and cross for defect position
            p = 10;
            %change_color_of_STM_maps(cmap2(:,:,ml(i)),'no')
                figureset_img_plot(cmap2(:,:,ml(i)))
            hold on 
            plot(ndx, ndy,'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);
            hold off
        end
end
%% subtract the average background from the cropped conductance map, and from the cropped current map if used instead of topo

% compute the new real space position vector in Angstroem
rv = lftopo.r(1:nx);


clfdata = lfdata;
clftopo = lftopo;

clfdata.map = cmap;
clfdata.r = rv;

if isempty(varargin)
    clftopo.map = ctopo;
else 
    clftopo.map = cmap2;
end

clftopo.r = rv;


new_data=polyn_subtract2(clfdata,0);

cmap = new_data.map;

if isempty(varargin)
else
    new_data2=polyn_subtract2(clftopo,0);

    cmap2 = new_data2.map;
end
%%

% % energies of map
% ev = new_data.e;
% le = length(ev);
% 
% % Find the energy layer corresponding to the chemical potential if the
% % number of layers is odd, or corresponding to the layer closest to the
% % chemical potential in the case of an even number of layers
% if mod(le, 2) == 0
%     zlayer = le - le/2;
% else
%     for j = 1:le
%         if ev(j) == 0
%             zlayer = j;
%         end
%     end
%     zlayer = zlayer - 1;
% end
% 
% for i=1:zlayer
%     asymrealmap(:,:,i) = cmap(:,:,le+1-i) - cmap(:,:,i);
% end
% 
% 
% p = 10;

%% plot position of Se and Fe atoms for FeSe

% change_color_of_STM_maps(asymrealmap(:,:,zlayer-6),'no')
% change_color_of_STM_maps(cmap(:,:,38),'no')
% 
% 
% hold on 
% 
% for i=1:length(fe1locex(1,:))
%     if fe1locex(1,i) >= 78 && fe1locex(1,i) <= ny && fe1locex(2,i) >= 78 && fe1locex(2,i) <= nx
% %         plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%         plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
%     end
% end
% 
% for i=1:length(fe2locex(1,:))
%     if fe2locex(1,i) >= 78 && fe2locex(1,i) <= ny && fe2locex(2,i) >= 78 && fe2locex(2,i) <= nx
% %         plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%         plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
%     end
% end
% 
% for i=1:length(selocex(1,:))
%     if selocex(1,i) >= 78 && selocex(1,i) <= ny && selocex(2,i) >= 78 && selocex(2,i) <= nx
% %         plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2);
%         plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor',darkorange,'MarkerFaceColor',darkorange, 'LineWidth', 2);
%     end
% end
% 
% % plot(ndx, ndy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
% 
% 
% hold off



%% multiply with sine window function first before doing ifftshift

x = linspace(0,pi,nx);
y = linspace(0,pi,ny);
z = sin(x)'*sin(y);

filtmap = zeros(nx, ny, nz);

for k=1:nz
    filtmap(:,:,k) = cmap(:,:,k).*z';
    filtmap(:,:,k) = ifftshift( filtmap(:,:,k) );
end

if isempty(varargin)
    filttopo = ctopo .* z';


    figure, imagesc(ctopo)
    axis image
    figure, imagesc(filttopo)
    axis image

    filttopo(:,:,1) = ifftshift( filttopo(:,:,1) );

    figure, imagesc( filttopo )
    axis image
else
    filtmap2 = zeros(nx, ny, nz);

    for k=1:nz
        filtmap2(:,:,k) = cmap2(:,:,k).*z';
        filtmap2(:,:,k) = ifftshift( filtmap2(:,:,k) );
    end
    
    figure, imagesc(cmap2(:,:,ml(1)))
    axis image
    figure, imagesc( fftshift(filtmap2(:,:,ml(1))) )
    axis image
    figure, imagesc( filtmap2(:,:,ml(1)) )
    axis image
end

%% calculate the Fourier Transform of the cropped, shifted, and windowed data

for k = 1 : nz
    fftc_map(:,:,k) = fourier_transform2d_vb(filtmap(:,:,k),'none','complex','ft');
end

if isempty(varargin)

    fftc_topo = ( fourier_transform2d_vb(filttopo,'none','complex','ft') );

    figure, imagesc(real(fftc_topo))
    axis image

    figure, imagesc(imag(fftc_topo))
    axis image
else
    
    for k = 1 : nz
        fftc_map2(:,:,k) = fourier_transform2d_vb(filtmap2(:,:,k),'none','complex','ft');
    end
    
    figure, imagesc(real(fftc_map2(:,:,ml(1))))
    axis image

    figure, imagesc(imag(fftc_map2(:,:,ml(1))))
    axis image
end

q = r_to_k_coord(clfdata.r);

% prft = phase resolved fourier transform
prft_topo = clftopo;
prft_data = clfdata;

prft_data.map = fftc_map;
prft_data.r = q;

if isempty(varargin)

    prft_topo.map = fftc_topo;
else
    prft_topo.map = fftc_map2;
end

prft_topo.r = q;


end