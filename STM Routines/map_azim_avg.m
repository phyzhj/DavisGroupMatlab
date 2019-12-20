function new_data = map_azim_avg(data)
    [nr nc nz] =size(data.map);
    avgmap = zeros(nr,nc,nz);
    divs = 10;
    rot = 90;
    for i = 0:divs-1
        avgmap = avgmap + rotate_map(data.map,i*rot/divs);
    end
    avgmap = avgmap/divs;
    new_data = data;
    new_data.map = avgmap;
end