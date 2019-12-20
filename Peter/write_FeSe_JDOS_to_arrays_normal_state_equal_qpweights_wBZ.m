clear allsim;
qc = linspace(-pi/2.66, pi/2.66, 300);
% qc = cat(2, -fliplr(q(2:end)), q);

%% both gamma and X
for i=0:80
    s = strcat('C:\Users\pspra\OneDrive\VOSM\QPI layers\12212016_complete_BZ_1.25meV_energy_broadening\matlab\equal qp weights\','JDOS_-0.1_f_0_low_eta_low_eta_', num2str(i), 'conv.mat');
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12212016_complete_BZ_1.25meV_energy_broadening\matlab\equal qp weights\','JDOS_-0.1_f_0_low_eta_low_eta_', num2str(i), 'conv.mat');
    dummy = load(s);
    quartmap = dummy.rjd0;
%     
%     qmlr = fliplr(quartmap);
%     qmud = flipud(quartmap);
%     qmlrud = flipud(qmlr);
%     
%     dum1 = cat(2, qmlrud, qmud(1:end, 2:end));
%     dum2 = cat(2, qmlr(2:end, 1:end), quartmap(2:end, 2:end));
%     dum3 = cat(1, dum1, dum2);
%     figure, imagesc(dum3)
    dum3 = quartmap;
    [nx, ny, nz] = size(dum3);
    allsim(1:nx,1:ny,i+1) = abs(dum3(:, :));
    qall = qc;
end



obj_allsim_JDOS_wBZ = obj_60721a00_G;
ev = linspace(-0.05, 0.05,81);

obj_allsim_JDOS_wBZ.e = ev;
obj_allsim_JDOS_wBZ.r = qall;
obj_allsim_JDOS_wBZ.map = allsim;