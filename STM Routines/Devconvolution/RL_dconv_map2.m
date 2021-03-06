%%%%%%%
% CODE DESCRIPTION: Deconvolution algorithm based on the Richardson-Lucy
% Method.  
%   
% CODE HISTORY
%
% 090921 MHH Created
%
%%%%%%%

function dconv_data = RL_dconv_map2(data,VA)
[nr nc nz] = size(data.map);
%nr = 50; nc = 50;
dconv_data = data;
energy = data.e*1000;
old_map = data.map;
new_map = zeros(nr,nc,nz);
for i = 1:nr
    parfor j = 1:nc        
        spectra = squeeze(squeeze(old_map(i,j,:)))';
        %initialize variable to hold successive iterations of process spectra
        a = spectra;
        %initialize the error estimate
        %er_tol(count) = 1;
        %er_tol(count+1) = RMS_er(energy,spectra,a(count,:),VA);
        er_tol_1 = max(a);
        er_tol_2 = RMS_er(energy,spectra,a,VA);
        %constant numerator in RL algorithm - calculate once only
        top = LIA_conv(energy,spectra,VA,-1);

        % set tolerance for the RMS error - stop condition
        tolerance = 0.009;
        %while (-diff(er_tol(end-1:end)) > tolerance)   
        while ((er_tol_1 - er_tol_2) > tolerance)               
            tmp = a;
            bot_1 = LIA_conv(energy,tmp,VA,1);
            bot_2 = LIA_conv(energy,bot_1,VA,-1);
            a = tmp.*(top./bot_2);
            er_tol_1 = er_tol_2;
            er_tol_2 = RMS_er(energy,spectra,a,VA);
            %er_tol(count+1) = RMS_er(energy,spectra,a,VA);
        end
        % figure;
        % subplot(1,3,1); plot((-diff(er_tol(2:end))),'gx-');
        % title('error diff')
        % subplot(1,3,2); plot(energy,spectra,'r'); hold on; plot(energy,dconv_data(end,:));
        % title('deconvolved spectra vs original in red')
        % subplot(1,3,3);plot(energy,spectra,'r');hold on; plot(energy,LIA_conv(energy,dconv_data(end,:),VA,1));
        % title('reconvolvution of processed spectra vs original in red')
        %dconv_data.map(i,j,:) = a;        
        new_map(i,j,:) = a;
    end
end
dconv_data.map = new_map;
dconv_data.ave = squeeze(mean(mean(dconv_data.map)));
dconv_data.r = linspace(data.r(1),data.r(end),nr);
end
function err_est = RMS_er(x,y,y2,LIA_amp)
N = length(x);
err_est = sqrt(1/N*sum((y - LIA_conv(x,y2,LIA_amp)).^2));
end