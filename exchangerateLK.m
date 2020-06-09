function [rates] = exchangerateLK(dates, curr)
%This function calls an API to obtain current and historic exchange rates. 
%It was created to allow respondents to price options in their own
%currency, before standardizing to one (here, USD). Input arguments are 
%date (1-D datetime array) and currency chosen by participants (1-D cell
%array). Output is rates (misnomer, rather the equivalence) to the USD,
%which can then be used to convert prices. 
%L. Loued-Khenissi, Université de Genève, ToPLaB, 08 juin, 2020

rates = [];
for j = 1:length(dates)
forexURL = 'http://data.fixer.io/api/';
date = dates(j)
thisCurr = curr(j)
% date = datetime
% date.Format = 'yyyy-MM-dd
%check your datetime format
formatOut = 'yyyy-mm-dd';
dateasstr = datestr(date,formatOut)

%Get yourself an API Key from website ^^; it's necessary
forexWriteURL = [forexURL dateasstr '?access_key=a857e8b4c3acea35c372c20be7ca9941'];
writeApiKey = 'a857e8b4c3acea35c372c20be7ca9941';
response = webwrite(forexWriteURL,'api_key',writeApiKey)


yield = struct2table(response.rates) 
currAll =  yield.Properties.VariableNames
currMatch = [];

%You can change your baserate below (e.g. 'EUR' instead of 'USD')
if strcmp(curr(j), 'USD')
    rates(j) = 1
else
    for k = 1:length(currAll)
    if strfind(char(thisCurr), currAll(k))
    rates(j) = yield(1,k).Variables
    end
    end
end

end
