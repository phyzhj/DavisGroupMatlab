%%%%%%%
% CODE DESCRIPTION: Find the right edge of hybridization gap in
% URu2Si2(Th-doped).  Enter spectra in through x (energy), y (DOS), and the
% index for the dip near chemical potential.  Variable input allows for
% smoothing of spectra befire fitting and edge finding.  
%   
% CODE HISTORY
%
% 110313 MHH  Created
% 
%
%%%%%%%

function p_edge = URuSi_pos_edge(x,y,bottom_ind,varargin)
n = size(y);
res = 0.001;
if nargin <=3
    ysm = y;
else    
    w = (varargin{1});
    ysm = boxcar_avg(y,w);  
end

if isempty(ysm) 
    p_edge = [];
    return;
end
pt1 = bottom_ind + 4 ; pt2 =  min(pt1 + 10,n);
[p,S]= polyfit(x(pt1:pt2),ysm(pt1:pt2)',6);                
xfine = x(pt1):res:x(pt2);
y2 = polyval(p,xfine);        
[dy2 x2] = num_der2b(2,y2,xfine);                
%figure; plot(x2,dy2);
[pks1 loc1] = findpeaks(abs(dy2));
[pks2 loc2] = findpeaks(dy2);
    if ~isempty(loc1) && ~isempty(loc2)       
        loc = min([loc1(:); loc2(:)]);
    elseif isempty(loc1) && ~isempty(loc2)
        loc = min(loc2);
    elseif isempty(loc2) && ~isempty(loc1)
        loc = min(loc1);
    else
        loc = bottom_ind;
    end      
x0 = x2(loc);
 p_edge  = x0(1);
% figure; plot(x2,dy2);
% hold on; plot([p_edge p_edge],get(gca,'ylim'));
% 
% figure; plot(x,y,'kx'); hold on; plot(x(pt1:pt2),y(pt1:pt2),'rx');
% hold on; plot(x,ysm);
% hold on; plot(xfine,y2,'g');
% hold on; plot([p_edge p_edge],get(gca,'ylim'));
% hold on; plot([x(bottom_ind) x(bottom_ind)],get(gca,'ylim'));
end