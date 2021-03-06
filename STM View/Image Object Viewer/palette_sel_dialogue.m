function palette_sel_dialogue(fig_handle,current_colormap)
fh=figure('Name', 'Color Palette Selection',...
        'units','normalized', ...
        'Position',[0.3,0.3,0.18,0.2],...
        'Color',[0.6 0.6 0.6],...
        'MenuBar', 'none',...
        'NumberTitle', 'off',...
        'Resize','off');

% possible colors
% Mac
% color_map_path = '/Users/chongsprau/Documents/MATLAB/STM/MATLAB/STM View/Color Maps/';
% Windows
% color_map_path = 'C:\Users\Oliver\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\'; 
color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\'; 
%load colors from directory
c = dir([color_map_path '*.mat']);
for i = 1:length(c)
    colors{i} = c(i).name(1:end-4);
end

color_map = struct2cell(load([color_map_path colors{2}]));
color_map = color_map{1};

%%%%%%%%%%%%%%%%%%%%%%%%%%%GUI CONTROLS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%construct string of names for popup menu
str = [colors{1} '|'];
for i = 2:length(colors)-1
    str = [str colors{i} '|'];
end
str = [str colors{end}];

color_pop = uicontrol(fh,'Style', 'popup',... 
       'units','normalized',...
       'Value',2,...
       'String', str,...
       'Position', [0.05 0.45 0.5 0.5],...
       'Callback',@plot_Callback);

col_axis = axes('Units','normalized','Position',[0.6,0.05,0.1,0.9]); 

OK_but = uicontrol(fh,'Style','pushbutton',...
                          'String','OK',...    
                          'units','normalized',...
                          'Position',[0.75 0.6 0.2 0.2],...
                          'Callback',(@OK_Callback));                      
                          
cancel_but = uicontrol(fh,'Style','pushbutton',...
                          'String','Cancel',...
                          'units','normalized',...
                          'Position',[0.75 0.2 0.2 0.2],...
                          'Callback',(@cancel_Callback));
                         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MAIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = linspace(0,1,300);
for i = 1:50
    palette(1:300,i) = x;
end
pcolor(palette); shading flat; axis off; colormap(color_map);
%%%%%%%%%%%%%%%%%%%%%%%Callback Functions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function plot_Callback(hObject,eventdata)
        val = get(color_pop,'Value');
        color_name = colors{val};
        color_map = struct2cell(load([color_map_path color_name]));
        color_map = color_map{1};
        set(fh,'Colormap',color_map);
        set(fig_handle,'Colormap',color_map);
    end

    function OK_Callback(hObject,eventdatda)
        set(fig_handle,'Colormap',color_map);
        close(fh);
    end

    function cancel_Callback(hObject,eventdata)
        set(fig_handle,'Colormap',current_colormap);
        close(fh);
    end
        

end