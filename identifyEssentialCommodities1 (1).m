function [MostImportantEssentialCommodities]=identifyEssentialCommodities1(essencom_high, essencom_low)

% Identify the essential commodities based on the condition
essenindex = [];
for i = 1:19
    if essencom_high.PredictedImportance(i) > essencom_low.PredictedImportance(i)
        essenindex = [essenindex, i];
    end
end

% Extract the important values for high and low importance
mostimp1 = essencom_high.PredictedImportance(essenindex);  % Predicted Importance (high)
mostimp2 = essencom_low.PredictedImportance(essenindex);   % Predicted Importance (low)

% Calculate the predicted differences
predicted_diff = mostimp1 - mostimp2;

% Calculate the overall sum of the predicted differences
overall_diff = sum(predicted_diff);

% Calculate percentages for each commodity's predicted difference
percentages = (predicted_diff / overall_diff) * 100;

% Extract the names of the essential commodities
esse = essencom_high.COMM_NAME;
tessentialcommodities = esse(essenindex);

% Clean up the names of the essential commodities
essentialcommodities1 = cellfun(@(x) strtrim(regexprep(x, '^[I\b]\.?\s*|\([A-Z]\)\.\s*', '')), tessentialcommodities, 'UniformOutput', false);
essentialcommodities = cellfun(@(x) strtrim(regexprep(x, '^[I(b]\.?\s*|\([A-Z]\)\.\s*', '')), essentialcommodities1, 'UniformOutput', false);
MostImportantEssentialCommodities=table(essentialcommodities,predicted_diff,percentages);

% Create a figure with a larger size to ensure labels are not cut off
figure('Position', [100, 100, 800, 600]); % Increase figure size

% Create the pie chart
h = pie(percentages);

% Add labels to the pie chart with commodity names and their corresponding percentages
labels = strcat(essentialcommodities, ': ', num2str(percentages(:), '%.2f'), '%');

% Set labels for the pie chart slices
for k = 1:length(h)
    if mod(k, 2) == 0  % Labels are on even indices (since pie chart has a pattern of pairs)
        h(k).String = labels{k/2};  % Add the label text
    end
end

% Get the handles of the patch objects (pie slices)
patchHandles = h(1:2:end);  % Odd-numbered elements correspond to the patches (pie slices)

% Set random colors for each slice (using patch handles)
for i = 1:length(patchHandles)
    patchHandles(i).FaceColor = rand(1, 3);  % Random color for each slice
end

% Adjust the label position to prevent overlap but not too far
for k = 1:length(h)
    if mod(k, 2) == 0  % Only adjust text objects
        labelObj = h(k);
        pos = labelObj.Position;  % Get current label position
        
        % Move labels further out with a moderate factor
        factor = 1.15;  % Increase factor slightly to move labels further out
        labelObj.Position = pos * factor;  
    end
end

% Adjust title position to prevent it from overlapping with the pie chart
titleObj = title('Predicted Difference of High vs Low Essential Commodities');
set(titleObj, 'Position', [0, 1.05, 0]); % Title inside the plot area, just above the pie slices

% Ensure aspect ratio is equal so pie chart doesn't get distorted
axis equal;
end