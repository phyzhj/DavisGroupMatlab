function exp_movie_dialogue_mask(map,energy,rx,ry,clmap,clbnd,ldosmask)
%creat dialogue box
fh=figure('Name', 'Export AVI Movie',...
        'units','normalized', ...
        'Position',[0.5,0.5,0.25,0.15],...
        'Color',[0.6 0.6 0.6],...
        'MenuBar', 'none');
    axis off;
    %default path for exporting
    % Mac
%     export_path = '/Users/petersprau/Documents/STMvideos';  
    % Windows
    % export_path = 'C:\Users\Oliver\Documents\STMvideos'; 
    export_path = 'C:\Users\Peter\Documents\STMvideos'; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GUI Controls%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    filename_entry_text = uicontrol(fh,'Style','text',...
                                       'String','Filename',...
                                       'units','normalized',...
                                       'Position',[0.04,0.7,0.15,0.12]);
            
    filename_entry = uicontrol(fh,'Style','Edit',...
                                  'units','normalized',...
                                  'Position',[0.2,0.7,0.75,0.15],...
                                  'FontWeight','Bold');  
                                                     
    fps_set = uicontrol(fh,'Style','Edit',...
                           'String','24',...
                           'units','normalized',...
                           'Position', [0.2 0.08 0.1 0.12]);
                             
    quality_text = uicontrol(fh,'Style','text',...
                            'String','Quality(1-100)',...
                            'units','normalized',...
                            'Position',[0.35,0.08,0.2,0.12]);
                        
                        
    quality_set = uicontrol(fh,'Style','Edit',...
                           'String','75',...
                           'units','normalized',...
                           'Position', [0.56 0.08 0.1 0.12]);
                             
    fps_text = uicontrol(fh,'Style','text',...
                            'String','fps',...
                            'units','normalized',...
                            'Position',[0.04,0.08,0.15,0.12]);
                             
    dir_entry = uicontrol(fh,'Style','Edit',...
                             'String',export_path,...
                             'units','normalized',...
                             'Position',[0.2,0.5,0.75,0.15],...
                             'FontWeight','Bold'); 
                           
    dir_entry_text = uicontrol(fh,'Style','text',...
                                  'String','Directory',...
                                  'units','normalized',...
                                  'Position',[0.04,0.5,0.15,0.12]);
    
                           
    dir_choose = uicontrol(fh,'Style','pushbutton',...
                              'String','Choose Directory',...
                              'units','normalized',...
                              'Position',[0.2 0.34 0.2 0.15],...
                              'Callback',(@open_dir_Callback));   
                          
    export_but = uicontrol(fh,'Style','pushbutton',...
                              'String','Export Map!',...
                              'units','normalized',...
                              'Position',[0.75 0.1 0.2 0.3],...
                              'Callback',{@export_Callback,map,rx,ry,energy,clmap,clbnd});   

%%%%%%%%%%%%%%%%%%%%%%%%%Callback Functions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                               
    function open_dir_Callback(hObject, evendata)                           
        
        % Mac
        exp_directory = uigetdir('/Users/petersprau/Documents/STMvideos');
        % Windows
%         exp_directory = uigetdir('C:\Users\Oliver\Documents\STMvideos');
        set(dir_entry,'String',exp_directory);
    end                
    function export_Callback(hObject,evendata,map,rx,ry,energy,clmap,clbnd)
        frps = str2num(get(fps_set,'String'));
        directory = get(dir_entry,'String');
        filename = get(filename_entry,'String');
        quality = str2num(get(quality_set,'String'));
        if directory(end) ~= '\'
            directory =  strcat(directory,'\');
        end
        if isempty(filename)
            set(filename_entry,'String','Please Enter a File Name')
            return;
        else            
            exp_movie_mask(map,energy,rx,ry,directory,filename,clmap,clbnd,frps,quality,ldosmask);
        end
    end

end
