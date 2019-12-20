function auto_export(map1,map2,pathname,filename)
%initialize a data structure capable of storing 9 separate data sets
fdata = [];
for i = 1:9
    eval(['fdata.map' num2str(i) ' = [];']);
    eval(['fdata.e' num2str(i) ' = [];']);
    eval(['fdata.clmap' num2str(i) ' = [];']);
    eval(['fdata.clbnd' num2str(i) ' = [];']);
end

% FThandle = get_handle_tag('80921A00-G_0_polysub_ft_amplitude');
% RspaceHandle = get_handle_tag('80921A00-G_0_polysub');

FThandle = get_handle_tag(map2);
RspaceHandle = get_handle_tag(map1);


handle = [RspaceHandle,FThandle];


for panel_n=1:2
    data = guidata(handle(panel_n));%good
    colors.bnd = get(handle(panel_n),'UserData');%good
    colors.cmap = colormap(handle(panel_n));
    eval(['fdata.map' num2str(panel_n) '= data.map']);
    eval(['fdata.e' num2str(panel_n) '= data.e*1000']);
    eval(['fdata.clmap' num2str(panel_n) '= colors.cmap']);
    eval(['fdata.clbnd' num2str(panel_n) '= colors.bnd']);
end
% fdata

% pathname = 'C:\Users\chong\Documents\MATLAB\STMdata\MoTeSe\';
exp_movie_multipanel(fdata,1,2,pathname,[filename '_auto'],5,100);
% exp_movie_multipanel(fdata,1,2,directory,'blabla',10,100);




