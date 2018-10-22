clear all;
close all;

scene_name = 'area_3';

data_dir = fullfile(scene_name, 'data');

cutout_dir = fullfile(data_dir, 'rgb');
cutout_extformat = '_domain_rgb.png';

json_dir = fullfile(data_dir, 'pose');
json_extformat = '_domain_pose.json';

json_mat_dir = fullfile(data_dir, 'pose_mat');
json_mat_extformat = '.pose.mat';

%% Make image list
imglist_matname = sprintf('%s_imgnames_all.mat', scene_name);

if exist(imglist_matname, 'file') ~= 2
    fnames_all = dir(fullfile(cutout_dir, ['*', cutout_extformat]));
    imagenames_all = cell(1, length(fnames_all));
    for ii = 1:1:length(fnames_all)
        this_imgname_split = strsplit(fnames_all(ii).name, cutout_extformat);
        imagenames_all{ii} = this_imgname_split{1};
    end
    
    save('-v6', imglist_matname, 'imagenames_all');
else
    load(imglist_matname, 'imagenames_all');
end
% keyboard;
%% Load infos
for ii = 1:1:length(imagenames_all)
    
    this_json_matname = fullfile(json_mat_dir, [imagenames_all{ii}, json_mat_extformat]);
    if exist(this_json_matname, 'file') ~= 2
        this_jsonname = fullfile(json_dir, [imagenames_all{ii}, json_extformat]);
        camera_data = loadjson(this_jsonname);
        
        %save
        if exist(json_mat_dir, 'dir') ~= 7; mkdir(json_mat_dir); end
        save('-v6', this_json_matname, 'camera_data');
    end
    fprintf('Load camera information: %d / %d done. \n', ii, length(imagenames_all));
end




