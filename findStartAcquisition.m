
function StartAcquisition = findStartAcquisition(filename)
% find the time (HH.MM) when Acquisition started from a Neuralynx
% CheetachLogFile name
%  e.g., StartAcquisition = findStartAcquisition('CheetahLogFile.txt')

FID = fopen(filename, 'r');
FID = fopen('CheetahLogFile.txt', 'r');

Data = textscan(FID, '%s');   % read as cell array of character vectors
CStr = Data{1};
fclose(FID);

IndexC = strfind(CStr, 'StartAcquisition');
Index = find(~cellfun('isempty', IndexC));

Time = CStr(Index+7,:);
Time2 = Time{:}; Time3= Time2(1:5);
sc =  strfind(Time3,':');
Time3(sc) = '.';
StartAcquisition = str2num(Time3);

    