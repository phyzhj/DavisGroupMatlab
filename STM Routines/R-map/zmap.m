function Z = zmap(data)
[nr nc nz] = size(data.map);
if size(data.e,2)==1
    disp('Z-map not possible: 1 layer only');
    return;
end
if ((abs(data.e(1)))==abs(data.e(end)) && (mod(nz,2)==1))
    Z = data;
    Z.e = data.e(ceil(nz/2):end);
    new_nz = size(Z.e,2);
    Z.map = zeros(nr,nc,new_nz);
    for k = 1:new_nz
        Z.map(:,:,new_nz-k+1) = (data.map(:,:,k) + data.map(:,:,2*new_nz-k))/2;
    end
    Z.ave = squeeze(squeeze(mean(mean(Z.map))));
else
    disp('Z-map not possible');
    return;
end
        
end