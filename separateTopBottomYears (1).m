function[high_disaster_years,low_disaster_years]=separateTopBottomYears(data)
    % This function takes a matrix or table 'data' and displays the top 4 
    % and bottom 4 disaster years based on the percentage values.
    
    l=length(data);
    
    % Extract columns for top 4 indices (highest disaster years)
    high_disaster_years = data(1:4);
    
    % Extract columns for bottom 4 indices (lowest disaster years)
    low_disaster_years = data(l-3:l);
    
    % Display the data for top and bottom indices
    %disp('Top 4 high disaster years:');
    %disp(high_disaster_years);
    
    %disp('Bottom 4 low disaster years:');
    %disp(low_disaster_years);
end
