%%%%%%%
% CODE DESCRIPTION: Symmetrizes a map along the horizontal and then across
% the diagonal.  This method is used in symmetrizing the fourier transform
% for dI/dV maps.
%   
% INPUT: Standard STM data structure
%
% CODE HISTORY
%
% 080304 MHH Created


function sym_data = symmetrize_map4(data)

if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    tmp_data = data.map;
else % single data image
    [nr,nc,nz] = size(data);
    tmp_data = data;
end

new_data = nan(nr,nc,nz);
%symmetrize along horizontal
% for i=1:nr/2
%     new_data(i,:,:) = (tmp_data(i,:,:) + tmp_data(nr + 1 - i,:,:))/2;
%     new_data(nr + 1 -i,:,:) = new_data(i,:,:);
% end
%symmetrize along diagonal
 for j=1:nc/2
     new_data(:,j,:) = (tmp_data(:,j,:) + tmp_data(:,nc + 1 - j,:))/2;
     new_data(:,nc + 1 -j,:) = new_data(:,j,:);
 end
%symmetrize along diagonal
for k = 1:nz
  new_data(:,:,k) = (tmp_data(:,:,k) + tmp_data(:,:,k)')/2;
end

if isstruct(data) % check if data is a full data structure
    sym_data = data;
    sym_data.map = new_map;   
else % single data image
    sym_data = new_data;
end
end
