% Load HYCOM data
filename = 'hawaii_soest_ts.nc';
lat = ncread(filename, 'latitude');
lon = ncread(filename, 'longitude');
depth = ncread(filename, 'LEV');
temp = ncread(filename, 'water_temp');

% Select zonal section to plot
lon_range = [120, 135]; % index of latitude to plot
lat_index = 26; % longitude range to plot
depth_min = 0; % minimum longitude of ROI
depth_max = 1000; % maximum longitude of ROI

% Find nearest latitude indices to lat_range
[~,lon_min_index] = min(abs(lon-lon_range(1)));
[~,lon_max_index] = min(abs(lon-lon_range(2)));
depth_idx = find(depth >= depth_min & depth <= depth_max);

% Extract data for selected zonal section and latitude range
temp_zonal = squeeze(temp(lon_min_index:lon_max_index,lat_index,depth_idx,1));%lon,lat,depth,time
depth_zonal = squeeze(depth(depth_idx));
temp_zonal(temp_zonal<-1000) = nan; 

% Create zonal profile plot
figure;
pcolor(lon(lon_min_index:lon_max_index), -depth_zonal, temp_zonal');
shading interp;
colorbar;
xlabel('Longitude');
ylabel('Depth (m)');
title(['Zonal Profile at Latitude ', num2str(lat_index)]);
