% Load HYCOM data
filename = 'hawaii_soest_ts.nc';
lat = ncread(filename, 'latitude');
lon = ncread(filename, 'longitude');
depth = ncread(filename, 'LEV');
temp = ncread(filename, 'water_temp');

% Select zonal section to plot
lon_index = 120; % index of longitude to plot
lat_range = [26, 30]; % latitude range to plot
depth_min = 0; % minimum depth of ROI
depth_max = 1000; % maximum depth of ROI

% Find nearest latitude indices to lat_range
[~,lat_min_index] = min(abs(lat-lat_range(1)));
[~,lat_max_index] = min(abs(lat-lat_range(2)));
depth_idx = find(depth >= depth_min & depth <= depth_max);

% Extract data for selected zonal section and latitude range
temp_zonal = squeeze(temp(lon_index,lat_min_index:lat_max_index,depth_idx,1));%lon,lat,depth,time
depth_zonal = squeeze(depth(depth_idx));
temp_zonal(temp_zonal<-1000) = nan; 
% Create zonal profile plot
figure;
pcolor(lat(lat_min_index:lat_max_index), -depth_zonal, temp_zonal');
shading interp;
colorbar;
xlabel('Latitude');
ylabel('Depth (m)');
title(['Zonal Profile at Longitude ', num2str(lon_index)]);
