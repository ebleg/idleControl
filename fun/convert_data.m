function [] = convert_data(dataFile)
%% CONVERT FAULTY MEASUREMENT DATA
% load measurement 

    data = load(dataFile); 
    meas_err = data.meas;
    

    % get field names
    field_name = fieldnames(meas_err); 
    field_name(strcmp(field_name, 'time')) = []; 

    % correct meas.time
    time_vec = 0:0.001:floor(meas_err.time(end)); 

    % interpolate accross all fields
    for k = 1:length(field_name)
        meas.(field_name{k}).time = time_vec; 
        meas.(field_name{k}).signals.values = ...
            interp1(meas_err.(field_name{k}).time, ...
            meas_err.(field_name{k}).signals.values, ...
            meas.(field_name{k}).time); 
    end

    % new time vector
    meas.time = time_vec; 

    if ismac || isunix
        save('./dat/measurementData/dynamic_0005_extracted_CORRECTED.mat', 'meas')
    end

    if ispc
        save('.\dat\measurementData\dynamic_0006_extracted_CORRECTED.mat', 'meas')
    end
end
    