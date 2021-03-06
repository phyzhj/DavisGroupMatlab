function [y_new, p,gof]=complete_fit_triple(y,range,guess,e,low,upp)
% range is [left right]
x = range(1):range(2); x = x';
%init_guess = [a_g -1 1 d_g ];
%exp_bkgn = 'a*exp(b*x^c) + d';
%init_guess = [700 x0 5 140];
exp_lrntz = 'a*exp(-b*x) + c*(f/2)^2/((x-d)^2+(f/2)^2)+g*(k/2)^2/((x-h)^2+(k/2)^2)+l*(n/2)^2/((x-m)^2+(n/2)^2)+o';
% exp_lrntz = 'a*exp(-b*x) + c/((x-d)^2+f^2)+g/((x-h)^2+f^2)+l/((x-m)^2+f^2)+o';
% low=guess*0.5;
% upp=guess*1.5;
% introduce variable upper and lower bounds
% low = [guess(1:2)*0.5 guess(3)*0.5 guess(4)*0.7 guess(5)*0.5 guess(6)*0.5 guess(4)*1.5 guess(8)*0.5...
%     guess(9)*0.5 guess(7)*1.5 guess(11)*0.5 guess(12)*0.5];
% upp = [guess(1:2)*1.5 guess(3)*1.5 guess(4)*1.3 guess(5)*1.5 guess(6)*1.5 guess(7)*1.3 guess(8)*1.5...
%     guess(9)*1.5 guess(10)*1.5 guess(11)*1.5 guess(12)*1.5];

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[guess],...
    'Algorithm','trust-region',...
    'TolX',1e-6,...
    'MaxIter',10000,...
    'MaxFunEvals', 10000,...
    'Lower',low,...
    'Upper',upp);

f = fittype(exp_lrntz,'options',s);
[p,gof] = fit(x,y,f);
%p
gg = coeffvalues(p);
for i=1:length(x)
    peak1(i)=gg(3)*(gg(5)/2)^2/((x(i)-gg(4))^2+(gg(5)/2)^2);
    peak2(i)=gg(6)*(gg(8)/2)^2/((x(i)-gg(7))^2+(gg(8)/2)^2);
    peak3(i)=gg(9)*(gg(11)/2)^2/((x(i)-gg(10))^2+(gg(11)/2)^2);
%     peak2(i)=gg(6)/((x(i)-gg(7))^2+gg(5)^2);
%     peak3(i)=gg(8)/((x(i)-gg(9))^2+gg(5)^2);
end
y_new = feval(p,x);
figure, plot(x,y,'.k',x,y_new,'-r',x,peak1,'-b',x,peak2,'-k',x,peak3,'-g', 'linewidth',2);
title([num2str(e) 'mV ' 'single peak']);
% pause(0.5);
end