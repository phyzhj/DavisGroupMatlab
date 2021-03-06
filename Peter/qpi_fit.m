function  qpi_fit(y,offset,range,npeaks,peakpos,FFT)


%% create x-data for fitting
x = (1+offset):(length(y(:,1))+offset);
%% create normalized y (normalized to max of each energy layer)
ynorm=zeros(size(y,1),size(y,2));
for k=1:length(y(1,:))
    ynorm(:,k)=y(:,k)/max(y(:,k));
end

%% set window size for lower and upper bounds of peaks to be fitted
w1=15;
w2=15;
w3=15;
%% for loop for the different energy ranges that will be fitted
for l=1:length(range)-1
    %% A1 and A2 determine how many and which layers are supposed to be
    %% fitted 
    if l==1
        A1=range(1);
        A2=range(2);
    else 
        A1=range(l)+1;
        A2=range(l+1);
    end
    
    %% fit the FFT layer to a two-dimensional Gaussian to determine the
%     %% core size (lower bound for the peaks), does not work, fit is too big
%     for a=1:(A2-A1)+1
%     [gcoeffs,resnorm,residual]=complete_fit_2d_gaussian(FFT.map(:,:,a));
%     avefwhm=mean([gcoeffs(3), gcoeffs(5)]);
%     end
    %% How many peaks are to be fitted (one, two , three,...)
    
        if strcmp(npeaks{l},'s')==1
            %% vector containing the q coordinates
            q = zeros(1,A2-A1+1);
            ql = zeros(1,A2-A1+1);
            qr = zeros(1,A2-A1+1);
            hgif = zeros(1,A2-A1+1);
            %% fit only an exponential with a constant offset to get
            %% initial coefficients for that part
            guess = [0.5, 0.5, 0.01];
            low = [0, 0, 0];
            upp = [inf, inf, inf];
            [y_new, p, gof]=lorent_fit(ynorm(:,A1),[x(1) x(end)],guess,1000*FFT.e(A1),low,upp);
            guess = coeffvalues(p);
            a = guess(1);
            b = guess(2);
            c = guess(3);
            %% fit model
%             exp_lrntz = 'a*exp(-b*x) + c/((x-d)^2+f^2)+g';
            %% starting guess, lower and upper bounds
            startpos=peakpos{l};
            guess = [a, b, 0.5, startpos, 10, c];
            low=[0, 0, c, startpos-w1, 0, 0 ];
            upp=[10*a, 10*b, inf, startpos+w1,2*w1, 10*c ];
            
            
            for i=1:10
                [y_new, p, gof] = complete_fit(ynorm(:,A1),[x(1) x(end)],guess,1000*FFT.e(k),low,upp);
                guess = coeffvalues(p);
                low=[0, 0, c, guess(4)-w1, 0, 0 ];
                upp=[10*a, 10*b, inf, guess(4)+w1, 2*w1, 10*c ];
            end
            close all;
            
            t=1;
            for k=A1:A2
            [y_new, p, gof] = complete_fit(ynorm(:,k),[x(1) x(end)],guess,1000*FFT.e(k),low,upp);
            guess = coeffvalues(p);
            elimits = confint(p);
            low=[0, 0, c, guess(4)-w1, 0, 0 ];
            upp=[10*a, 10*b, inf, guess(4)+w1, 2*w1, 10*c ];
            q(t) = guess(4);
            ql(t) = abs(guess(4)-elimits(1,4));
            qr(t) = abs(guess(4)-elimits(2,4));
            hgif(t) = gof.rmse;
            t = t+1; 
            end
            
            figure;
            herrorbar(q,FFT.e(A1:A2),ql,qr,'.')
            figure;
            plot(FFT.e(A1:A2),hgif,'.')
            
            
        elseif strcmp(npeaks{l},'d')==1
            %% vector containing the q coordinates
            q = zeros(2,A2-A1+1);
            ql = zeros(2,A2-A1+1);
            qr = zeros(2,A2-A1+1);
            hgif = zeros(1,A2-A1+1);
            %% fit only an exponential with a constant offset to get
            %% initial coefficients for that part
            guess = [0.5, 0.5, 0.01];
            low = [0, 0, 0];
            upp = [inf, inf, inf];
            [y_new, p, gof]=lorent_fit(ynorm(:,A1),[x(1) x(end)],guess,1000*FFT.e(A1),low,upp);
            guess = coeffvalues(p);
            a = guess(1);
            b = guess(2);
            c = guess(3);
            %% fit model
            % exp_lrntz = 'a*exp(-b*x) +
            % c/((x-d)^2+f^2)+g/((x-h)^2+k^2)+l';
            %% starting guess, lower and upper bounds
            
            startpos=peakpos{l};
            guess = [a, b, 0.5, startpos(1), 10, 0.5, startpos(2), 10, c];
            low=[0, 0, c, startpos(1)-w1, 0, c, startpos(2)-w2, 0, 0 ];
            upp=[10*a, 10*b, inf, startpos(1)+w1, 2*w1, inf, startpos(2)+w2, 2*w2, c*10 ];

            for i=1:10
                [y_new, p, gof] = complete_fit_double(ynorm(:,A1),[x(1) x(end)],guess,1000*FFT.e(k),low,upp);
                guess = coeffvalues(p);
                low=[0, 0, c, guess(4)-w1, 0, c, guess(7)-w2, 0, 0 ];
                upp=[10*a, 10*b, inf, guess(4)+w1, 2*w1, inf, guess(7)+w2, 2*w2, c*10 ];
            end
            
            close all
            
            t=1;
            for k=A1:A2
            [y_new, p, gof] = complete_fit_double(ynorm(:,k),[x(1) x(end)],guess,1000*FFT.e(k),low,upp);
            guess = coeffvalues(p);
            elimits = confint(p);
            low=[0, 0, c, guess(4)-w1, 0, c, guess(7)-w2, 0, 0 ];
            upp=[10*a, 10*b, inf, guess(4)+w1, 2*w1, inf, guess(7)+w2, 2*w2, c*10 ];
            q(1,t) = guess(4);
            q(2,t) = guess(7);
            ql(1,t) = abs(guess(4)-elimits(1,4));
            qr(1,t) = abs(guess(4)-elimits(2,4));
            ql(2,t) = abs(guess(7)-elimits(1,7));
            qr(2,t) = abs(guess(7)-elimits(2,7));
            hgif(t) = gof.rmse;
            t = t+1; 
            end
            
            figure;
            herrorbar(q(1,:),FFT.e(A1:A2),ql(1,:),qr(1,:),'.')
            figure;
            herrorbar(q(2,:),FFT.e(A1:A2),ql(2,:),qr(2,:),'.')
            figure;
            plot(FFT.e(A1:A2),hgif,'.')
            
        elseif strcmp(npeaks{l},'t')==1
            %% vector containing the q coordinates
            q = zeros(3,A2-A1+1);
            ql = zeros(3,A2-A1+1);
            qr = zeros(3,A2-A1+1);
            hgif = zeros(1,A2-A1+1);
            %% fit model
            % exp_lrntz = 'a*exp(-b*x) +
            % c/((x-d)^2+f^2)+g/((x-h)^2+k^2)+l/((x-m)^2+n^2)+o';
            %% fit only an exponential with a constant offset to get
            %% initial coefficients for that part
            guess = [0.5, 0.5, 0.01];
            low = [0, 0, 0];
            upp = [inf, inf, inf];
            [y_new, p, gof]=lorent_fit(ynorm(:,A1),[x(1) x(end)],guess,1000*FFT.e(A1),low,upp);
            guess = coeffvalues(p);
            a = guess(1);
            b = guess(2);
            c = guess(3);
            %% starting guess, lower and upper bounds

            startpos=peakpos{l};
            guess = [a, b, 0.5, startpos(1), 10, 0.5, startpos(2), 10, 0.5, startpos(3), 10, c];
            low=[0, 0, c, startpos(1)-w1, 0, c, startpos(2)-w2, 0, c, startpos(3)-w3, 0, 0 ];
            upp=[10*a, 10*b, inf, startpos(1)+w1, 2*w1, inf, startpos(2)+w2, 2*w2, inf, startpos(3)+w3, 2*w3, c*10 ];

            for i=1:10
                [y_new, p, gof] = complete_fit_triple(ynorm(:,A1),[x(1) x(end)],guess,1000*FFT.e(k),low,upp);
                guess = coeffvalues(p);
                low=[0, 0, c, guess(4)-w1, 0, c, guess(7)-w2, 0, c, guess(10)-w3, 0, 0 ];
                upp=[10*a, 10*b, inf, guess(4)+w1, 2*w1, inf, guess(7)+w2, 2*w2, inf, guess(10)+w3, 2*w3, c*10 ];
            end
                
            close all
                
            t=1;
            for k=A1:A2
            [y_new, p, gof] = complete_fit_triple(ynorm(:,k),[x(1) x(end)],guess,1000*FFT.e(k),low,upp);
            guess = coeffvalues(p);
            elimits = confint(p);
            low=[0, 0, c, guess(4)-w1, 0, c, guess(7)-w2, 0, c, guess(10)-w3, 0, 0 ];
            upp=[10*a, 10*b, inf, guess(4)+w1, 2*w1, inf, guess(7)+w2, 2*w2, inf, guess(10)+w3, 2*w3, c*10 ];
            q(1,t) = guess(4);
            q(2,t) = guess(7);
            q(3,t) = guess(10);
            ql(1,t) = abs(guess(4)-elimits(1,4));
            qr(1,t) = abs(guess(4)-elimits(2,4));
            ql(2,t) = abs(guess(7)-elimits(1,7));
            qr(2,t) = abs(guess(7)-elimits(2,7));
            ql(3,t) = abs(guess(10)-elimits(1,10));
            qr(3,t) = abs(guess(10)-elimits(2,10));
            hgif(t) = gof.rmse;
            t = t+1; 
            end
            
            
            figure;
            herrorbar(q(1,:),FFT.e(A1:A2),ql(1,:),qr(1,:),'.')
            figure;
            herrorbar(q(2,:),FFT.e(A1:A2),ql(2,:),qr(2,:),'.')
            figure;
            herrorbar(q(3,:),FFT.e(A1:A2),ql(3,:),qr(3,:),'.')
            figure;
            plot(FFT.e(A1:A2),hgif,'.')
            close all
        end
    qall{l}=q;
    qlall{l}=ql;
    qrall{l}=qr;
end





end