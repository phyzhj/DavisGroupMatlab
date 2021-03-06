%%%%%%%
% CODE DESCRIPTION: Function to smooth spectra. Input is the spectra y, and
% the averaging window.
%   
% CODE HISTORY
%
% 110313 MHH  Created
%
%%%%%%%

function y_new = boxcar_avg(y,width)

if width < 0 
    display('Width must be greater than or equal to 0');
    y_new = [];
    return;
elseif width == 0
    y_new = y;
    return;
end
w = round(width) ;
n = length(y);
y_new = zeros(n,1);

for i=1:n
    st_pt = max(1,i-w);
    end_pt = min(n,i+w);
    y_new(i) = mean(y(st_pt:end_pt));
end

%figure; plot(y,'.');
%hold on; plot(y_new,'r');
end