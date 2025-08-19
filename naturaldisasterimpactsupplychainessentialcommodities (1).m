function [Most_Impact_DisasterName,sorted_years_by_percentages,high_disaster_years,low_disaster_years,essencom_high,essencom_low,MostImportantEssentialCommodities]=naturaldisasterimpactsupplychainessentialcommodities(dataFile,filename1,filename2)
 [Most_Impact_DisasterName]=plotEconomicLossHeatmap(dataFile);
[ sorted_index,sorted_years_by_percentages] = plotDamagesPieChart3(filename1);
[high_disaster_years,low_disaster_years]=separateTopBottomYears(sorted_index);
  [essencom_high]=rankEssentialCommodities1(filename2, high_disaster_years);

  [essencom_low]=rankEssentialCommodities2(filename2,low_disaster_years);
   [MostImportantEssentialCommodities]=identifyEssentialCommodities1(essencom_high, essencom_low);



  

end
