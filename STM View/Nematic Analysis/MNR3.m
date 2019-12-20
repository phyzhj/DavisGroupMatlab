%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: Using the locations of Cu atoms and the associated Ox
% and Oy atoms, the parameter INR is calculated.  This quantity describes the
% imbalance of charge (current at each bias) in between the x and y 
% direction for each copper atom.  The number px_avg defined number of pixels 
% around each Ox and Oy site to be averaged. px_avg = 0 means no averaging.
% Patch size defines the number of pixels around each Cu atoms to assign
% the value of INR(i).  I_map should be the shear corrected and offset
% corrected simultaneous current map.
%
% ALGORITHM: INR(i) = (abs(I(Ox(i))) - abs(I(Oy(i))))/sqrt(sum_i(Ix^2) +
% sum_i(Ix^2))
%
% CODE HISTORY
%
% 100914 MHH Created
% 101019 MHH Modified for STM_View

function new_data = MNR3(data,px_avg,varargin)
Cu_index = data.Cu_index;
Ox_index1 = data.Ox_index1;
Ox_index2 = data.Ox_index2;
Oy_index1 = data.Oy_index1;
Oy_index2 = data.Oy_index2;

[nr nc nz] = size(data.map);
new_data = data;
new_data.map = zeros(nr,nc,nz);
exclude = NaN;

if ~isempty(varargin)
    exclude = str2double(varargin{1});
end

m = px_avg;
if m > 1
    m = 1;
end
chk_sum = (2*m+1)^2;
count = 0;
count2 = 0;
h = waitbar(0,'Please wait...','Name','Nematic Analysis in Progress');
for n = 1:nz    
    normalization = 0;      
    for i = 1:size(Cu_index,1)
        if (Ox_index1(i,1)~=0 && Ox_index2(i,1) ~=0 && Oy_index1(i,1) ~= 0 && Oy_index2(i,1)~=0)
            % if the exclude option is included check that all the appropriate sites fulfill the condition
            % this means checks all pixels which would be involved in the
            % averaging;
            %count2 = count2 + 1
            if (~isnan(exclude) &&...                        
              sum(sum(data.map(Cu_index(i,1) -m:Cu_index(i,1) +m,Cu_index(i,2) -m:Cu_index(i,2) +m,n)~=exclude)) == chk_sum &&... 
              sum(sum(data.map(Ox_index1(i,1)-m:Ox_index1(i,1)+m,Ox_index1(i,2)-m:Ox_index1(i,2)+m,n)~=exclude)) == chk_sum &&...
              sum(sum(data.map(Ox_index2(i,1)-m:Ox_index2(i,1)+m,Ox_index2(i,2)-m:Ox_index2(i,2)+m,n)~=exclude)) == chk_sum &&...
              sum(sum(data.map(Oy_index1(i,1)-m:Oy_index1(i,1)+m,Oy_index1(i,2)-m:Oy_index1(i,2)+m,n)~=exclude)) == chk_sum &&...
              sum(sum(data.map(Oy_index2(i,1)-m:Oy_index2(i,1)+m,Oy_index2(i,2)-m:Oy_index2(i,2)+m,n)~=exclude)) == chk_sum)
         
                %average over Cu site's two associated Oxygen-x sites
                Ix = (mean(mean(data.map(Ox_index1(i,1)-m:Ox_index1(i,1)+m,...
                    Ox_index1(i,2)-m:Ox_index1(i,2)+m,n))) +...
                    mean(mean(data.map(Ox_index2(i,1)-m:Ox_index2(i,1)+m,...
                    Ox_index2(i,2)-m:Ox_index2(i,2)+m,n))))/2 ;
                %average over Cu site's two associated Oxygen-y sites
                Iy = (mean(mean(data.map(Oy_index1(i,1)-m:Oy_index1(i,1)+m,...
                    Oy_index1(i,2)-m:Oy_index1(i,2)+m,n))) +...
                    mean(mean(data.map(Oy_index2(i,1)-m:Oy_index2(i,1)+m,...
                    Oy_index2(i,2)-m:Oy_index2(i,2)+m,n))))/2 ;                       

                % for normalization also add up all weight on the Cu sites
                ICu = mean(mean(data.map(Cu_index(i,1)-m:Cu_index(i,1)+m,...
                   Cu_index(i,2)-m:Cu_index(i,2)+m,n)));

                normalization = (abs(Ix) + abs(Iy)) + abs(ICu); %add up intensities at all O sites                               
                new_data.map(Cu_index(i,1),Cu_index(i,2),n) =...
                    (abs(Ix) - abs(Iy))/normalization;
            elseif (isnan(exclude))
                display('here');
                %count = count + 1
                %size(Cu_index)
                    %average over Cu site's two associated Oxygen-x sites
                Ix = (mean(mean(data.map(Ox_index1(i,1)-m:Ox_index1(i,1)+m,...
                    Ox_index1(i,2)-m:Ox_index1(i,2)+m,n))) +...
                    mean(mean(data.map(Ox_index2(i,1)-m:Ox_index2(i,1)+m,...
                    Ox_index2(i,2)-m:Ox_index2(i,2)+m,n))))/2 ;
                %average over Cu site's two associated Oxygen-y sites
                Iy = (mean(mean(data.map(Oy_index1(i,1)-m:Oy_index1(i,1)+m,...
                    Oy_index1(i,2)-m:Oy_index1(i,2)+m,n))) +...
                    mean(mean(data.map(Oy_index2(i,1)-m:Oy_index2(i,1)+m,...
                    Oy_index2(i,2)-m:Oy_index2(i,2)+m,n))))/2 ;                       

                % for normalization also add up all weight on the Cu sites
                ICu = mean(mean(data.map(Cu_index(i,1)-m:Cu_index(i,1)+m,...
                   Cu_index(i,2)-m:Cu_index(i,2)+m,n)));

                normalization = (abs(Ix) + abs(Iy)) + abs(ICu); %add up intensities at all O sites                               
                new_data.map(Cu_index(i,1),Cu_index(i,2),n) =...
                    (abs(Ix) - abs(Iy))/normalization;
            end
        end            
    end        
    
    %new_data.map(:,:,n) = new_data.map(:,:,n)/sqrt(normalization);
    waitbar(n / nz,h,[num2str(n/nz*100) '%']);
end
close(h);
new_data.ave = [];
OPvsE = zeros(nz,1);
for i=1:size(Cu_index,1)
    OPvsE = OPvsE + squeeze(squeeze(new_data.map(Cu_index(i,1),Cu_index(i,2))));
end    
new_data.OPvsE = OPvsE;
new_data.type = 3;
new_data.var =  [new_data.var(1) '_MNR_lnorm'];
new_data.ops{end+1} = ['MNR order parameter map with ' num2str(m) ' pixel average radius with local normalization'];
end

