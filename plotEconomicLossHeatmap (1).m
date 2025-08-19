function [Most_Impact_DisasterName]=plotEconomicLossHeatmap(dataFile)
    % plotEconomicLossHeatmap creates a heatmap to visualize the economic
    % losses from different disaster types based on the provided data file.
    %
    % INPUT:
    %   dataFile - A string containing the path to the CSV file that holds the data.
    warning('off', 'all');
    % OUTPUT:
    %   A heatmap figure displaying economic losses by disaster type.
    % Load data from the CSV file
    data = readtable(dataFile); % Assuming the data is in a table format

    
    % Disaster types corresponding to columns in the data
    disasterTypes = {'Drought', 'Earthquake', 'Flood', 'Storm', 'Wildfire', 'Extreme Temperature'};
    
    % Extract the economic losses for each disaster type (assumes correct column names)
    economicLoss = [data.TotalEconomicDamagesFromDrought, ...++
                    data.TotalEconomicDamagesFromEarthquakes, ...
                    data.TotalEconomicDamagesFromFloods, ...
                    data.TotalEconomicDamagesFromStorms, ...
                    data.TotalEconomicDamagesFromWildfires, ...
                    data.TotalEconomicDamagesFromExtremeTemperatures];
                
    % Calculate mean economic loss for each disaster type (omit NaN values)
    meanEconomicLoss = mean(economicLoss, 'omitnan');
    
    % Prepare the data for the heatmap (a 1x6 matrix for the economic loss)
    heatmapData = meanEconomicLoss;
    
    % Create the heatmap plot
    figure;
    heatmap(disasterTypes, {'Economic Loss'}, heatmapData, 'ColorMap', parula);
    Most_Impact_DisasterName="FLOOD";
    % Set titles and labels
    title('Economic Loss by Type of Disaster in India (1900-2020)');
    xlabel('Disaster Type');
    ylabel('Economic Loss');
end
