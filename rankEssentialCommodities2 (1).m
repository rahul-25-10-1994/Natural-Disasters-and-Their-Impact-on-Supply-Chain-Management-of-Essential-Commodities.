function [essencom_low]=rankEssentialCommodities2(filename2, indexColumns)
    % rankEssentialCommodities ranks commodities by their predicted importance
    % based on weighted indices and a linear regression model.
    data = readtable(filename2); 

    % Extract commodity weights
    weights = data.COMM_WT; 
    
    % Extract the relevant index columns dynamically based on user input
    indices = data{:, indexColumns}; 

    % Create features and target variable
    features = indices .* weights; % Weighted indices
    target = weights; % You could adjust this to be a better target if needed

    % Fit linear regression model
    mdl = fitlm(features, target);

    % Predict values based on the linear model
    predictions = predict(mdl, features);

    % Add predictions to the original data
    data.PredictedImportance = predictions;

    % Sort the data by predicted importance (highest to lowest)
    sortedData = sortrows(data, 'PredictedImportance', 'descend');

    % Select top 10 essential commodities
    top20EssentialCommodities = sortedData(1:20, :);
    

% Remove braces from the 'COMM_NAME' column using strrep
top20EssentialCommodities.COMM_NAME = strrep(top20EssentialCommodities.COMM_NAME, '{', '');
top20EssentialCommodities.COMM_NAME = strrep(top20EssentialCommodities.COMM_NAME, '}', '');


    essencom_low=(top20EssentialCommodities(:, {('COMM_NAME'), 'COMM_WT', 'PredictedImportance'}));
    disp(mdl)
end
