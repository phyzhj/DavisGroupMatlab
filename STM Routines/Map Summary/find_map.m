function output = find_map(directory)
if directory(end) ~= '\'
    directory = [directory '\'];
end
output = [];
cd(directory);
c = dir;
for i = 3:length(c)
    if (c(i).isdir == 0 && strcmp(c(i).name(end-2:end),'2FL'))
        h = read_file_info([directory c(i).name]);
        output = [output h];        
    elseif (c(i).isdir == 1)         
        output = [output find_map([directory c(i).name])];
    end    
end
 cd(directory);
end
function hs = read_file_info(name)
% DOUMENT INFO, offset256
r_offset = 256;
fid=fopen(name);
hs.filename = name;
%XXX - DATE
start=25;
fseek(fid,r_offset+start-1,'bof');
hs.date = strtok(fread(fid,20, 'bit8=>char',00,'l')');
%XXX

%XXX - DESCRIPTION
start=45;
fseek(fid,r_offset+start-1,'bof');
hs.description=fread(fid,40, 'bit8=>char','l')';
%XXX

%XXX
start=151;
fseek(fid,r_offset+start-1,'bof');
hs.irows=fread(fid,1, 'bit16',00,'l')';
%XXX

%XXX
start=155;
fseek(fid,r_offset+start-1,'bof');
hs.icols=fread(fid,1, 'bit16',00,'l')';
%XXX

%XXX
start=225;
fseek(fid,r_offset+start-1,'bof');
hs.ilayers=fread(fid,1, 'bit16',00,'l')';
%XXX

%XXX - x length
start=163;
fseek(fid,r_offset+start-1,'bof');
x_distmin=fread(fid,1, 'float','l')';

start=167;
fseek(fid,r_offset+start-1,'bof');
x_distmax=fread(fid,1, 'float','l')';

hs.xdist=x_distmax - x_distmin;

%XXX - y length
start=171;
fseek(fid,r_offset+start-1,'bof');
y_distmin = fread(fid,1, 'float','l')';

start=175;
fseek(fid,r_offset+start-1,'bof');
y_distmax=fread(fid,1, 'float','l')';
%XXX
hs.ydist = y_distmax - y_distmin;


%%%%%%%%%%%% scan parameters, offset 1280 %%%%%%%%%%%%%%%%%%%%%%%
%XXX
r_offset = 1280;
start=1;
fseek(fid,r_offset+start-1,'bof');
hs.s_startvolt=fread(fid,1, 'float','l')';
%XXX

%XXX
start=5;
fseek(fid,r_offset+start-1,'bof');
hs.s_endvolt=fread(fid,1, 'float','l')';
%XXX


%%%%%%%%%%%% additional scan parameters, offset 1384 %%%%%%%%%%%%%%%%%%%
r_offset = 1384;
%XXX
start=23;
fseek(fid,r_offset+start-1,'bof');
hs.s_vtip=fread(fid,1, 'float','l')';
%XXX

%XXX
start=27;
fseek(fid,r_offset+start-1,'bof');
hs.s_itip=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
hs.s_jr=abs(hs.s_vtip/hs.s_itip);
end