function new_phase = phase_slip_correct_dialogue_hex(phase)
new_phase = [];
%color_map_path = 'C:\Analysis Code\MATLAB\STM View\Color Maps\'; 
% windows
%color_map_path = 'C:\Users\feynman\Documents\MATLAB\Analysis Code\MATLAB\STM View\Color Maps\';
% MAC OSX
color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';  
color_map = struct2cell(load([color_map_path 'Defect1.mat']));
color_map = color_map{1};
fh = figure('Units','characters',...
'MenuBar','none',...
'Name','Phase Slip Correction',...
'NumberTitle','off',...
'Position',[1 1 210 55],...
'WindowButtonMotionFcn',@get_axes_pos,...
'Resize','off',...
'UserData',[],...
'Visible','on');

%temporary phase that will be modified with a second copy of the phases for
%UNDO procedures
tmp_phase = phase;
tmp_phase.theta1_old = tmp_phase.theta1;
tmp_phase.theta2_old = tmp_phase.theta2;
tmp_phase.theta3_old = tmp_phase.theta3;

set(fh,'UserData',tmp_phase);
[nr nc] = size(tmp_phase.theta1);
%clear tmp_phase;
% axis for unmodified phase map
phase_original = axes(...
'Parent',fh,...
'Units','characters',...
'Position',[7 7.05000000000001 94 46]);

phase_fixed = axes(...
'Parent',fh,...
'Units','characters',...
'Position',[110 7.05 94 46]);

dir_button_group = uibuttongroup(...
'Parent',fh,...
'Units','characters',...
'Title','Select Phase Map',...
'Clipping','on',...
'Position',[7 1.3 17.7142857142857 5.3]);
% 'Position',[7 1.3 17.7142857142857 3.75]);

button_1 = uicontrol(...
'Parent',dir_button_group,...
'Units','characters',...
'Position',[1.57142857142857 2.45 13 1.25],...
'String','Direction 1',...
'Style','radiobutton');

button_2 = uicontrol(...
'Parent',dir_button_group,...
'Units','characters',...
'Position',[1.57142857142857 1.3 13 1.25],...
'String','Direction 2',...
'Style','radiobutton');

button_3 = uicontrol(...
'Parent',dir_button_group,...
'Units','characters',...
'Position',[1.57142857142857 0.15 13 1.25],...
'String','Direction 3',...
'Style','radiobutton');

set(dir_button_group,'SelectionChangeFcn',@phase_sel_Callback);
set(dir_button_group,'UserData',1);

h15 = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[7 54 20 1.0],...
'String','Original Phase Map',...
'Style','text');

h16 = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[130 54 20 1.0],...
'String','Corrected Phase Map',...
'Style','text');

coord_tb = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[25 5.5 40 1.0],...
'Style','text');

coord_tb2 = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[160 5.5 40 1.0],...
'Style','text');

bttns = uibuttongroup(...
'Parent',fh,'Units','characters',...
'visible', 'on', 'Position', [71.2857142857143 1.3 20 3]);
uplus = uicontrol('Units','characters','Style','radiobutton','String',...
    'Add 2 pi','pos', [0 1.5 16 0.9],'Parent',bttns,...
    'HandleVisibility', 'off');
uminus = uicontrol('Units','characters','Style','radiobutton','String',...
    'Subtract 2 pi','pos', [0 0.5 16 0.9],'Parent',bttns,...
    'HandleVisibility', 'off');
%set(bttns,'SelectionChangeFcn',@selcbk);

str={['X: ' num2str(0, '%6.0f'),...
   '    ' 'Y: ' num2str(0,'%6.0f'),...
   '    ' 'Phase: ' num2str(0,'%6.2f')]};
   
set(coord_tb,'String',str);
set(coord_tb2,'String',str);

cols = 1:nr; cols = cols';
rows = 1:nr; rows = rows';

st_X_slide = uicontrol(...
'Parent',fh,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[36 3.0 9 0.6],...
'Min',1,'Max',nc,'Value',1,...
'Style','slider');
st_X_edit = uicontrol(....
    'Parent',fh,...
    'Units','characters',...
    'BackgroundColor',[1 1 1],...
    'Position',[36 3.7 9 1],...
    'String',1,...
    'Style','edit');
set(st_X_slide,'Callback',{@slider_Callback,st_X_edit,st_X_slide});
set(st_X_edit,'Callback',{@slider_edit_Callback,st_X_edit,st_X_slide});
    
end_X_slide = uicontrol(...
'Parent',fh,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[36 1.05 9 0.6],...
'Min',1,'Max',nc,'Value',1,...
'Style','slider');
end_X_edit = uicontrol(....
    'Parent',fh,...
    'Units','characters',...
    'BackgroundColor',[1 1 1],...
    'Position',[36 1.75 9 1],...
    'String',1,...
    'Style','edit');
set(end_X_slide,'Callback',{@slider_Callback,end_X_edit,end_X_slide});
set(end_X_edit,'Callback',{@slider_edit_Callback,end_X_edit,end_X_slide});

st_Y_slide = uicontrol(...
'Parent',fh,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[55.5 3.0 9 0.6],...
'Min',1,'Max',nr,'Value',1,...
'Style','slider');
st_Y_edit = uicontrol(....
    'Parent',fh,...
    'Units','characters',...
    'BackgroundColor',[1 1 1],...
    'Position',[55.5 3.7 9 1],...
    'String',1,...
    'Style','edit');
set(st_Y_slide,'Callback',{@slider_Callback,st_Y_edit,st_Y_slide});
set(st_Y_edit,'Callback',{@slider_edit_Callback,st_Y_edit,st_Y_slide});

end_Y_slide = uicontrol(...
'Parent',fh,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[55.5 1.05 9 0.6],...
'Min',1,'Max',nr,'Value',1,...
'Style','slider');
end_Y_edit = uicontrol(....
    'Parent',fh,...
    'Units','characters',...
    'BackgroundColor',[1 1 1],...
    'Position',[55.5 1.75 9 1],...
    'String',1,...
    'Style','edit');
set(end_Y_slide,'Callback',{@slider_Callback,end_Y_edit,end_Y_slide});
set(end_Y_edit,'Callback',{@slider_edit_Callback,end_Y_edit,end_Y_slide});


h22 = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[28.1428571428571 3.7 7.42857142857143 0.9],...
'String','Start X',...
'Style','text',...
'Tag','text4');

h23 = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[28.1428571428571 1.7 7.42857142857143 0.9],...
'String','End X',...
'Style','text',...
'Tag','text5');

h24 = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[47.7142857142857 3.7 7.42857142857143 0.9],...
'String','Start Y',...
'Style','text');

h25 = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[47.8571428571429 1.7 7.42857142857143 0.9],...
'String','End Y',...
'Style','text');

tol_entry = uicontrol(...
'Parent',fh,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[81.2857142857143 5.05 11.4285714285714 1.35],...
'String', '0',...
'Style','edit');

tol_entry_title = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[71.2857142857143 5.3 9 0.9],...
'String','Tolerance:',...
'Style','text');

adj_phase = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[96.7142857142857 5.15 14.4285714285714 1.2],...
'String','Adjust Phase',...
'Callback',@adjust_phase_Callback);

undo_button = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[96.7142857142857 3.25 14.4285714285714 1.2],...
'String','Undo Last',...
'Callback',@undo_Callback);

h30 = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[96.7142857142857 1.35 14.4285714285714 1.2],...
'String','Undo All',...
'Callback',@undo_all_Callback);

h31 = uicontrol(...
'Parent',fh,...
'Units','characters',...
'Position',[114.142857142857 4.85000000000001 14.4285714285714 1.85],...
'String','DONE',...
'Callback',@done_Callback);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAIN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % initialize axes with phase data
    axes(phase_original);
    imagesc(tmp_phase.theta1); axis off; shading flat;
    colormap(color_map);
    
    axes(phase_fixed);
    imagesc(tmp_phase.theta1); axis off; shading flat;
    colormap(color_map);
    
    % initialize selection box
    set(dir_button_group,'UserData',1);
    axes(phase_original);
    guidata(phase_original,0);
    
    % set a marker - used to determine if the mouse has been clicked a
    % first time - then can activate draw rectangle tool
    set(adj_phase,'UserData',0);   
    box_coord_Callback;
    set(fh,'WindowButtonDownFcn',@init_rect_Callback);
    set(fh,'WindowButtonUpFcn',@box_coord_Callback);         
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Callback Functions %%%%%%%%%%%%%%%%%%%%%%%%%%
    function get_axes_pos(src,evnt)
        data = get(fh,'UserData');
        cp = get(phase_original,'CurrentPoint');
        xinit = round(cp(1,1));yinit = round(cp(1,2));
        if xinit > nc || yinit > nr || xinit < 1 || yinit < 1
            %return;
            cp = get(phase_fixed,'CurrentPoint');
            xinit = round(cp(1,1));yinit = round(cp(1,2));
            if xinit > nc || yinit > nr || xinit < 1 || yinit < 1
                return;
            end
            sel = get(dir_button_group,'UserData');
            if sel == 1
                z = data.theta1(yinit,xinit);
            elseif sel == 2
                z = data.theta2(yinit,xinit);
            elseif sel == 3
                z = data.theta3(yinit,xinit);            
            end
            str={['X: ' num2str(xinit, '%6.0f'),...
                '    ' 'Y: ' num2str(yinit,'%6.0f'),...
                '    ' 'Phase: ' num2str(z,'%6.2f')]};
            
            set(coord_tb2,'String',str);
            set(coord_tb2,'UserData',[xinit yinit]);
        end
        
        sel = get(dir_button_group,'UserData');
        if sel == 1
                z = phase.theta1(yinit,xinit);
        elseif sel == 2
                z = phase.theta2(yinit,xinit);
        elseif sel == 3
                z = phase.theta3(yinit,xinit);
        end
        str={['X: ' num2str(xinit, '%6.0f'),...
        '    ' 'Y: ' num2str(yinit,'%6.0f'),...
        '    ' 'Phase: ' num2str(z,'%6.2f')]};
   
        set(coord_tb,'String',str);
        set(coord_tb,'UserData',[xinit yinit]);        
     end
 
    function adjust_phase_Callback(hObject,eventdata)
        a = get(get(bttns,'SelectedObject'),'String');
        if(strcmp(a,'Add 2 pi'))
            flag = 1; 
        else
            flag = -1;
        end
        x1 = str2num(get(st_X_edit,'String'));
        y1 = str2num(get(st_Y_edit,'String'));
        x2 = str2num(get(end_X_edit,'String'));
        y2 = str2num(get(end_Y_edit,'String'));        
        sel = get(dir_button_group,'UserData');
        tol_val = str2num(get(tol_entry,'String'))
        phase_new = get(fh,'UserData');
        adj_phase_routine(x1,y1,x2,y2,sel,fh,phase_fixed,tol_val,color_map,flag)
    end
    
    function undo_Callback(hObject,eventdata)
        sel = get(dir_button_group,'UserData');
        data = get(fh,'UserData');        
        if sel == 1
            data.theta1 = data.theta1_old;            
            axes(phase_fixed);
            imagesc(data.theta1); axis off; shading flat;
            colormap(color_map);         
        elseif sel == 2
            data.theta2 = data.theta2_old;                
            axes(phase_fixed);
            imagesc(data.theta2); axis off; shading flat;
            colormap(color_map); 
        elseif sel == 3
            data.theta3 = data.theta3_old;                
            axes(phase_fixed);
            imagesc(data.theta3); axis off; shading flat;
            colormap(color_map); 
        end
        set(fh,'UserData',data);      
        %guidata(phase_original,0);        
        box_coord_Callback;        
    end

    function undo_all_Callback(hObject,eventdata)
        sel = get(dir_button_group,'UserData');
        data = get(fh,'UserData');        
        if sel == 1
            data.theta1 = phase.theta1;
            data.theta1_old = phase.theta1;
            axes(phase_original);
            imagesc(data.theta1); axis off; shading flat;
            colormap(color_map);
            axes(phase_fixed);
            imagesc(data.theta1); axis off; shading flat;
            colormap(color_map);         
        elseif sel == 2
            data.theta2 = phase.theta2;
            data.theta1_old = phase.theta2;
            axes(phase_original);
            imagesc(data.theta2); axis off; shading flat;
            colormap(color_map);
            axes(phase_fixed);
            imagesc(data.theta2); axis off; shading flat;
            colormap(color_map);   
        elseif sel == 3
            data.theta3 = phase.theta3;
            data.theta1_old = phase.theta3;
            axes(phase_original);
            imagesc(data.theta3); axis off; shading flat;
            colormap(color_map);
            axes(phase_fixed);
            imagesc(data.theta3); axis off; shading flat;
            colormap(color_map);     
        end
        set(fh,'UserData',data);                
        guidata(phase_original,0);
        set(adj_phase,'UserData',0); % mark that rectangle needs to be reactivated       
        box_coord_Callback;                
    end

    function init_rect_Callback(hObject,eventdata)
        hit = get(adj_phase,'UserData');             
        if hit == 0
            set(adj_phase,'UserData',1);            
            h = imrect(phase_original);            
            if isvalid(h)               
                fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
                setPositionConstraintFcn(h,fcn);        
                guidata(phase_original,h);
                box_coord_Callback;           
            end           
        else 
            return;
        end
        set(adj_phase,'UserData',1);
    end
    function box_coord_Callback(hObject,eventdata) 
        hh = guidata(phase_original);
        gg = get(adj_phase,'UserData');
        if hh == 0 || gg == 0
            return;
        end
        pos = getPosition(hh);
        setPosition(hh,round(pos));
        pos = getPosition(hh);        
        set(st_X_edit,'String',num2str(pos(1)));
        set(st_Y_edit,'String',num2str(pos(2)));
        set(end_X_edit,'String',num2str(pos(1)+pos(3)-1));
        set(end_Y_edit,'String',num2str(pos(2)+pos(4)-1));
        
        set(st_X_slide,'Value',pos(1));
        set(st_Y_slide,'Value',pos(2));
        set(end_X_slide,'Value',pos(1)+pos(3)-1);
        set(end_Y_slide,'Value',pos(2)+pos(4)-1);
    end

    function done_Callback(hObject,eventdata)               
        new_phase = get(fh,'UserData');      
        %assignin('base','phi_map_cor',new_phase);        
        delete(fh);
    end

    function slider_Callback(hObject,eventdata,edit_handle,slider_handle)
        a = floor(get(slider_handle,'Value'));
        set(slider_handle,'Value',a);
        set(edit_handle,'String',num2str(a));
        
        %alter the rectangle position based on slider motion
        new_h = guidata(phase_original);
        x1 = str2num(get(st_X_edit,'String'));
        y1 = str2num(get(st_Y_edit,'String'));
        x2 = str2num(get(end_X_edit,'String'));
        y2 = str2num(get(end_Y_edit,'String'));
        setPosition(new_h,[x1,y1,abs(x2-x1)+1,abs(y2-y1)+1]);
    end
    function slider_edit_Callback(hObject,eventdata,edit_handle,slider_handle)
        a = round(str2double(get(edit_handle,'String')));
        if a < get(slider_handle,'Min') || a > get(slider_handle,'Max')
            b = round(get(slider_handle,'Value'));
            set(edit_handle,'String',num2str(b));
            return;
        end
        set(slider_handle,'Value',a);
        set(edit_handle,'String',num2str(a));
         new_h = guidata(phase_original);
        x1 = str2num(get(st_X_edit,'String'));
        y1 = str2num(get(st_Y_edit,'String'));
        x2 = str2num(get(end_X_edit,'String'));
        y2 = str2num(get(end_Y_edit,'String'));
        setPosition(new_h,[x1,y1,abs(x2-x1)+1,abs(y2-y1)+1]);
    end

    function phase_sel_Callback(hObject,eventdata)
       
        data = get(fh,'UserData');
        sel_string = get(eventdata.NewValue,'String');
        sel = str2num(sel_string(end));
        set(phase_fixed,'UserData',1);
        guidata(phase_original)
        if guidata(phase_original) ~=0
            delete(guidata(phase_original));
        end
        guidata(phase_original,0);
        set(adj_phase,'UserData',0);
        set(dir_button_group,'UserData',sel);                 
        redraw_axes(sel,phase_original,phase_fixed,phase,data,color_map);                  
        box_coord_Callback;
    end
  waitfor(fh);
end
function redraw_axes(sel,phase_axis_handle1,phase_axis_handle2,phase_data,tmp_phase_data,c_map)
    if sel == 1
          axes(phase_axis_handle1);
          imagesc(phase_data.theta1); shading flat;
          colormap(c_map); axis off;         
          axes(phase_axis_handle2)
          imagesc(tmp_phase_data.theta1);
          colormap(c_map); axis off; shading flat;                    
    elseif sel == 2
          axes(phase_axis_handle1);
          imagesc(phase_data.theta2); shading flat;
          colormap(c_map); axis off;          
          axes(phase_axis_handle2)
          imagesc(tmp_phase_data.theta2);
          colormap(c_map); axis off; shading flat;
    elseif sel == 3
          axes(phase_axis_handle1);
          imagesc(phase_data.theta3); shading flat;
          colormap(c_map); axis off;          
          axes(phase_axis_handle2)
          imagesc(tmp_phase_data.theta3);
          colormap(c_map); axis off; shading flat;        
    end    
  
end

function adj_phase_routine(x1,y1,x2,y2,selection,phase_data_handle,axis_handle,tol,c_map,flag)               
        phase_data = get(phase_data_handle,'UserData');
        if selection == 1
            tmp_phase = phase_data.theta1;
        elseif selection == 2
            tmp_phase = phase_data.theta2;
        elseif selection == 3 
            tmp_phase = phase_data.theta3;
        end
        tmp = tmp_phase(y1:y2,x1:x2);        
%         A = tmp < 0;
%         B = tmp > 0;   
        if((flag+1))
            A2 = tmp < tol;            
            tmp(A2) = tmp(A2) + flag*2*pi;                 
        else

            B2 = tmp > tol;          
            tmp(B2) = tmp(B2) + flag*2*pi;
        end
        
%         if sum(sum(A)) >= sum(sum(B))
%             A2 = tmp < tol;            
%             tmp(A2) = tmp(A2) + flag*2*pi;                 
%         else
%             B2 = tmp > tol;          
%             tmp(B2) = tmp(B2) - flag*2*pi;
%         end
        
        tmp_phase(y1:y2,x1:x2) = tmp;
        if selection == 1            
            phase_data.theta1_old = phase_data.theta1; 
            % save previous for UNDO command
            phase_data.theta1 = tmp_phase;
        elseif selection == 2
            phase_data.theta2_old = phase_data.theta2;
            phase_data.theta2 = tmp_phase;
        elseif selection ==3
            phase_data.theta3_old = phase_data.theta3;
            phase_data.theta3 = tmp_phase;            
        end            

        set(phase_data_handle,'UserData',phase_data);
        axes(axis_handle);
        imagesc(tmp_phase); axis off; colormap(c_map);            
        
end


