% 2019-6-10 YXC testing lorentzianfit function
map = invert_map(obj_90311A00_G);

[nx,ny,nz]= size(map.map);
x = randi([1,nx])
y = randi([1,ny])


spec = squeeze(map.map(y,x,:))';
en = map.e;


background = 0; %no background subtraction
[peakenergy_0,~,~,~,~,startmV,endmV] = many_lorentzfit(en,spec,background,'plot');
background = 1; %subtract splinefit
[peakenergy_1,~,~,~,~,startmV,endmV] = many_lorentzfit(en,spec,background,'plot');
background =2;
[peakenergy_2,~,~,p,err,startmV,endmV] = many_lorentzfit(en,spec,background,'plot');

%initialize matrices
pmatrix = zeros(3,nx,ny,9,6);
llmatrix = zeros(3,nx,ny,9);
errmatrix = zeros(3,nx,ny,9);
startmVmatrix = zeros(3,nx,ny,9);
endmVmatrix = zeros(3,nx,ny,9);

% landaumap = map;

% for method = 1:3
%     backgnd = method-1;
%     for x = 1:nx
%         x
%         for y = 1:ny
%             spec = squeeze(map.map(y,x,:))';
%             en = map.e;
%             [peakenergy,~,~,p,err,startmV,endmV] = many_lorentzfit(en,spec,backgnd);
%             [n_fitted,~] = size(p);
%             pmatrix(method,x,y,1:n_fitted,:) = p;
%             llmatrix(method,x,y,1:n_fitted) = peakenergy;
%             errmatrix(method,x,y,1:n_fitted) = err;
%             startmVmatrix(method,x,y,1:n_fitted) = startmV;
%             endmVmatrix(method,x,y,1:n_fitted) = endmV;
%         end
%     end
%     
% end  



