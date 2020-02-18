function tf = loadKielDelayScan(filefolder)
%LOADKIELDELAYSCAN loads TrARPES data acquired by the HHG system in M.Bauer's 
%    group in Kiel University.
%    
%    last edited by Xiang @ 05/09/2019

%% set up folders and subruns
if nargin==0
    % use a dialog to specify data folder
    filefolder = uigetdir;
end
% Subrun folders are named as ./*. Durchlauf
SubrunList = dir(fullfile(filefolder,'*. Durchlauf')); 
NSubruns = length(SubrunList);

%% Set up delay list
% by data names
% Here it seems like each subrun folder contains the same delay list names.
% each subrun contains at least one cycle.
if NSubruns >=1
    dataListAll = dir(fullfile(filefolder,SubrunList(1).name,'*.asc'));
    dataListOneCycle = dir(fullfile(filefolder,SubrunList(1).name,'*_1.asc'));
    % to check if there are multiple cycles;
    NCycles = length(dataListAll)./length(dataListOneCycle);
    % generate and sort the delaylist cell for each cycle
    if NCycles > 1
        dataListAll = reshape(dataListAll,NCycles,[])';
    end
    [delaySeries,delaySeriesIndex] = sort(cell2mat(cellfun(@(x) str2double(x(1:end-6)),{dataListOneCycle.name},'UniformOutput',false)),'descend');    
    delaySeries = delaySeries*(-2/3);
    NDelays = length(delaySeries);
    dataListAll = dataListAll(delaySeriesIndex,:); % regularized datalist for one subrun
else
    tf = -1;
    return;
end

%% Constant for defination of ROI for ARPES Image //specified by GRoh
AngleLeft = 220;
AngleRight = 790;
NAngle = AngleRight - AngleLeft + 1;
EnergyBottom = 200;
EnergyTop = 1150;
NEnergy = EnergyTop - EnergyBottom + 1; 

%% Constants for scaling //specified by GRoh
EScFac = 0.000151124;   %
EnergyMid = 687.5;
AngleMid = 511.5;       %
EPass = 50;             % Pass energy
EKin = 18.2;            % Modify it as necessary
Ed = EScFac*EPass;
Ad = 0.0526;            % Need to be checked

%% Load data
% initiation
data.value = zeros(NAngle,NEnergy,NDelays);

for ii = 1:NSubruns
    for jj = 1:NCycles
        for kk = 1:NDelays
            try
                filePath = fullfile(filefolder,SubrunList(ii).name,dataListAll(kk,jj).name);
                buffer = importKielSpecs(filePath);
                disp([num2str(ii),',',num2str(jj),',',num2str(kk),' loaded']);
                data.value(:,:,kk) = data.value(:,:,kk) + buffer([AngleLeft:AngleRight],[EnergyBottom:EnergyTop]);
            catch
                break;
            end
        end
    end
end

data.x = linspace((AngleLeft-AngleMid)*Ad,(AngleRight-AngleMid)*Ad, NAngle);
data.y = linspace((EnergyBottom-EnergyMid)*Ed,(EnergyTop-EnergyMid)*Ed,NEnergy);
data.z = delaySeries;

%% normalize data
% define normalize area;
NyStart = 745;
NyEnd = 890;
NxStart = 177;
NxEnd = 407;
data.normalizeFactor = squeeze(sum(sum(data.value(NxStart:NxEnd,NyStart:NyEnd,:))))';
normalizeFactor = permute(repmat(data.normalizeFactor,[571,1,951]),[1,3,2]);
data.value = data.value./normalizeFactor;

assignin('base','data',data);
tf = true;

