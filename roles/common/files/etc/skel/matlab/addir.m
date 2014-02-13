function addir(dirName)
%ADDIR adds the subdirectories in the matlab HOME to the matlab path
%
%is about ten times faster than the previous implementation
%
%c: 2/04 jonas, 
% Sebastien Besson, last modified Jan 2012

% initialize dir list
dirListLength     = 1000;
dirList           = cell(dirListLength,1);
dirList{1} = dirName;

% initialize counter
checkDirCt = 1;
dirListCt  = 1;
more2check = 1;

% check every directory in dirList for subdirs and whether
% those are to be added to the list
while more2check
    
    % build list of subdirectories
    subDirList = dir(dirList{checkDirCt});
    subDirList = subDirList([subDirList.isdir]);
    
    % Excluding certain directories from the path
    dotDirs = strcmp({subDirList.name},'.') | strcmp({subDirList.name},'..');
    svnDirs =  strcmp({subDirList.name},'.svn');

    nonPathDirs =  strcmp({subDirList.name},'private') |...
        cellfun(@any,regexp({subDirList.name},'^@(.+)')) | ... % Matlab class folder
        cellfun(@any,regexp({subDirList.name},'^\+(.+)')); % Matlab
    
    % loop through all the good entries
    for i = find(~dotDirs & ~svnDirs & ~nonPathDirs)
        subDirName = subDirList(i).name;
        dirListCt = dirListCt + 1;
        
        % make sure that the dirList is long enough
        if dirListCt > dirListLength
            tmpDirList = dirList;
            newDirListLength = dirListLength + dirListInitLength;
            dirList = cell(newDirListLength,1);
            dirList(1:dirListLength) = tmpDirList;
            dirListLength = newDirListLength;
        end
        
        % write into list
        dirList{dirListCt} = [dirList{checkDirCt},filesep,subDirName];
    end 
    
    % all subdirs have now been added.Update the checkDirCt
    checkDirCt = checkDirCt+1;    
    %check whether there is more to check
    more2check = ~isempty(dirList{checkDirCt});
end 

% add at beginning
addpath(dirList{1:dirListCt});
% newPath = [dirList{1:dirListCt}];
% %add at beginning
% path(newPath,path);
