x = -2000:16:2000;
y = -2000:16:2000;
z2 = zeros(length(x),length(y));
k = 0.04;
a = 50;
b = 50;
x0 = 0;
y0 = 0;
s = 1/200;
%s = 0;
ztemp = zeros(length(x),length(y));
for x0 = -a:a:a
    for y0 = -b:b:b
    
for i = 1:length(x)
    for j = 1:length(y)   
        r = sqrt((k*(x(i))+x0)^2 + (k*(y(j))+y0)^2);
        ztemp(i,j) = (besselj(0,r))*exp(-(r^2)*s);
        %ztemp(i,j) = exp(-(r^2)*s);
        
    end
end
z2 = z2 + (abs((ztemp)));
    end
end
figure; surf(z2);figure(gcf)
shading flat;
%z = z + abs(ztemp);
% for i = 1:length(x)
%     for j = 1:length(y)   
%         r = sqrt((k*(x(i)))^2 + (k*(y(j))+ b)^2);
%         ztemp(i,j) = (besselj(0,r));
%         
%     end
% end
% z = z + abs(ztemp);
%     end
% end

