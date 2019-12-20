function copy_data_dialogue
fh = figure('Name','Copy Data to Structure',...
              'NumberTitle', 'off',...                            
              'Position',[150,150,350,400],...
              'MenuBar', 'none',...
              'Resize','off');
% download all variables in base workstation and separate out the
% sturctures
data_names = evalin('base','who');         
count = 0;
for i = 1:length(data_names)
    if evalin('base',['isstruct(' data_names{i} ')' ])
        count = count + 1;
        struct_names{count} = data_names{i};
    end
end
          
copy_title = uicontrol('Parent',fh,'units','normalized',...
                       'Style','text',...
                       'String','Varaibles to Copy',...
                       'Position',[0.05 0.86,0.4 0.04]);

copy_list = uicontrol('Parent',fh,'units','normalized',...
                      'Style','listbox',...
                      'Position',[0.05 0.15 0.4 0.7],...
                      'String',data_names,...
                      'Min',1,'Max',1000);

struct_title = uicontrol('Parent',fh,'units','normalized',...
                       'Style','text',...
                       'String','Receiving Structure',...
                       'Position',[0.55 0.86,0.4 0.04]);
                  
struct_list = uicontrol('Parent',fh,'units','normalized',...
                      'Style','listbox',...
                      'Position',[0.55 0.15 0.4 0.7],...
                      'String',struct_names,...
                      'Min',1,'Max',1000);

copy_but = uicontrol('Parent',fh,'units','normalized',...
                   'Style','pushbutton',...
                   'String','Copy',...
                   'Position',[0.33 0.05 0.15 0.05],...
                   'Callback',@copy_Callback);
close_but = uicontrol('Parent',fh,'units','normalized',...
                   'Style','pushbutton',...
                   'String','Close',...
                   'Position',[0.52 0.05 0.15 0.05],...
                   'Callback',@close_Callback);

%%%%%%%%%%%%%%%%%%%%%%%%CALLBACK FUNCTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    function copy_Callback(hObject,eventdata)
        copy_ind = get(copy_list,'Value')
        struct_ind = get(struct_list,'Value')
        
        for i = 1:length(struct_ind)            
            for j = 1:length(copy_ind)               
                evalin('base',[struct_names{struct_ind(i)} '.' data_names{copy_ind(j)} '=' data_names{copy_ind(j)}]);
            end
        end
        
    end

    function close_Callback(hObject,eventdata)
        close(fh);
    end


               
end