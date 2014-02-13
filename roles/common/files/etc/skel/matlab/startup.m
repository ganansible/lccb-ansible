function startup
%startup file to execute the defaults
%current defaults: cd to matlab-home

mroot = [getenv('HOME'),filesep,'matlab'];

setenv('PATH', [getenv('PATH') ':/usr/local/bin']);
if isunix && ~ismac
    setenv('LD_LIBRARY_PATH', ['/usr/lib:' getenv('LD_LIBRARY_PATH')]);
end


try    
    %Check if IDAC user
    idacDir = [getenv('HOME') filesep 'files' filesep 'CellBiology' filesep 'IDAC' filesep 'Code' filesep 'IDAC_svn'];
    if exist(idacDir,'dir')
        %If so, run the IDAC defaults file
        run([idacDir filesep 'idacDefaults.m'])        
    else
        defaults;
    end
    cd(mroot);                
catch errMsg
    %report error, but do not kill matlabrc
    disp('There was a problem changing your directory to HOME:')
    disp(errMsg.message);
    disp('')
    disp('Please make sure of the following:')
    disp('  - have you copied the matlabStandardFiles to your matlab/toolbox/local directory?')
    disp('  - have you set an environment variable HOME, containing the path where your matlab workdirectory is stored?')
    disp('  - this path should contain neither ''matlab'' nor end in a fileseparator')
    disp('  - if you are not logged in onto the domain: have you made sure that the network drives are all connected?')
    disp('')
    disp('If all of the above suggestions don''t help (remember to restart matlab after changing!), contact your caring sysadmin.')
end
