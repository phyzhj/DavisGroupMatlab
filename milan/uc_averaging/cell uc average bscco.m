%% do uc average for BSCCO
im=imf;

%%
im2=im;

%% possibly resample it
imr=resample_block(im2);



%% get ~peaks
coa=get_about_maxima(imr,128,1);

%% remove peaks
coa2=add_remove_coords(imr,coa,0);

%% add peaks
coa3=add_remove_coords(imr,coa2,1);


%% un-resample
cod=coa3*2;

%% test
pcolor(im); shading interp;hold on;
colormap gray
plot(coe(:,2),coe(:,1),'rx')
%plot(cou(:,2),cou(:,1),'b+')
hold off

%% exact maxima
coe=get_exact_maxima(im, cod,3);
%% remove peaks
coe2=add_remove_coords(im,coe,0);

%% add peaks
coe3=add_remove_coords(im,coe2,1);
%% test a little A: remove some

%% test a little B: go for it
[uc,map4d]=average_cell(dMap,coe3(:,1),coe3(:,2),8);

%% get start pos
cos=get_start_coord(coe3);
%% ssx
ssx=29; ssy=29;
%% get auro border
cob=fing_border_atoms(cos,ssy,ssx,11);

%% get manual border
cob2=add_remove_coords(im,cob,2);


%% order
[coy,cox]=order_atom_pos(cob2,ssy,ssx,9);
%% test

%%

plot(cob2(:,2),cob2(:,1),'bo')
hold on
[sy,sx]=size(cox);
for k=1:sy
    for m=1:sx
        pause(.00001);
        plot(cox(k,m),coy(k,m),'r.');
    end
end
hold off


%% strech map
[xx,yy,newmap]=strech_map(cox,coy,14,dMap);

%%

[uc,map4d]=average_cell(dMap,co2(:,1),co2(:,2),8);
%%

plot(co(:,2),co(:,1),'b.')
%% get start coord
co2=get_start_coord(co)

%% get border coord
co2=fing_border_atoms(co2,ssy,ssx,11)

%%
ssx=29;ssy=29;

%%
figure
plot(co(:,2),co(:,1),'bo')
hold on
[sy,sx]=size(cox);
for k=1:sy
    for m=1:sx
        
        pause(1);
        plot(cox(k,m),coy(k,m),'bo');
    end
end
hold off

    