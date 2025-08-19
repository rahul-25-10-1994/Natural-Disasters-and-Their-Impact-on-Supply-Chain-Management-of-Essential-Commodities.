function [ sorted_index,sorted_years_by_percentages] = plotDamagesPieChart3(filename1)
    % plotDamagesPieChart generates a pie chart of total damages per year
    % based on the CSV data in the provided filename. It also returns the
    % sorted years and their corresponding percentages.
    warning('off', 'all');
    % Input:
    %   filename - A string representing the CSV file path
    %
    % Output:
    %   percentages_dam   - The calculated percentages of damages by year
    %   sorted_years      - The years sorted by their damage percentage
    %   sorted_percentages - The sorted percentages of damages

    % Read the CSV file into a table
    data = readtable(filename1);
    
    % Extract the Year and Total Damages columns
    years = data.Year;
    total_damages = data.TotalDamages;
    
    % Calculate the overall total damages
    overall_total = sum(total_damages);

    % Calculate percentages
    percentages = (total_damages / overall_total) * 100;
    percentages_dam = percentages;
    indices ={'INDEX2013', 'INDEX2014','INDEX2015', 'INDEX2016','INDEX2017','INDEX2018', 'INDEX2019', 'INDEX2020'}; % Index columns
    % Sort the data by percentages in descending order
    [~, sort_idx] = sort(percentages, 'descend');
    sorted_years = years(sort_idx);
    sorted_years_by_percentages=sorted_years';
    sorted_index=indices(sort_idx);
    % Create a pie chart for total damage percentages (unsorted)
    figure;
    pie(percentages);
    title('Percentage of Total Damages by Year');

    % Set year labels for the pie chart
    yearLabels = arrayfun(@(x, p) sprintf('%d (%.2f%%)', x, p), years, percentages, 'UniformOutput', false);
    
    % Update the legend to show the year and percentage
    legend(yearLabels, 'Location', 'bestoutside');
end
