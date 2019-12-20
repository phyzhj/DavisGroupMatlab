%% load maps
clear all
close all
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\May_2013\05_01_13\NaFeAs30501A00.mat
% load D:/NaFeAs/130424/FFT30424.A00.mat
%% Assign the conductance map to G, the current map to I, and the topograph
%% to T
G=obj_30501A00_G;
I=obj_30501A00_I;
T=obj_30501A00_T;

%% Two ways of normalization to accommodate for the set-up effect

%% 1.) Divide every layer in the conductance map by the first layer of the
%% current map
g=current_divide2(G,I);
% subtract the constant background
g = polyn_subtract2(g,0);
% Gauss filter on conductance map <=> core subtraction

Gfilt = gauss_filter_image(G,16,4);

% Fourier transform the conductance map
FFT = fourier_transform2d(g,'none','amplitude', 'ft');
% Gauss filter of Fourier transform

%Ffilt = gauss_filter_image(FFT,9,3);

%% 2.) Feenstra, divide every layer in the conductance map by the
%% corresponding layer in the current map
g=G;
Imap = I.map;
% zero_energy = find(g.e == 0);
% zero_energy = 1;
%current_offset = mean(mean(Imap(:,:,zero_energy)));
current_offset = 0;
for i = 1:length(g.e)
 %   Imap(:,:,i) = Imap(:,:,i) - Imap(:,:,zero_energy);
    g.map(:,:,i) = g.map(:,:,i)./Imap(:,:,1);
end

% subtract the constant background
g = polyn_subtract2(g,0);
% Gauss filter on conductance map <=> core subtraction

% Gfilt = gauss_filter_image(G,9,3);

FFT = fourier_transform2d(g,'none','amplitude', 'ft');
% Gauss filter of Fourier transform

%Ffilt = gauss_filter_image(F,9,3);

%% Correct for possible drift and symmetrize the Fourier Transform
%map = linear2D_image_correct([-2.23 -2.28],[2.15, -2.35],FFT);
%FFT.map = map;
FFT=symmetrize_image_v2(FFT,'vd');
img_obj_viewer2(FFT);

% clear  mapfilt mapfiltF map

%% taking cut
offset = 4;
%define zero degree cut
in1 = [(129+offset) (129)];
in2 = [257 129];
% specify the angle
angle = 45;
% compute the cut coordinates
[out1, out2] = coordinates_from_angle(in1,in2,angle,129);
% take the cut;
ln_cut=line_cut_v4(FFT,out1,out2,5);
% plot the cut
figure(1424), imagesc(flipud(ln_cut.cut'));
% figure(1425), imagesc((ln_cut424.cut'));
%colormap(GrayScaleMod);
colormap(gray);

% for i=1 : 30
%     figure(i); plot(1:88,(ln_cut424.cut(:,i)),'.k');
% end

%% polar average

O = polar_average_odd(FFT,0,360);
figure(1426), imagesc(flipud(O(offset:end,:)'));
colormap(hot);

for i=1 : 31
    figure(i+10); plot(offset:129,(O(offset:end,i)),'.k');
    title([num2str(ln_cut.e(i)*1000) 'mV ' 'single peak']);
end
% figure;
% hold on
% for i=1 : 31
%     plot(1:129,((O(:,i))/max(O(:,i)))+i*0.1,'.k');
%     title([num2str(ln_cut424.e(1)*1000) 'mV to ' num2str(ln_cut424.e(end)*1000)  'mV single peak']);
% end
% hold off
%% Fitting procedure
% input for offset of the fitting
close all;
offset=4;
% x = (1+offset):(length(ln_cut.cut(:,1))+offset);
x = (1+offset):(length(O(:,1))+offset);
% starting guess for the fitting paramters
guess = [0.7 0.1 0.9 40 5 0.004];
% --------------------------------------------------------------------------
% A1 and A2 determine how many and which layers are supposed to be fitted 
A1=2;
A2=4;
% vector containing the q coordinates
q = zeros(1,A2-A1+1);
tol = 1e-6;
t=1;

% normalize to one 
test2=ln_cut.cut(:,2)/max(ln_cut.cut(:,2));
% fit once to get a better starting guess (actually seems to improve the
% fit of the first layer quite a bit)
% for i=1:10
% [y_new, p] = complete_fit(test2,[x(1) x(end)],guess,1000*ln_cut.e(2));
% guess = coeffvalues(p);
% end
% O is the output of the polar average
for i=1:10
    low=guess*0.5;
    upp=guess*1.5;
    test=O(:,A1)/max(O(:,A1));
    [y_new, p] = complete_fit(test,[x(1) x(end)],guess,1000*ln_cut.e(A1),low,upp);
    guess = coeffvalues(p);
end

for k=A1:A2
    low=guess*0.5;
    upp=guess*1.5;
%     test2=ln_cut.cut(:,k)/max(ln_cut.cut(:,k));
%     [y_new, p] = complete_fit(test2,[x(1) x(end)],guess,1000*ln_cut.e(k));
%     [y_new, p] = complete_fit(ln_cut424.cut(:,k),[x(1)
%     x(end)],guess,1000*ln_cut.e(k));
% O is the output of the polar average
        test=O(:,k)/max(O(:,k));
        [y_new, p] = complete_fit(test,[x(1) x(end)],guess,1000*ln_cut.e(k),low,upp);
        guess = coeffvalues(p);
        q(t) = guess(4);
    t = t+1; 
end


clear low;
clear upp;

% close all;
figure;
plot(q,ln_cut.e(A1:A2),'.')
A3=A1;
% %% double peak fitting
close all;
% input for offset of the fitting
offset=4;
% x = (1+offset):(length(ln_cut.cut(:,1))+offset);
x = (1+offset):(length(O(:,1))+offset);
% starting guess for the fitting paramters
guess = [guess(1) guess(2) guess(3) guess(4) guess(5) guess(3) 90 guess(5) guess(6)];
% --------------------------------------------------------------------------
% A1 and A2 determine how many and which layers are supposed to be fitted 
A1=5;
A2=8;
% vector containing the q coordinates
q1 = zeros(1,A2-A1+1);
q2 = zeros(1,A2-A1+1);
tol = 1e-6;
t=1;

% normalize to one 
test2=ln_cut.cut(:,2)/max(ln_cut.cut(:,2));
% fit once to get a better starting guess (actually seems to improve the
% fit of the first layer quite a bit)
% for i=1:10
% [y_new, p] = complete_fit_double(test2,[x(1) x(end)],guess,1000*ln_cut.e(2));
% guess = coeffvalues(p);
% end
% O is the output of the polar average
for i=1:10
    low = [guess(1:2)*0.5 guess(3)*0.5 guess(4)*0.7 guess(5)*0.5 guess(6)*0.5 guess(4)*1.5 guess(8)*0.5 guess(9)*0.5];
    upp = [guess(1:2)*1.5 guess(3)*1.5 guess(4)*1.3 guess(5)*1.5 guess(6)*1.5 guess(7)*1.5 guess(8)*1.5 guess(9)*1.5];
    test=O(:,A1)/max(O(:,A1));
    [y_new, p] = complete_fit_double(test,[x(1) x(end)],guess,1000*ln_cut.e(A1),low,upp);
    guess = coeffvalues(p);
end

for k=A1:A2
    low = [guess(1:2)*0.5 guess(3)*0.5 guess(4)*0.7 guess(5)*0.5 guess(6)*0.5 guess(4)*1.5 guess(8)*0.5 guess(9)*0.5];
    upp = [guess(1:2)*1.5 guess(3)*1.5 guess(4)*1.3 guess(5)*1.5 guess(6)*1.5 guess(7)*1.5 guess(8)*1.5 guess(9)*1.5];
%     test2=ln_cut.cut(:,k)/max(ln_cut.cut(:,k));
%     [y_new, p] = complete_fit_double(test2,[x(1) x(end)],guess,1000*ln_cut.e(k));
%     [y_new, p] = complete_fit_double(ln_cut424.cut(:,k),[x(1) x(end)],guess,1000*ln_cut.e(k));
% O is the output of the polar average
        test=O(:,k)/max(O(:,k));
        [y_new, p] = complete_fit_double(test,[x(1) x(end)],guess,1000*ln_cut.e(k),low,upp);
        guess = coeffvalues(p);
        q1(t) = guess(4);
        q2(t) = guess(7);
    t = t+1; 
end

clear low;
clear upp;
% close all;
figure;
plot([q q1],ln_cut.e(A3:A2),'.')
figure;
plot(q2,ln_cut.e(A1:A2),'.')
A4=A1;
% %% triple peak fitting
close all;
% input for offset of the fitting
offset=4;
% x = (1+offset):(length(ln_cut.cut(:,1))+offset);
x = (1+offset):(length(O(:,1))+offset);
% starting guess for the fitting paramters
guess = [guess(1) guess(2) guess(3) guess(4) guess(5) guess(6) guess(7) guess(8) guess(6) 100 guess(8) guess(9)];
% --------------------------------------------------------------------------
% A1 and A2 determine how many and which layers are supposed to be fitted 
A1=9;
A2=17;
% vector containing the q coordinates
q3 = zeros(1,A2-A1+1);
q4 = zeros(1,A2-A1+1);
q5 = zeros(1,A2-A1+1);
tol = 1e-6;
t=1;

% normalize to one 
test2=ln_cut.cut(:,2)/max(ln_cut.cut(:,2));
% fit once to get a better starting guess (actually seems to improve the
% fit of the first layer quite a bit)
% for i=1:10
% [y_new, p] = complete_fit_triple(test2,[x(1) x(end)],guess,1000*ln_cut.e(2));
% guess = coeffvalues(p);
% end
% O is the output of the polar average
for i=1:10
    low = [guess(1:2)*0.5 guess(3)*0.5 guess(4)*0.7 guess(5)*0.5 guess(6)*0.5 guess(4)*1.5 guess(8)*0.5...
    guess(9)*0.5 guess(7)*1.5 guess(11)*0.5 guess(12)*0.5];
    upp = [guess(1:2)*1.5 guess(3)*1.5 guess(4)*1.3 guess(5)*1.5 guess(6)*1.5 guess(7)*1.3 guess(8)*1.5...
    guess(9)*1.5 guess(10)*1.5 guess(11)*1.5 guess(12)*1.5];

    test=O(:,A1)/max(O(:,A1));
    [y_new, p] = complete_fit_triple(test,[x(1) x(end)],guess,1000*ln_cut.e(A1),low,upp);
    guess = coeffvalues(p);
end

for k=A1:A2
    low = [guess(1:2)*0.5 guess(3)*0.5 guess(4)*0.7 guess(5)*0.5 guess(6)*0.5 guess(4)*1.5 guess(8)*0.5...
    guess(9)*0.5 guess(7)*1.5 guess(11)*0.5 guess(12)*0.5];
    upp = [guess(1:2)*1.5 guess(3)*1.5 guess(4)*1.3 guess(5)*1.5 guess(6)*1.5 guess(7)*1.3 guess(8)*1.5...
    guess(9)*1.5 guess(10)*1.5 guess(11)*1.5 guess(12)*1.5];

%     test2=ln_cut.cut(:,k)/max(ln_cut.cut(:,k));
%     [y_new, p] = complete_fit_triple(test2,[x(1) x(end)],guess,1000*ln_cut.e(k));
%     [y_new, p] = complete_fit_triple(ln_cut424.cut(:,k),[x(1) x(end)],guess,1000*ln_cut.e(k));
% O is the output of the polar average
        test=O(:,k)/max(O(:,k));
        [y_new, p] = complete_fit_triple(test,[x(1) x(end)],guess,1000*ln_cut.e(k),low,upp);
        guess = coeffvalues(p);
        q3(t) = guess(4);
        q4(t) = guess(7);
        q5(t) = guess(10);
    t = t+1; 
end

clear low;
clear upp;
% close all;
figure;
plot([q q1 q3],ln_cut.e(A3:A2),'.')
figure;
plot([q2 q4],ln_cut.e(A4:A2),'.')
figure;
plot(q5,ln_cut.e(A1:A2),'.')
A5=A1;
%% triple peak fitting
close all;
% input for offset of the fitting
offset=4;
% x = (1+offset):(length(ln_cut.cut(:,1))+offset);
x = (1+offset):(length(O(:,1))+offset);
% starting guess for the fitting paramters
guess = [guess(1) guess(2) guess(3) guess(4) guess(5) guess(6) guess(7) guess(8) guess(6) 100 guess(8) guess(9)];
% --------------------------------------------------------------------------
% A1 and A2 determine how many and which layers are supposed to be fitted 
A1=18;
A2=27;
% vector containing the q coordinates
q6 = zeros(1,A2-A1+1);
q7 = zeros(1,A2-A1+1);
q8 = zeros(1,A2-A1+1);
tol = 1e-6;
t=1;

% normalize to one 
test2=ln_cut.cut(:,2)/max(ln_cut.cut(:,2));
% fit once to get a better starting guess (actually seems to improve the
% fit of the first layer quite a bit)
% for i=1:10
% [y_new, p] = complete_fit_triple(test2,[x(1) x(end)],guess,1000*ln_cut.e(2));
% guess = coeffvalues(p);
% end
% O is the output of the polar average
for i=1:10
    low = [guess(1:2)*0.5 guess(3)*0.5 19-2*i guess(5)*0.5 guess(6)*0.5 53-2*i guess(8)*0.5...
    guess(9)*0.5 79-2*i guess(11)*0.5 guess(12)*0.5];
    upp = [guess(1:2)*1.5 guess(3)*1.5 19 guess(5)*1.5 guess(6)*1.5 53 guess(8)*1.5...
    guess(9)*1.5 79 guess(11)*1.5 guess(12)*1.5];
    test=O(:,A1)/max(O(:,A1));
    [y_new, p] = complete_fit_triple(test,[x(1) x(end)],guess,1000*ln_cut.e(A1),low,upp);
    guess = coeffvalues(p);
end

close all;

for k=A1:A2
    low = [guess(1:2)*0.5 guess(3)*0.5 19-2*k guess(5)*0.5 guess(6)*0.5 53-2*k guess(8)*0.5...
    guess(9)*0.5 79-2*k guess(11)*0.5 guess(12)*0.5];
    upp = [guess(1:2)*1.5 guess(3)*1.5 19 guess(5)*1.5 guess(6)*1.5 53 guess(8)*1.5...
    guess(9)*1.5 79 guess(11)*1.5 guess(12)*1.5];
%     test2=ln_cut.cut(:,k)/max(ln_cut.cut(:,k));
%     [y_new, p] = complete_fit_triple(test2,[x(1) x(end)],guess,1000*ln_cut.e(k));
%     [y_new, p] = complete_fit_triple(ln_cut424.cut(:,k),[x(1) x(end)],guess,1000*ln_cut.e(k));
% O is the output of the polar average
        test=O(:,k)/max(O(:,k));
        [y_new, p] = complete_fit_triple(test,[x(1) x(end)],guess,1000*ln_cut.e(k),low,upp);
        guess = coeffvalues(p);
        q6(t) = guess(4);
        q7(t) = guess(7);
        q8(t) = guess(10);
    t = t+1; 
end

% close all;
figure;
plot([q q1 q3 q6],ln_cut.e(A3:A2),'.')
figure;
plot([q2 q4 q7],ln_cut.e(A4:A2),'.')
figure;
plot([q5 q8],ln_cut.e(A5:A2),'.')
